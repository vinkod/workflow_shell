const ChildProcess = require('child_process');

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
    if (typeof args !== 'undefined' &&
      args !== undefined &&
      ('-h' in args || '--help' in args)) {
      this.printHelp();
      process.exitCode = 1;
    }
  }

  printHelp() {
    console.log('');
    console.log(`Usage: wsh ${this.getUsage()}`);
    console.log(Command.format('-h', '--help', 'Prints this help message'));
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
      console.log(`Result: ${commandExecution}`);

      return commandExecution;
    } catch (error) {
      console.log(`ERROR:\n${error}`);
      process.exitCode = 1;
      return null;
    }
  }

  static format(short, long, description) {
    return `${short}\t${long}\t${description}`;
  }
}

module.exports = Command;
