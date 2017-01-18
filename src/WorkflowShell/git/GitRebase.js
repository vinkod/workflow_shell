const Command = require('../models/Command');

class GitCommitAllMessage extends Command {

  static getString() {
    return 'grb';
  }

  static getDescription() {
    return 'Takes one argument, the number of commits to rebase. Rebases interactively with the given number.';
  }

  getUsage() {
    return `${GitCommitAllMessage.getString()} <number of commits to rebase>`;
  }

  run(args) {
    super.run(args);

    const commitsToRebase = args._.shift();
    if (!commitsToRebase) {
      console.log('You MUST specify the number of commits to rebase!');
      this.printHelp();
      return;
    }

    const baseCommand = `git rebase -i HEAD~${commitsToRebase}`;
    super.execute(baseCommand);
  }
}

module.exports = GitCommitAllMessage;
