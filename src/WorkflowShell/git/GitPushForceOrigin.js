const Command = require('../models/Command');

class GitPushForceOrigin extends Command {

  static getString() {
    return 'gpfo';
  }

  static getDescription() {
    return 'Force pushes the current branch into a remote branch of the same name.';
  }

  getUsage() {
    return GitPushForceOrigin.getString();
  }

  run(args) {
    super.run(args);

    const branchCommand = 'git rev-parse --abbrev-ref HEAD';
    const branchName = super.executeWithReturn(branchCommand);

    const pushCommand = `git push -f origin ${branchName}`;
    super.execute(pushCommand);
  }
}

module.exports = GitPushForceOrigin;
