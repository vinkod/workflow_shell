import Command from "../models/Command";

export default class GitPretty extends Command {

  static getString(): string {
    return "gpretty";
  }

  static getDescription(): string {
    return "Displays the git log with each commit taking only one line.";
  }

  getUsage(): string {
    return GitPretty.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "git log --pretty=oneline";
    super.execute(baseCommand);
    return true;
  }
}
