const Command = require('../models/Command');

class GitAddDot extends Command {

  static getString() {
    return 'gad';
  }

  static getDescription() {
    return 'Stages all files and folders in the current directory.';
  }

  getUsage() {
    return GitAddDot.getString();
  }

  run(args) {
    super.run(args);

    const baseCommand = 'git add .';
    super.execute(baseCommand);
  }
}

module.exports = GitAddDot;
