const Command = require('../models/Command');

class GitGo extends Command {

  static getString() {
    return 'ggo';
  }

  static getDescription() {
    return "Runs 'grb'. Commits all staged changes, rebases interactively, amends the most recent commit, then force pushes.";
  }

  getUsage() {
    return `${GitGo.getString()} <number of commits to rebase>`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const commitsToRebase = args._.shift();
    const GitCommitAllMessage = require('./GitCommitAllMessage');
    new GitCommitAllMessage().run({ _: ['test commit, please fixup'] });
    if (commitsToRebase) {
      const GitRebase = require('./GitRebase');
      new GitRebase().run({ _: [commitsToRebase] });
      const GitAmend = require('./GitAmend');
      new GitAmend().run();
    }
    const GitPushForceOrigin = require('./GitPushForceOrigin');
    return new GitPushForceOrigin().run();
  }
}

module.exports = GitGo;
