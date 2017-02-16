import Command from "../models/Command";
import Logger from "../util/Logger";

const logger = new Logger("MavenTest");
export default class MavenTest extends Command {

  static getString(): string {
    return "mtest";
  }

  static getDescription(): string {
    return "Takes one argument, the name of a class which contains tests. Updates, then attempts to run all specified tests.";
  }

  getUsage(): string {
    return `${MavenTest.getString()} <Test Class Name>`;
  }

  async run(args: any) {
    const ok: boolean = await super.run(args);
    if (!ok) {
      return false;
    }

    const testName = args._.shift();
    if (!testName) {
      logger.log("You MUST specify the test name!");
      this.printHelp();
      return false;
    }

    const baseCommand = `mvn -U -Dtest=${testName} test -Djava.awt.headless=true`;
    super.execute(baseCommand);
    return true;
  }
}
