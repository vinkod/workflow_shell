const net = require('net');
const TPLinkUtil = require('./util/TPLinkUtil');
const Command = require('../models/Command');

class TurnOff extends Command {

  static getString() {
    return 'tpoff';
  }

  static getDescription() {
    return 'Turns a plug off.';
  }

  getUsage() {
    return TurnOff.getString();
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    let plugIp = args._.shift();
    if (!plugIp) {
      plugIp = '192.168.1.209';
      console.log(`No plug IP specified. Will use '${plugIp}'`);
    } else {
      console.log(`Plug IP specified. Will use '${plugIp}'`);
    }

    let plugPort = args._.shift();
    if (!plugPort) {
      plugPort = 9999;
      console.log(`No plug port specified. Will use '${plugPort}'`);
    } else {

      console.log(`Plug port specified. Will use '${plugPort}'`);
    }

    const socket = new net.Socket();
    try {
      await TPLinkUtil.turnOff(plugIp, plugPort, socket);
    } catch (error) {
      throw new Error(error);
    }
    console.log('Done.');
    return true;
  }
}

module.exports = TurnOff;
