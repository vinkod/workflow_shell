import Command from "../models/Command";

export default class GitGo extends Command {

  static getString(): string {
    return "ggo";
  }

  static getDescription(): string {
    return "Runs 'grb'. Commits all staged changes, rebases interactively, amends the most recent commit, then force pushes.";
  }

  getUsage(): string {
    return `${GitGo.getString()} <number of commits to rebase>`;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const commitsToRebase: string = args._.shift();
    const GitCommitAllMessage = require("./GitCommitAllMessage").default;
    new GitCommitAllMessage().run({ _: ["test commit, please fixup"] });
    if (commitsToRebase) {
      const GitRebase = require("./GitRebase").default;
      new GitRebase().run({ _: [commitsToRebase] });
      const GitAmend = require("./GitAmend").default;
      new GitAmend().run();
    }
    const GitPushForceOrigin = require("./GitPushForceOrigin").default;
    return new GitPushForceOrigin().run();
  }
}
