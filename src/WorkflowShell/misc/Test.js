const Command = require('../models/Command');

class Test extends Command {

  static getString() {
    return 'test';
  }

  static getDescription() {
    return 'Worksheet type thing for testing';
  }

  getUsage() {
    return Test.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    // Write test code here


    // End test code

    const baseCommand = 'echo done';
    return super.execute(baseCommand);
  }
}

module.exports = Test;
