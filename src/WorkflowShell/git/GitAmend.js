const Command = require('../models/Command');

class GitAmend extends Command {

  static getString() {
    return 'ga';
  }

  static getDescription() {
    return 'Amends the most recent commit to ensure that it has the correct author and an updated timestamp.';
  }

  getUsage() {
    return GitAmend.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'git commit --amend --reset-author --no-edit';
    return super.execute(baseCommand);
  }
}

module.exports = GitAmend;
