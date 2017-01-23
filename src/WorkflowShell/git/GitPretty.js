const Command = require('../models/Command');

class GitPretty extends Command {

  static getString() {
    return 'gpretty';
  }

  static getDescription() {
    return 'Displays the git log with each commit taking only one line.';
  }

  getUsage() {
    return GitPretty.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'git log --pretty=oneline';
    return super.execute(baseCommand);
  }
}

module.exports = GitPretty;
