const Sleep = require('sleep');

class TPLinkUtil {
  static async turnOff(plugIp, plugPort, socketClient) {
    console.log('Turning plug off...');
    const connected = await TPLinkUtil.connectClient(plugIp, plugPort, socketClient);
    if (connected) {
      const offResult1 = await TPLinkUtil.writeToClient('0000002ad0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381f286e793f6d4eedea3dea3', 'hex', socketClient);
      Sleep.sleep(1000);
      const offResult2 = await TPLinkUtil.writeToClient('0000002dd0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381e496e4bbd8b7d3b694ae9ee39ee3', 'hex', socketClient);
      return Promise.resolve({ offResult1, offResult2 });
    }
    return Promise.reject('Unable to connect to the plug in order to turn it off.');
  }

  static async turnOn(plugIp, plugPort, socketClient) {
    console.log('Turning plug on...');
    const connected = await TPLinkUtil.connectClient(plugIp, plugPort, socketClient);
    if (connected) {
      const onResult1 = await TPLinkUtil.writeToClient('0000002ad0f281f88bff9af7d5ef94b6c5a0d48bf99cf091e8b7c4b0d1a5c0e2d8a381f286e793f6d4eedfa2dfa2', 'hex', socketClient);
      Sleep.sleep(1000);
      const onResult2 = await TPLinkUtil.writeToClient('00000025d0f281e28aef8bfe92f7d5ef94b6d1b4c09ff194ec98c7a6c5b1d8b7d9fbc1afdab6daa7da', 'hex', socketClient);
      return Promise.resolve({ onResult1, onResult2 });
    }
    return Promise.reject('Unable to connect to the plug in order to turn it on.');
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
      const callback = (error, result) => {
        if (error) {
          console.error(`Error writing to client: ${JSON.stringify(result)}`);
          reject(error);
        } else if (result) {
          resolve(result);
        } else {
          console.error(`Connection failed: ${JSON.stringify(result)}`);
          reject(result);
        }
      };
      return socketClient.write(message, encoding, callback);
    };
    return new Promise(promiseWrapper);
  }
}
