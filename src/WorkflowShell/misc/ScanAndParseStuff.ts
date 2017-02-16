import Command from "../models/Command";
import Logger from "../util/Logger";
import * as csv from "fast-csv";
import * as path from "path";
import * as fs from "fs";
import * as AWS from "aws-sdk";

import ClientConfiguration from "../models/ClientConfiguration";
import SnsToEndpointLink from "../models/SnsToEndpointLink";
import { ClientConfigurationBuilder } from "../models/ClientConfiguration";
const logger: Logger = new Logger("ScanAndParseStuff");

export default class ScanAndParseStuff extends Command {

  static getString(): string {
    return "sps";
  }

  static getDescription(): string {
    return "...";
  }

  getUsage(): string {
    return ScanAndParseStuff.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    let deliveryConfigurationTable = args._.shift();
    if (!deliveryConfigurationTable) {
      deliveryConfigurationTable = "DeliveryConfiguration";
      logger.log(`DeliveryConfiguration table was not specified. Will use default: ${deliveryConfigurationTable}`);
    }

    let accountConfigurationTable = args._.shift();
    if (!accountConfigurationTable) {
      accountConfigurationTable = "DeliveryConfigurationAccounts";
      logger.log(`DeliveryConfigurationAccounts table was not specified. Will use default: ${accountConfigurationTable}`);
    }

    AWS.config.update({ region: "us-east-1" });
    const docClient = new AWS.DynamoDB.DocumentClient();

    const deliveryConfigurationParameters = { TableName: deliveryConfigurationTable };
    logger.log(`Scanning ${deliveryConfigurationTable}...`);
    const deliveryConfigurationsArray = await this.scanTable(deliveryConfigurationParameters, docClient);

    const deliveryConfigurations = {};
    deliveryConfigurationsArray.forEach((deliveryConfiguration) => {
      deliveryConfigurations[deliveryConfiguration.id] = deliveryConfiguration;
    });

    const accountConfigurationParameters = { TableName: accountConfigurationTable };
    logger.log(`Scanning ${accountConfigurationTable}...`);
    const accountConfigurations = await this.scanTable(accountConfigurationParameters, docClient);

    const sns = new AWS.SNS();
    logger.log(`Retrieving all subscriptions...`);
    const subscriptions = await this.listSubscriptions(sns);

    const snsToLambdaLinks: SnsToEndpointLink[] = [];
    subscriptions.forEach((subscription) => {
      const snsArn = subscription.TopicArn.split(/[:]+/).pop();
      const endpoint = subscription.Endpoint.split(/[:]+/).pop();
      snsToLambdaLinks.push(new SnsToEndpointLink(snsArn, endpoint));
    });

    const configuredClients = {};
    accountConfigurations.forEach((accountConfiguration) => {
      const clientConfigurationBuilder = new ClientConfigurationBuilder();
      clientConfigurationBuilder.setConfigurationId(accountConfiguration.configurationId);
      clientConfigurationBuilder.setAccountId(accountConfiguration.accountId);

      const configurationHolder = deliveryConfigurations[clientConfigurationBuilder.configurationId];
      if (configurationHolder) {
        const deliveryConfiguration = configurationHolder.deliveryConfiguration;
        if (deliveryConfiguration) {
          clientConfigurationBuilder.setName(deliveryConfiguration.name);
          clientConfigurationBuilder.setSource(deliveryConfiguration.deliveryValues.Source);
          clientConfigurationBuilder.setDeliveryMethodName(deliveryConfiguration.deliveryMethod.name);
          clientConfigurationBuilder.setDeliveryMethodId(deliveryConfiguration.deliveryMethod.id);
          const links: string[] = [];

          snsToLambdaLinks.forEach((link) => {
            if (link.snsArn === clientConfigurationBuilder.deliveryMethodName) {
              links.push(link.toString());
            }
          });
          clientConfigurationBuilder.setLinks(links);
        } else {
          logger.log(`Delivery Configuration not found for configuration ID: ${clientConfigurationBuilder.configurationId}`);
        }
      }
      configuredClients[clientConfigurationBuilder.configurationId] = clientConfigurationBuilder.build();
    });

    logger.log(`Collating data...`);
    const stream = fs.createWriteStream("Account -> Lambda Summary.csv");
    stream.write("Configuration ID, Account ID, Name, Source, Delivery Method Name, Delivery Method ID, SNS -> Lambda links...\n");
    for (const configurationId in configuredClients) {
      if (Object.prototype.hasOwnProperty.call(configuredClients, configurationId)) {
        const client = configuredClients[configurationId];
        stream.write(`"${client.configurationId}", "${client.accountId}", "${client.name}", "${client.source}", "` +
          `${client.deliveryMethodName}", "${client.deliveryMethodId}"`);
        if (client.links) {
          client.links.forEach((link) => {
            stream.write(`, "${link}"`);
          });
        }
        stream.write("\n");
      }
    }
    stream.end();

    logger.log(`Done!`);
    return true;
  }

  async listSubscriptions(sns, parameters?: any): Promise<any[]> {
    const promiseWrapper = (resolve, reject) => {
      let subscriptions = [];
      const saveSubscription = async (err, data) => {
        if (err) {
          console.error(`Unable to retrieve subscriptions. Error JSON: ${JSON.stringify(err, null, 2)}`);
          reject(err);
        } else {
          subscriptions = subscriptions.concat(data.Subscriptions);

          if (data.NextToken) {
            parameters.NextToken = data.NextToken;
            const moreSubscriptions = await this.listSubscriptions(sns, parameters);
            if (moreSubscriptions) {
              subscriptions = subscriptions.concat(moreSubscriptions);
            }
          }
          resolve(subscriptions);
        }
      };
      sns.listSubscriptions(parameters, saveSubscription);
    };
    return <Promise<any[]>>new Promise(promiseWrapper);
  }


  async scanTable(parameters, docClient): Promise<any[]> {
    const promiseWrapper = (resolve, reject) => {
      let items = [];
      const scanTable = async (err, data) => {
        if (err) {
          console.error(`Unable to scan the table. Error JSON: ${JSON.stringify(err, null, 2)}`);
          reject(err);
        } else {
          items = items.concat(data.Items);

          // continue scanning if we have more items, because
          // scan can retrieve a maximum of 1MB of data
          if (typeof data.LastEvaluatedKey !== "undefined") {
            parameters.ExclusiveStartKey = data.LastEvaluatedKey;
            const moreItems = await this.scanTable(parameters, docClient);
            items = items.concat(moreItems);
          }
          resolve(items);
        }
      };
      docClient.scan(parameters, scanTable);
    };
    return <Promise<any[]>>new Promise(promiseWrapper);
  }
}
