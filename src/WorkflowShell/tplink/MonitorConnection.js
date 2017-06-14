// const Ping = require('tcp-ping');
// const net = require('net');
// // const Sleep = require('sleep');

// const TPLinkUtil = require('./util/TPLinkUtil');
// const Command = require('../models/Command');

// class MonitorConnection extends Command {

//   static getString() {
//     return 'tpmc';
//   }

//   static getDescription() {
//     return 'Monitors internet connection and resets the TPLink plug if it goes down.';
//   }

//   getUsage() {
//     return MonitorConnection.getString();
//   }

//   async checkConnection(host, plugIp, plugPort) {
//     console.log('Now monitoring connection. Initial ping...');
//     const options = { address: host };
//     let isReachable = await this.hostIsReachable(options);
//     if (isReachable) {
//       console.log('Internet reachable; beginning looped monitoring.');
//     }

//     while (isReachable) {
//       console.log('Internet reachable; Sleeping for 15 seconds...');
//       // Sleep.sleep(15);
//       console.log('Testing connection...');
//       isReachable = await this.hostIsReachable(options);
//     }

//     console.log('Internet unreachable; will attempt to reset modem.');
//     const socketClient = new net.Socket();

//     try {
//       console.log('Turning plug off...');
//       await TPLinkUtil.turnOff(plugIp, plugPort, socketClient);
//     } catch (error) {
//       console.log(`Failed to turn plug off: ${JSON.stringify(error)}`);
//     }

//     console.log('Pausing for 10 seconds...');
//     // Sleep.sleep(10);

//     try {
//       console.log('Turning plug on...');
//       await TPLinkUtil.turnOn(plugIp, plugPort, socketClient);
//     } catch (error) {
//       console.log(`Failed to turn plug on: ${JSON.stringify(error)}`);
//     }
//   }

//   async run(args) {
//     const ok = super.run(args);
//     if (!ok) {
//       return false;
//     }

//     let host = args._.shift();
//     if (!host) {
//       host = 'www.google.com';
//       console.log(`No host specified. Will use '${host}'`);
//     }

//     let plugIp = args._.shift();
//     if (!plugIp) {
//       plugIp = '192.168.1.209';
//       console.log(`No plug IP specified. Will use '${plugIp}'`);
//     }

//     let plugPort = args._.shift();
//     if (!plugPort) {
//       plugPort = 9999;
//       console.log(`No plug port specified. Will use '${plugPort}'`);
//     }

//     const forever = true;
//     while (forever) {
//       await this.checkConnection(host, plugIp, plugPort);
//       Sleep.sleep(90);
//     }

//     return true;
//   }

//   // Let's try to learn how to promisify something manually.
//   // First, we'll create our own internal method and label it async.
//   async hostIsReachable(options) {

//     // Since it's asynchronous, it needs to return a Promise.
//     // The promise constructor takes a function with two parameters, each functions.
//     // To the first, you pass any successful results.
//     // To the second, you pass any error.
//     const promiseFunction = (resolve, reject) => {

//       // Inside of this function, you call the method you originally intended to use.
//       // Typically, it wants a "callback" function. Otherwise, you wouldn't be here.
//       const pingCallback = (error, data) => {

//         // The signature and behavior of this function will change depending on the situation
//         // But it typically follows an error-checking pattern.
//         if (error) {
//           // However, inside of your logic, instead of just doing real stuff...
//           console.log(`ERROR: ${JSON.stringify(error)}`);
//           console.log(`ERROR: ${JSON.stringify(data)}`);
//           // You also call the promise-function-wrapper-thing's methods when you're done
//           reject(error);
//         } else {
//           // Normal/real stuff goes here.
//           console.log(`COMPLETE: ${JSON.stringify(data)}`);
//           const successful = (data.max !== undefined);
//           console.log(`will resolve: ${successful}`);
//           // If you're successful, pass the result of your logic back with first function
//           resolve(successful);
//         }
//       };

//       // So, call the original function with your promisified callback:
//       return Ping.ping(options, pingCallback);
//     };

//     // Then package it all up into a promise.
//     return new Promise(promiseFunction);
//   }
// }

// module.exports = MonitorConnection;
