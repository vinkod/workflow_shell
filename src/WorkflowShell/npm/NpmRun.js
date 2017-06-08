const Command = require('../models/Command');

class NpmRun extends Command {

  static getString() {
    return 'nr';
  }

  static getDescription() {
    return 'Runs NPM with given parameters.';
  }

  getUsage() {
    return NpmRun.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    let baseCommand = 'npm run ';
    args.forEach((arg) => {
      baseCommand = `${baseCommand} ${arg}`;
    });
    return super.execute(baseCommand);
  }
}

module.exports = NpmRun;
