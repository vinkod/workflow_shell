import Command from "../models/Command";
import Logger from "../util/Logger";

const logger = new Logger("GitCommitAllMessage");

export default class GitCommitAllMessage extends Command {

  static getString(): string {
    return "gcam";
  }

  static getDescription(): string {
    return "Takes one argument, the message. Commits all staged changes with the given message.";
  }

  getUsage(): string {
    return `${GitCommitAllMessage.getString()} <Commit Message>`;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const commitMessage: string = args._.shift();
    if (!commitMessage) {
      logger.log("You MUST specify the commit message!");
      this.printHelp();
      return false;
    }

    const baseCommand: string = `git commit --all --message "${commitMessage}"`;
    super.execute(baseCommand);
    return true;
  }
}
