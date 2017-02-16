import Command from "../models/Command";

export default class MavenDependencyAnalysis extends Command {

  static getString(): string {
    return "mdeps";
  }

  static getDescription(): string {
    return "Prints a dependency report, showing used but undeclared dependencies and other useful stuff.";
  }

  getUsage(): string {
    return MavenDependencyAnalysis.getString();
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand: string = "mvn -U -T 3C clean dependency:analyze -Djava.awt.headless=true";
    super.execute(baseCommand);
    return true;
  }
}
