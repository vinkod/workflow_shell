import Command from "../models/Command";
import HelpItem from "../models/HelpItem";
import Logger from "../util/Logger";
const logger: Logger = new Logger("MavenGo");
const quiet = new HelpItem("q", "quiet", "Suppress most output.");
const noTest = new HelpItem("n", "noTest", "Skip unit and integration tests.");
const fast = new HelpItem("f", "fast", "Build with multiple threads.");
const site = new HelpItem("s", "site", "Build with a site report.");

export default class MavenGo extends Command {

  static getString(): string {
    return "mgo";
  }

  static getDescription(): string {
    return "Builds a Maven project with various options.";
  }


  getUsage(): string {
    let usage = `${MavenGo.getString()} -options\n`;
    usage = usage.concat(fast.toString()).concat("\n");
    usage = usage.concat(noTest.toString()).concat("\n");
    usage = usage.concat(quiet.toString()).concat("\n");
    usage = usage.concat(site.toString()).concat("\n");
    usage = usage.concat("\n");
    usage = usage.concat("Some of these options may not work well together, specifically building with multiple threads.");
    return usage;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    logger.log(`${JSON.stringify(args)}`);

    let baseCommand = "mvn -U clean install";
    if (site.short in args || site.long in args) {
      baseCommand = baseCommand.concat(" site");
    }
    if (fast.short in args || fast.long in args) {
      baseCommand = baseCommand.concat(" -T 3C");
    }
    if (quiet.short in args || quiet.long in args) {
      baseCommand = baseCommand.concat(" --quiet");
    }
    if (noTest.short in args || noTest.long in args) {
      baseCommand = baseCommand.concat(" -Dmaven.test.skip=true -DskipITs");
    }
    baseCommand = baseCommand.concat(" -Djava.awt.headless=true");

    super.execute(baseCommand); return true;
  }
}
