import Command from "../models/Command";

export default class GitFixIgnore extends Command {

  static getString(): string {
    return "gfi";
  }

  static getDescription(): string {
    return "Attempts to fix gitignore not working properly.";
  }

  getUsage(): string {
    return `${GitFixIgnore.getString()}`;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    super.execute("git commit -a -m \"Before Fixing gitignore\"");
    super.execute("git rm -r --cached .");
    super.execute("git add .");
    super.execute("git commit -a -m \"Fixed gitignore\"");
    return true;
  }
}
