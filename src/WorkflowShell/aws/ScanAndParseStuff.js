const Command = require('../models/Command');
const csv = require('fast-csv');
const path = require('path');
const fs = require('fs');
const AWS = require('aws-sdk');

class ScanAndParseStuff extends Command {

  static getString() {
    return 'sps';
  }

  static getDescription() {
    return '...';
  }

  getUsage() {
    return ScanAndParseStuff.getString();
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    let deliveryConfigurationTable = args._.shift();
    if (!deliveryConfigurationTable) {
      deliveryConfigurationTable = process.env.DELIVERY_CONFIGURATION;
      console.log(`DeliveryConfiguration table was not specified. Will use default: ${deliveryConfigurationTable}`);
    }
    if (!deliveryConfigurationTable) {
      throw new Error('No account configuration table specified');
    }

    let accountConfigurationTable = args._.shift();
    if (!accountConfigurationTable) {
      accountConfigurationTable = process.env.DELIVERY_CONFIGURATION_ACCOUNTS;
      console.log(`DeliveryConfigurationAccounts table was not specified. Will use default: ${accountConfigurationTable}`);
    }
    if (!accountConfigurationTable) {
      throw new Error('No account configuration table specified');
    }

    AWS.config.update({ region: 'us-east-1' });
    const docClient = new AWS.DynamoDB.DocumentClient();

    const deliveryConfigurationParameters = { TableName: deliveryConfigurationTable };
    console.log(`${this.constructor.name}: Scanning ${deliveryConfigurationTable}...`);
    const deliveryConfigurationsArray = await this.scanTable(deliveryConfigurationParameters, docClient);

    const deliveryConfigurations = {};
    deliveryConfigurationsArray.forEach((deliveryConfiguration) => {
      deliveryConfigurations[deliveryConfiguration.id] = deliveryConfiguration;
    });

    const accountConfigurationParameters = { TableName: accountConfigurationTable };
    console.log(`${this.constructor.name}: Scanning ${accountConfigurationTable}...`);
    const accountConfigurations = await this.scanTable(accountConfigurationParameters, docClient);

    const sns = new AWS.SNS();
    console.log(`${this.constructor.name}: Retrieving all subscriptions...`);
    const subscriptions = await this.listSubscriptions(sns);

    const snsToLambdaLinks = [];
    subscriptions.forEach((subscription) => {
      const snsArn = subscription.TopicArn.split(/[:]+/).pop();
      const endpoint = subscription.Endpoint.split(/[:]+/).pop();
      snsToLambdaLinks.push({ snsArn, endpoint });
    });

    const configuredClients = {};
    accountConfigurations.forEach((accountConfiguration) => {
      const client = {};
      client.configurationId = accountConfiguration.configurationId;
      client.accountId = accountConfiguration.accountId;

      const configurationHolder = deliveryConfigurations[client.configurationId];
      if (configurationHolder) {
        const deliveryConfiguration = configurationHolder.deliveryConfiguration;
        if (deliveryConfiguration) {
          client.name = deliveryConfiguration.name;
          client.source = deliveryConfiguration.deliveryValues.Source;

          client.deliveryMethodName = deliveryConfiguration.deliveryMethod.name;
          client.deliveryMethodId = deliveryConfiguration.deliveryMethod.id;
          client.links = [];

          snsToLambdaLinks.forEach((link) => {
            if (link.snsArn === client.deliveryMethodName) {
              client.links.push(`${link.snsArn} -> ${link.endpoint}`);
            }
          });

        } else {
          console.log(`${this.constructor.name}: Delivery Configuration not found for configuration ID: ${client.configurationId}`);
        }
      }
      configuredClients[client.configurationId] = client;
    });

    console.log(`${this.constructor.name}: Collating data...`);
    const stream = fs.createWriteStream('Account -> Lambda Summary.csv');
    stream.write('Configuration ID, Account ID, Name, Source, Delivery Method Name, Delivery Method ID, SNS -> Lambda links...\n');
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
        stream.write('\n');
      }
    }
    stream.end();

    console.log(`${this.constructor.name}: Done!`);
  }

  async listSubscriptions(sns, parameters = {}) {
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
    return new Promise(promiseWrapper);
  }


  async scanTable(parameters, docClient) {
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
          if (typeof data.LastEvaluatedKey !== 'undefined') {
            parameters.ExclusiveStartKey = data.LastEvaluatedKey;
            const moreItems = await this.scanTable(parameters, docClient);
            items = items.concat(moreItems);
          }
          resolve(items);
        }
      };
      docClient.scan(parameters, scanTable);
    };
    return new Promise(promiseWrapper);
  }
}

module.exports = ScanAndParseStuff;
