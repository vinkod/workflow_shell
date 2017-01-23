const Command = require('../models/Command');

class GitCommitAllMessage extends Command {

  static getString() {
    return 'gcam';
  }

  static getDescription() {
    return 'Takes one argument, the message. Commits all staged changes with the given message.';
  }

  getUsage() {
    return `${GitCommitAllMessage.getString()} <Commit Message>`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const commitMessage = args._.shift();
    if (!commitMessage) {
      console.log('You MUST specify the commit message!');
      this.printHelp();
      return false;
    }

    const baseCommand = `git commit --all --message "${commitMessage}"`;
    return super.execute(baseCommand);
  }
}

module.exports = GitCommitAllMessage;
