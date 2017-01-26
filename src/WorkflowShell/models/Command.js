const ChildProcess = require('child_process');

const help = { short: 'h', long: 'help', description: 'Prints this help message.' };

class Command {
  static getString() {
    throw new Error(`${this.constructor.name} did not implement 'getString' method.`);
  }
  static getDescription() {
    throw new Error(`${this.constructor.name} did not implement 'getDescription' method.`);
  }
  getUsage() {
    throw new Error(`${this.constructor.name} did not implement 'getUsage' method.`);
  }

  run(args) {
    // console.log(`ARGS: ${JSON.stringify(args)}`);
    if (typeof args !== 'undefined' &&
      args !== undefined &&
      (help.short in args || help.long in args)) {
      this.printHelp();
      process.exitCode = 1;
      return false;
    }
    return true;
  }

  printHelp() {
    console.log(Command.format(help));
    console.log('');
    console.log(`Usage: wsh ${this.getUsage()}`);
  }

  execute(command) {
    const execSync = ChildProcess.execSync;
    try {
      console.log(`Running: ${command}`);
      const commandExecution = execSync(command, { stdio: 'inherit' });
      return commandExecution;
    } catch (error) {
      console.log(`ERROR:\n${error}`);
      process.exitCode = 1;
      return null;
    }
  }

  executeWithReturn(command) {
    const execSync = ChildProcess.execSync;
    try {
      console.log(`Running: ${command}`);
      const commandExecution = execSync(command);
      console.log(`Result:\n${commandExecution}`);
      return commandExecution;
    } catch (error) {
      console.log(`ERROR:\n${error}`);
      process.exitCode = 1;
      return null;
    }
  }

  static format({ short, long, description }) {
    return `-${short}\t\t--${long}\t\t${description}`;
  }
}

module.exports = Command;
