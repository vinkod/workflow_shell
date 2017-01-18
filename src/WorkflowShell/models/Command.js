

class Command {


  getString() {
    return this.string;
  }

  getDescription() {
    return this.description;
  }

  getUsage() {
    return this.usage;
  }

  printHelp() {
    console.log(`Usage: ${this.getUsage()}`);
    console.log('');
    console.log(this.format('-h', '--h', 'Prints this help message'));
    process.exitCode = 1;
  }

  run(args) {
    throw new Error(`${this.getString()} did not implement 'run_command' method.\nArguments: ${args}`);
  }

  static format(short, long, description) {
    return `${short}\t${long}\t${description}`;
  }
}

module.exports = Command
