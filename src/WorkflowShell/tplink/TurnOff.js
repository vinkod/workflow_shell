const Hs100Api = require('hs100-api');
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

    try {
      const client = new Hs100Api.Client();
      const plug = await client.getPlug({ host: plugIp, port: plugPort });
      console.log(`Retrieved plug: ${JSON.stringify(plug)}`);
      const info = await plug.getInfo();
      console.log(`info: ${JSON.stringify(info)}`);
      const sysInfo = await plug.getSysInfo();
      console.log(`sysInfo: ${JSON.stringify(sysInfo)}`);
      const cloudInfo = await plug.getCloudInfo();
      console.log(`cloudInfo: ${JSON.stringify(cloudInfo)}`);
      const consumption = await plug.getConsumption();
      console.log(`consumption: ${JSON.stringify(consumption)}`);
      const powerState = await plug.getPowerState();
      console.log(`powerState: ${JSON.stringify(powerState)}`);
      const scheduleNextAction = await plug.getScheduleNextAction();
      console.log(`scheduleNextAction: ${JSON.stringify(scheduleNextAction)}`);
      const scheduleRules = await plug.getScheduleRules();
      console.log(`scheduleRules: ${JSON.stringify(scheduleRules)}`);
      const awayRules = await plug.getAwayRules();
      console.log(`awayRules: ${JSON.stringify(awayRules)}`);
      const timerRules = await plug.getTimerRules();
      console.log(`timerRules: ${JSON.stringify(timerRules)}`);
      const time = await plug.getTime();
      console.log(`time: ${JSON.stringify(time)}`);
      const timeZone = await plug.getTimeZone();
      console.log(`timeZone: ${JSON.stringify(timeZone)}`);
      const scanInfo = await plug.getScanInfo();
      console.log(`scanInfo: ${JSON.stringify(scanInfo)}`);
      const model = await plug.getModel();
      console.log(`model: ${JSON.stringify(model)}`);

      console.log('');
      console.log('Attempting to turn plug off...');
      const setPowerStateResult = await plug.setPowerState(false);
      console.log(`Result: ${JSON.stringify(setPowerStateResult)}`);
      process.exit();
    } catch (error) {
      throw new Error(error);
    }
    console.log('Done.');
    return true;
  }
}

module.exports = TurnOff;
