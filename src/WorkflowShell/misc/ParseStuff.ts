import Command from "../models/Command";
import Logger from "../util/Logger";
const csv = require("fast-csv");
const path = require("path");
const fs = require("fs");

import SnsToEndpointLink from "../models/SnsToEndpointLink";
import ClientConfiguration from "../models/ClientConfiguration";
import { ClientConfigurationBuilder } from "../models/ClientConfiguration";

const logger: Logger = new Logger("ParseStuff");

export default class ParseStuff extends Command {

  static getString(): string {
    return "ps";
  }

  static getDescription(): string {
    return "...";
  }

  getUsage(): string {
    return ParseStuff.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const deliveryConfigurationFile: string = args._.shift();
    if (!deliveryConfigurationFile) {
      logger.log("You MUST specify the deliveryConfiguration file!");
      this.printHelp();
      return false;
    }

    const accountConfigurationFile: string = args._.shift();
    if (!accountConfigurationFile) {
      logger.log("You MUST specify the accountConfiguration file!");
      this.printHelp();
      return false;
    }

    const subscriptionsJsonFile: string = args._.shift();
    if (!subscriptionsJsonFile) {
      logger.log("You MUST specify the subscriptionsJson file!");
      this.printHelp();
      return false;
    }

    // const [deliveryConfigurations, accountConfigurations] = Promise.all(
    //   this.parseDeliveryConfigurations(deliveryConfigurationFile),
    //   this.parseAccountConfigurations(accountConfigurationFile));

    const deliveryConfigurations = await this.parseDeliveryConfigurations(deliveryConfigurationFile);
    // logger.log(`Delivery Configurations: ${JSON.stringify(deliveryConfigurations)}`);


    const accountConfigurations = await this.parseAccountConfigurations(accountConfigurationFile);
    // logger.log(`Parsed account configurationgs: ${JSON.stringify(accountConfigurations)}`);


    // const jsonPath = path.resolve(__dirname, subscriptionsJsonFile);
    const subscriptions = JSON.parse(fs.readFileSync(subscriptionsJsonFile, "utf8")).Subscriptions;

    const snsToLambdaLinks: SnsToEndpointLink[] = [];
    subscriptions.forEach((subscription) => {
      const sns: string = subscription.TopicArn.split(/[:]+/).pop();
      const lambda: string = subscription.Endpoint.split(/[:]+/).pop();
      snsToLambdaLinks.push(new SnsToEndpointLink(sns, lambda));
    });

    const configuredClients = {};
    for (const configurationId in accountConfigurations) {
      if (Object.prototype.hasOwnProperty.call(accountConfigurations, configurationId)) {
        const clientConfigurationBuilder = new ClientConfigurationBuilder();

        clientConfigurationBuilder.setConfigurationId(configurationId);
        clientConfigurationBuilder.setAccountId(accountConfigurations[configurationId]);

        const deliveryConfiguration = deliveryConfigurations[configurationId];
        if (deliveryConfiguration) {
          clientConfigurationBuilder.setName(deliveryConfiguration.name.S);
          if (deliveryConfiguration.deliveryValues.L) {
            deliveryConfiguration.deliveryValues.L.forEach((value) => {
              if (value.M.fieldName.S === "source") {
                clientConfigurationBuilder.setSource(value.M.fieldValue.S);
              }
            });
          }

          clientConfigurationBuilder.setDeliveryMethodName = deliveryConfiguration.deliveryMethod.M.name.S;
          clientConfigurationBuilder.setDeliveryMethodId = deliveryConfiguration.deliveryMethod.M.id.S;

          const links: string[] = [];
          snsToLambdaLinks.forEach((link) => {
            // logger.log(`LINK: ${JSON.stringify(link)}`);
            if (link.snsArn === clientConfigurationBuilder.deliveryMethodName) {
              links.push(link.toString());
            }
          });
          clientConfigurationBuilder.setLinks(links);

          // logger.log(`CLIENT LINKS: ${client.links}`);
        } else {
          logger.log(`Delivery Configuration not found for configuration ID: ${configurationId}`);
        }
        configuredClients[configurationId] = clientConfigurationBuilder.build();
      }
    }

    logger.log(`Will Collate data.`);
    // logger.log(`Configured Clients: ${JSON.stringify(configuredClients)}`);

    const stream = fs.createWriteStream("Account -> Lambda Summary.csv");
    // stream.once('Collated.csv', (fd) => {
    stream.write("Configuration ID, Account ID, Name, Source, Delivery Method Name, Delivery Method ID, SNS -> Lambda links...\n");
    for (const configurationId in configuredClients) {
      if (Object.prototype.hasOwnProperty.call(configuredClients, configurationId)) {
        const client: ClientConfiguration = configuredClients[configurationId];
        stream.write(`${client.configurationId}, ${client.accountId}, ${client.name}, ${client.source}, ` +
          `${client.deliveryMethodName}, ${client.deliveryMethodId}`);
        if (client.links) {
          client.links.forEach((link) => {
            stream.write(`, ${link}`);
          });
        }
        stream.write("\n");
      }
    }
    stream.end();

    return true;
  }

  async parseDeliveryConfigurations(deliveryConfigurationFile) {
    const deliveryConfigurations = {};
    const promiseWrapper = (resolve, reject) => {
      const saveValue = (data) => {
        try {
          deliveryConfigurations[data[0]] = JSON.parse(data[1]);
        } catch (error) {
          logger.log(`Could not parse line: ${JSON.stringify(data)}`);
        }
      };
      const doneParsing = () => {
        logger.log("done parsing delivery configurations");
        resolve(deliveryConfigurations);
      };
      csv.fromPath(deliveryConfigurationFile)
        .on("data", saveValue)
        .on("end", doneParsing);
    };
    return new Promise(promiseWrapper);
  }

  async parseAccountConfigurations(accountConfigurationFile) {
    const accountConfigurations = {};
    const promiseWrapper = (resolve, reject) => {
      const saveValue = (data) => {
        try {
          accountConfigurations[data[1]] = data[0];
        } catch (error) {
          logger.log(`Could not parse line: ${JSON.stringify(data)}`);
        }
      };
      const doneParsing = () => {
        logger.log("done parsing account configurations");
        resolve(accountConfigurations);
      };
      csv.fromPath(accountConfigurationFile)
        .on("data", saveValue)
        .on("end", doneParsing);
    };
    return new Promise(promiseWrapper);
  }
}
