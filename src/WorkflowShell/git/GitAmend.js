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
    super.run(args);

    const baseCommand = 'git commit --amend --reset-author --no-edit';
    super.execute(baseCommand);
  }
}

module.exports = GitAmend;
