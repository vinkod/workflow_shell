const Command = require('../models/Command');
const requestPromise = require('request-promise');
const phantom = require('phantom');

class RequestHeaders extends Command {

  static getString() {
    return 'rhdr';
  }

  static getDescription() {
    return 'Hits the API header request endpoint.';
  }

  getUsage() {
    return RequestHeaders.getString();
  }

  async run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const instance = await phantom.create([]);
    const page = await instance.createPage();
    await page.on('onResourceRequested', (requestData) => {
      console.info('Requesting', requestData.url);
    });
    page.on('onConsoleMessage', (msg) => {
      console.log(msg);
    });

    const status = await page.open('');
    console.log('====STATUS====');
    console.log(status);

    const content = await page.property('content');
    console.log('====CONTENT====');
    console.log(content);

    console.log('====ELEMENTS====');
    const elements = page.getElementsByClassName('o-form-input-name-username');
    console.log(`${JSON.stringify(elements)}`);

    await instance.exit();

    return true;
  }
}

module.exports = RequestHeaders;
