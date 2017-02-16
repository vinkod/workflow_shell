import Command from "../models/Command";

export default class GitSetUpstream extends Command {

  static getString(): string {
    return "gsu";
  }

  static getDescription(): string {
    return "Sets the target upstream branch.";
  }

  getUsage(): string {
    return GitSetUpstream.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const branchCommand: string = "git rev-parse --abbrev-ref HEAD";
    const branchName: string = super.executeWithReturn(branchCommand);

    const pushCommand: string = `git branch --set-upstream-to origin/${branchName}`;
    super.execute(pushCommand);
    return true;
  }
}
