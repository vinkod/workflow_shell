const Ping = require('tcp-ping');
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

  async checkConnection() {
    console.log('Now monitoring connection. Initial ping...');
    const options = { address: 'www.google.com' };
    let isReachable = await this.hostIsReachable(options);
    if (isReachable) {
      console.log('Internet reachable; beginning looped monitoring.');
    }
    while (isReachable) {
      console.log('Internet reachable; Sleeping for 15 seconds...');
      setTimeout(isReachable = await this.hostIsReachable(options), 15000);
    }

  }

  async run(args) {
    super.run(args);
    console.log(`Reachable? ${JSON.stringify(await this.hostIsReachable({ address: 'Asdf' }))}`);

    setInterval(await this.checkConnection, 15000);
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
          resolve(!(data.avg != null));
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
