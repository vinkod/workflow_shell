import Command from "../models/Command";

export default class GitPushForceOrigin extends Command {

  static getString(): string {
    return "gpfo";
  }

  static getDescription(): string {
    return "Force pushes the current branch into a remote branch of the same name.";
  }

  getUsage(): string {
    return GitPushForceOrigin.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const branchCommand: string = "git rev-parse --abbrev-ref HEAD";
    const branchName: string = super.executeWithReturn(branchCommand);

    const pushCommand: string = `git push -f origin ${branchName}`;
    super.execute(pushCommand);
    return true;
  }
}
