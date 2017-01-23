const Command = require('../models/Command');

class GitSetUpstream extends Command {

  static getString() {
    return 'gsu';
  }

  static getDescription() {
    return 'Sets the target upstream branch.';
  }

  getUsage() {
    return GitSetUpstream.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const branchCommand = 'git rev-parse --abbrev-ref HEAD';
    const branchName = super.executeWithReturn(branchCommand);

    const pushCommand = `git branch --set-upstream-to origin/${branchName}`;
    return super.execute(pushCommand);
  }
}

module.exports = GitSetUpstream;
