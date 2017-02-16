import * as ChildProcess from "child_process";
import HelpItem from "./HelpItem";
import Logger from "../util/Logger";

const help: HelpItem = new HelpItem("h", "help", "Prints this help message.");
const logger: Logger = new Logger("Command");

export default class Command {
  static getString(): string {
    throw new Error(`Command did not implement 'getString' method.`);
  }
  static getDescription(): string {
    throw new Error(`Command did not implement 'getDescription' method.`);
  }
  getUsage(): string {
    throw new Error(`Command did not implement 'getUsage' method.`);
  }

  async run(args: any) {
    // logger.log(`ARGS: ${JSON.stringify(args)}`);
    if (typeof args !== "undefined" &&
      args !== undefined &&
      (help.short in args || help.long in args)) {
      this.printHelp();
      process.exitCode = 1;
      return false;
    }
    return true;
  }

  printHelp(): void {
    logger.log(help.toString());
    logger.log("");
    logger.log(`Usage: wsh ${this.getUsage()}`);
  }

  execute(command: string): boolean {
    const execSync = ChildProcess.execSync;
    try {
      logger.log(`Running: ${command}`);
      const commandExecution: Buffer = execSync(command, { stdio: "inherit" });
      return true;
    } catch (error) {
      logger.log(`ERROR:\n${error}`);
      logger.log(`${error.stack}`);
      process.exitCode = 1;
      throw error;
    }
  }

  executeWithReturn(command: string): string {
    const execSync = ChildProcess.execSync;
    try {
      logger.log(`Running: ${command}`);
      const commandExecution = execSync(command).toString();
      logger.log(`Result:\n${commandExecution}`);
      return commandExecution;
    } catch (error) {
      logger.log(`ERROR:\n${error}`);
      logger.log(`${error.stack}`);
      process.exitCode = 1;
      throw error;
    }
  }
}
