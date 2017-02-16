import Command from "../models/Command";

export default class GitLog extends Command {

  static getString(): string {
    return "glog";
  }

  static getDescription(): string {
    return "Displays the git log with each commit on one line in nice colors.";
  }

  getUsage(): string {
    return GitLog.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "git reflog --pretty=format:'%Cred %H %Cgreen %gD %Cblue %s %C(Yellow) %aN'";
    super.execute(baseCommand);
    return true;
  }
}
