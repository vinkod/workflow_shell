const Command = require('../models/Command');

class SendText extends Command {

  static getString() {
    return 'ast';
  }

  static getDescription() {
    return 'Sends text with ADB.';
  }

  getUsage() {
    return `${SendText.getString()} <Message>`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    let textToSend = args._.shift();
    if (!textToSend) {
      console.log('You MUST specify the text to send!');
      this.printHelp();
      return false;
    }

    textToSend = textToSend.replace(/\(/g, '\\(');
    textToSend = textToSend.replace(/\)/g, '\\)');
    textToSend = textToSend.replace(/</g, '\\<');
    textToSend = textToSend.replace(/>/g, '\\>');
    textToSend = textToSend.replace(/\|/g, '\\|');
    textToSend = textToSend.replace(/;/g, '\\;');
    textToSend = textToSend.replace(/&/g, '\\&');
    textToSend = textToSend.replace(/\*/g, '\\*');
    textToSend = textToSend.replace(/~/g, '\\~');
    textToSend = textToSend.replace(/"/g, '\\"');
    textToSend = textToSend.replace(/'/g, "\\'");
    textToSend = textToSend.replace(/ /g, '%s');

    const baseCommand = `adb shell input text "${textToSend}"`;
    return super.execute(baseCommand);
  }
}

module.exports = SendText;
