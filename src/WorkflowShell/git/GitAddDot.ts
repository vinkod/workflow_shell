import Command from "../models/Command";

export default class GitAddDot extends Command {

  static getString(): string {
    return "gad";
  }

  static getDescription(): string {
    return "Stages all files and folders in the current directory.";
  }

  getUsage(): string {
    return GitAddDot.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "git add .";
    super.execute(baseCommand);
    return true;
  }
}
