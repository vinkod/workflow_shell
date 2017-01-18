const Command = require('../models/Command');
const childProcess = require('child_process');

class GitAddDot extends Command {
  constructor() {
    super();
    this.string = 'gad';
    this.description = 'Stages all files and folders in the current directory.';
    this.usage = this.string;
  }

  run(args) {
    const commitMessage = args._.pop();
    if (!commitMessage) {
      console.log('You must specify a commit message!');
      printHelp();
      return;
    }

    const baseCommand = `git commit --all --message \"${commitMessage}\"`
    // const baseCommand = `ls -la`
    const execSync = childProcess.execSync;
    const commandExecution = execSync(baseCommand, { stdio: 'inherit' });
    // console.log(`${JSON.stringify(commandExecution)}`);

    // console.log(`stderr: ${commandExecution.stderr.toString()}`);
    // console.log(`stdout: ${commandExecution.stdout.toString()}`);
  }

}

module.exports = GitAddDot