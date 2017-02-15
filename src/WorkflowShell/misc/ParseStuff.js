const Command = require('../models/Command');
const csv = require('fast-csv');
const path = require('path');
const fs = require('fs');

class ParseStuff extends Command {

  static getString() {
    return 'ps';
  }

  static getDescription() {
    return '...';
  }

  getUsage() {
    return ParseStuff.getString();
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const deliveryConfigurationFile = args._.shift();
    if (!deliveryConfigurationFile) {
      console.log('You MUST specify the deliveryConfiguration file!');
      this.printHelp();
      return false;
    }

    const accountConfigurationFile = args._.shift();
    if (!accountConfigurationFile) {
      console.log('You MUST specify the accountConfiguration file!');
      this.printHelp();
      return false;
    }

    const subscriptionsJsonFile = args._.shift();
    if (!subscriptionsJsonFile) {
      console.log('You MUST specify the subscriptionsJson file!');
      this.printHelp();
      return false;
    }

    // const [deliveryConfigurations, accountConfigurations] = Promise.all(
    //   this.parseDeliveryConfigurations(deliveryConfigurationFile),
    //   this.parseAccountConfigurations(accountConfigurationFile));

    const deliveryConfigurations = await this.parseDeliveryConfigurations(deliveryConfigurationFile);
    // console.log(`${this.constructor.name}: Delivery Configurations: ${JSON.stringify(deliveryConfigurations)}`);


    const accountConfigurations = await this.parseAccountConfigurations(accountConfigurationFile);
    // console.log(`${this.constructor.name}: Parsed account configurationgs: ${JSON.stringify(accountConfigurations)}`);



    // const jsonPath = path.resolve(__dirname, subscriptionsJsonFile);
    const subscriptions = JSON.parse(fs.readFileSync(subscriptionsJsonFile, 'utf8')).Subscriptions;

    const snsToLambdaLinks = [];
    subscriptions.forEach((subscription) => {
      const sns = subscription.TopicArn.split(/[:]+/).pop();
      const lambda = subscription.Endpoint.split(/[:]+/).pop();
      snsToLambdaLinks.push({ sns, lambda });
    });

    const configuredClients = {};
    for (const configurationId in accountConfigurations) {
      if (Object.prototype.hasOwnProperty.call(accountConfigurations, configurationId)) {
        const client = {};
        client.configurationId = configurationId;
        client.accountId = accountConfigurations[configurationId];

        const deliveryConfiguration = deliveryConfigurations[configurationId];
        if (deliveryConfiguration) {
          client.name = deliveryConfiguration.name.S;
          if (deliveryConfiguration.deliveryValues.L) {
            deliveryConfiguration.deliveryValues.L.forEach((value) => {
              if (value.M.fieldName.S === 'source') {
                client.source = value.M.fieldValue.S;
              }
            });
          }

          client.deliveryMethodName = deliveryConfiguration.deliveryMethod.M.name.S;
          client.deliveryMethodId = deliveryConfiguration.deliveryMethod.M.id.S;
          client.links = [];

          snsToLambdaLinks.forEach((link) => {
            // console.log(`${this.constructor.name}: LINK: ${JSON.stringify(link)}`);
            if (link.sns === client.deliveryMethodName) {
              client.links.push(`${link.sns} -> ${link.lambda}`);
            }
          });
          // console.log(`${this.constructor.name}: CLIENT LINKS: ${client.links}`);
        } else {
          console.log(`${this.constructor.name}: Delivery Configuration not found for configuration ID: ${configurationId}`);
        }
        configuredClients[configurationId] = client;

      }
    }

    console.log(`${this.constructor.name}: Will Collate data.`);
    // console.log(`${this.constructor.name}: Configured Clients: ${JSON.stringify(configuredClients)}`);

    const stream = fs.createWriteStream('Account -> Lambda Summary.csv');
    // stream.once('Collated.csv', (fd) => {
    stream.write('Configuration ID, Account ID, Name, Source, Delivery Method Name, Delivery Method ID, SNS -> Lambda links...\n');
    for (const configurationId in configuredClients) {
      if (Object.prototype.hasOwnProperty.call(configuredClients, configurationId)) {
        const client = configuredClients[configurationId];
        stream.write(`${client.configurationId}, ${client.accountId}, ${client.name}, ${client.source}, ` +
          `${client.deliveryMethodName}, ${client.deliveryMethodId}`);
        if (client.links) {
          client.links.forEach((link) => {
            stream.write(`, ${link}`);
          });
        }
        stream.write('\n');
      }
    }
    stream.end();
    // });


    // const baseCommand = 'browser-sync start --server --directory --files "**/*"';
    // return super.execute(baseCommand);
  }

  async parseDeliveryConfigurations(deliveryConfigurationFile) {
    const deliveryConfigurations = {};
    const promiseWrapper = (resolve, reject) => {
      const saveValue = (data) => {
        try {
          deliveryConfigurations[data[0]] = JSON.parse(data[1]);
        } catch (error) {
          console.log(`${this.constructor.name}: Could not parse line: ${JSON.stringify(data)}`);
        }
      };
      const doneParsing = () => {
        console.log('done parsing delivery configurations');
        resolve(deliveryConfigurations);
      };
      csv.fromPath(deliveryConfigurationFile)
        .on('data', saveValue)
        .on('end', doneParsing);
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
          console.log(`${this.constructor.name}: Could not parse line: ${JSON.stringify(data)}`);
        }
      };
      const doneParsing = () => {
        console.log('done parsing account configurations');
        resolve(accountConfigurations);
      };
      csv.fromPath(accountConfigurationFile)
        .on('data', saveValue)
        .on('end', doneParsing);
    };
    return new Promise(promiseWrapper);
  }

  // static async writeToClient(message, encoding, socketClient) {
  //   const promiseWrapper = (resolve, reject) => {
  //     const callback = (error, result) => {
  //       if (error) {
  //         console.error(`Error writing to client: ${JSON.stringify(result)}`);
  //         reject(error);
  //       } else if (result) {
  //         resolve(result);
  //         console.error(`Connection failed: ${JSON.stringify(result)}`);
  //         reject(result);
  //       }
  //     };
  //     return socketClient.write(message, encoding, callback);
  //   };
  //   return new Promise(promiseWrapper);
  // }
}

module.exports = ParseStuff;
