import Command from "../models/Command";

export default class GitAmend extends Command {

  static getString(): string {
    return "ga";
  }

  static getDescription(): string {
    return "Amends the most recent commit to ensure that it has the correct author and an updated timestamp.";
  }

  getUsage(): string {
    return GitAmend.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "git commit --amend --reset-author --no-edit";
    super.execute(baseCommand);
    return true;
  }
}
