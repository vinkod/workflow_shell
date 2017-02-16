import Command from "../models/Command";
import Logger from "../util/Logger";

const logger: Logger = new Logger("GitCommitAllMessage");

export default class GitCommitAllMessage extends Command {

  static getString(): string {
    return "grb";
  }

  static getDescription(): string {
    return "Takes one argument, the number of commits to rebase. Rebases interactively with the given number.";
  }

  getUsage(): string {
    return `${GitCommitAllMessage.getString()} <number of commits to rebase>`;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const commitsToRebase = args._.shift();
    if (!commitsToRebase) {
      logger.log("You MUST specify the number of commits to rebase!");
      this.printHelp();
      return false;
    }

    const baseCommand: string = `git rebase -i HEAD~${commitsToRebase}`;
    super.execute(baseCommand);
    return true;
  }
}
