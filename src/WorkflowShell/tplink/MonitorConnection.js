const Ping = require('tcp-ping');
const net = require('net');
const Command = require('../models/Command');

class MonitorConnection extends Command {

  static getString() {
    return 'tpmc';
  }

  static getDescription() {
    return 'Monitors internet connection and resets the TPLink plug if it goes down.';
  }

  getUsage() {
    return MonitorConnection.getString();
  }

  async checkConnection(host, plugIp, plugPort) {
    console.log('Now monitoring connection. Initial ping...');
    const options = { address: 'www.google.com' };
    let isReachable = await this.hostIsReachable(options);
    if (isReachable) {
      console.log('Internet reachable; beginning looped monitoring.');
    }
    const setReachable = async () => {
      isReachable = await this.hostIsReachable(options);
      return isReachable;
    };
    while (isReachable) {
      console.log('Internet reachable; Sleeping for 15 seconds...');
      setTimeout(setReachable, 10000);
    }

    if (!isReachable) {
      console.log('Internet unreachable; will attempt to reset modem.');
      if (!this.socketClient) {
        this.socketClient = new net.Socket();
      }

      await MonitorConnection.turnOff(plugIp, plugPort, this.socketClient);

      const trurnOn = async () => {
        await MonitorConnection.turnOn(plugIp, plugPort, this.socketClient);
      };
      console.log('Pausing for 10 seconds...');
      setTimeout(trurnOn, 10000);

      const logResume = async () => {
        console.log('Connection monitoring will now resume...');
      };
      console.log('Pausing for 90 seconds...');
      setTimeout(logResume, 90000);
    }
  }

  static async connectClient(plugIp, plugPort, socketClient) {
    const promiseWrapper = (resolve, reject) => {
      const connectedCallback = () => {
        resolve(true);
      };
      const errorCallback = (error) => {
        reject(error);
      };
      socketClient.on('error', errorCallback);
      return socketClient.connect(plugPort, plugIp, connectedCallback);
    };
    return new Promise(promiseWrapper);
  }

  static async writeToClient(message, encoding, socketClient) {
    const promiseWrapper = (resolve, reject) => {
      const callback = (err, result) => {
        if (err) {
          reject(err);
        } else if (result) {
          resolve(result);
        } else {
          reject(result);
        }
      };
      return socketClient.write(message, encoding, callback);
    };
    return new Promise(promiseWrapper);
  }

  static async turnOff(plugIp, plugPort, socketClient) {
    console.log('Turning plug off...');
    const connected = await MonitorConnection.connectClient(plugIp, plugPort, socketClient);
    if (connected) {
      const offResult1 = await this.writeToClient('0000002ad0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381f286e793f6d4eedea3dea3', 'hex', socketClient);
      const offResult2 = await this.writeToClient('0000002dd0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381e496e4bbd8b7d3b694ae9ee39ee3', 'hex', socketClient);
      return Promise.resolve({ offResult1, offResult2 });
    }
    return Promise.reject('Unable to connect to the plug in order to turn it off.');
  }

  static async turnOn(plugIp, plugPort, socketClient) {
    console.log('Turning plug on...');
    const connected = await MonitorConnection.connectClient(plugIp, plugPort, socketClient);
    if (connected) {
      const onResult1 = await this.writeToClient('0000002ad0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381f286e793f6d4eedfa2dfa2', 'hex', socketClient);
      const onResult2 = setTimeout(await this.writeToClient('00000025d0f281e28aef8bfe92f7d5ef94b6d1b4c09ff194ec98c7a6c5b1d8b7d9fbc1afdab6daa7da', 'hex', socketClient), 1000);
      return Promise.resolve({ onResult1, onResult2 });
    }
    return Promise.reject('Unable to connect to the plug in order to turn it ons.');
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    let host = args._.shift();
    if (!host) {
      host = 'www.google.com';
      console.log(`No host specified. Will use '${host}'`);
    }

    let plugIp = args._.shift();
    if (!plugIp) {
      plugIp = '192.168.1.209';
      console.log(`No plug IP specified. Will use '${plugIp}'`);
    }

    let plugPort = args._.shift();
    if (!plugPort) {
      plugPort = 9999;
      console.log(`No plug port specified. Will use '${plugPort}'`);
    }

    setInterval(await this.checkConnection(host, plugIp, plugPort), 1000);
    return true;
  }

  // Let's try to learn how to promisify something manually.
  // First, we'll create our own internal method and label it async.
  async hostIsReachable(options) {

    // Since it's asynchronous, it needs to return a Promise.
    // The promise constructor takes a function with two parameters, each functions.
    // To the first, you pass any successful results.
    // To the second, you pass any error.
    const promiseFunction = (resolve, reject) => {

      // Inside of this function, you call the method you originally intended to use.
      // Typically, it wants a "callback" function. Otherwise, you wouldn't be here.
      const pingCallback = (error, data) => {

        // The signature and behavior of this function will change depending on the situation
        // But it typically follows an error-checking pattern.
        if (error) {
          // However, inside of your logic, instead of just doing real stuff...
          console.log(`ERROR: ${JSON.stringify(error)}`);
          console.log(`ERROR: ${JSON.stringify(data)}`);
          // You also call the promise-function-wrapper-thing's methods when you're done
          reject(error);
        } else {
          // Normal/real stuff goes here.
          console.log(`COMPLETE: ${JSON.stringify(data)}`);
          // If you're successful, pass the result of your logic back with first function
          resolve(data.avg != null);
        }
      };

      // So, call the original function with your promisified callback:
      return Ping.ping(options, pingCallback);
    };

    // Then package it all up into a promise.
    return new Promise(promiseFunction);
  }
}

module.exports = MonitorConnection;
