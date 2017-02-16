import Command from "../models/Command";

export default class MavenCompile extends Command {

  static getString(): string {
    return "mcompile";
  }

  static getDescription(): string {
    return "Updates, cleans, compiles, and compiles tests.";
  }

  getUsage(): string {
    return MavenCompile.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "mvn -U -T 3C clean compile test-compile -Djava.awt.headless=true";
    super.execute(baseCommand);
    return true;
  }
}
