const Command = require('../models/Command');

class GitStatus extends Command {

  static getString() {
    return 'gs';
  }

  static getDescription() {
    return 'Displays the current status of the git repository.';
  }

  getUsage() {
    return GitStatus.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'git status';
    return super.execute(baseCommand);
  }
}

module.exports = GitStatus;
