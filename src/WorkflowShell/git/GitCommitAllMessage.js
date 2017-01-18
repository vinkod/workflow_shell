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
    super.run(args);

    const commitMessage = args._.shift();
    if (!commitMessage) {
      console.log('You MUST specify the commit message!');
      this.printHelp();
      return;
    }

    const baseCommand = `git commit --all --message "${commitMessage}"`;
    super.execute(baseCommand);
  }
}

module.exports = GitCommitAllMessage;
