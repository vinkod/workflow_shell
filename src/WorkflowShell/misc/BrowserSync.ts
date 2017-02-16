import Command from "../models/Command";

export default class BrowserSync extends Command {

  static getString(): string {
    return "bsync";
  }

  static getDescription(): string {
    return "Starts up BrowserSync with normal options.";
  }

  getUsage(): string {
    return BrowserSync.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "browser-sync start --server --directory --files \"**/*\"";
    super.execute(baseCommand);
    return true;
  }
}
