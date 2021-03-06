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
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const commitsToRebase = args._.shift();
    if (!commitsToRebase) {
      console.log('You MUST specify the number of commits to rebase!');
      this.printHelp();
      return false;
    }

    const baseCommand = `git rebase -i HEAD~${commitsToRebase}`;
    return super.execute(baseCommand);
  }
}

module.exports = GitCommitAllMessage;
