const Command = require('../models/Command');

class BrowserSync extends Command {

  static getString() {
    return 'bsync';
  }

  static getDescription() {
    return 'Starts up BrowserSync with normal options.';
  }

  getUsage() {
    return BrowserSync.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'browser-sync start --server --directory --files "**/*"';
    return super.execute(baseCommand);
  }
}

module.exports = BrowserSync;
