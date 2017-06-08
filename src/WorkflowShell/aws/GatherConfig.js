const Command = require('../models/Command');
const csv = require('fast-csv');
const path = require('path');
const fs = require('fs');
const AWS = require('aws-sdk');

class GatherConfig extends Command {

  static getString() {
    return 'gatherconfig';
  }

  static getDescription() {
    return '...';
  }

  getUsage() {
    return GatherConfig.getString();
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

    let masterObject = {};
    deliveryConfigurationsArray.forEach((element) => {
      try {
        masterObject = this.copyFields(element, masterObject, element);
      } catch (error) {
        console.log(`Error: ${error.message}`);
        console.log(`Master Object so far: ${JSON.stringify(masterObject)}`);
      }
    }, this);

    const stream = fs.createWriteStream('configCollection.json');
    stream.write(`${JSON.stringify(masterObject, null, 2)}`);
    stream.end();

    console.log(`${this.constructor.name}: Done!`);
    const baseCommand = 'subl configCollection.json';
    return super.execute(baseCommand);
  }

  copyFields(object, masterObject, originalObject) {
    if (!masterObject) {
      masterObject = {};
    }
    Object.keys(object).forEach((key) => {
      if (!isNaN(key)) {
        this.copyFields(object[key], masterObject, originalObject);
        // Object.keys(object[key]).forEach(subKey => {
        //   this.addField(masterObject, subKey, object[key][subKey]);
        // });
      } else if (typeof object[key] === 'object') {
        masterObject[key] = this.copyFields(object[key], masterObject[key], originalObject);
      } else {
        this.addField(masterObject, key, object[key]);
        // masterObject[key] = object[key];
      }
    });
    return masterObject;
  }

  addField(object, key, value) {
    if (!object[key]) {
      object[key] = [value];
    } else if (Array.isArray(object[key])) {
      if (object[key].indexOf(value) < 0) {
        object[key].push(value);
      }
    } else {
      const temp = object[key];
      object[key] = [temp, value];
    }
  }

  async scanTable(parameters, docClient) {
    const promiseWrapper = (resolve, reject) => {
      let items = [];
      const scanTable = async (err, data) => {
        if (err) {
          console.error(`Unable to scan the table.Error JSON: ${JSON.stringify(err, null, 2)}`);
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

module.exports = GatherConfig;
