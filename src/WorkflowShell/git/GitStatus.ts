import Command from "../models/Command";

export default class GitStatus extends Command {

  static getString(): string {
    return "gs";
  }

  static getDescription(): string {
    return "Displays the current status of the git repository.";
  }

  getUsage(): string {
    return GitStatus.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "git status";
    super.execute(baseCommand);

    return true;
  }
}
