const Command = require('../models/Command');

class MavenPomChange extends Command {

  static getString() {
    return 'mpomchange';
  }

  static getDescription() {
    return 'Changes the version of the module in the current directory and all submodules to the input version.';
  }

  getUsage() {
    return `${MavenPomChange.getString()} <New Version>`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const newVersion = args._.shift();
    if (!newVersion) {
      console.log('You MUST specify the new version!');
      console.log('');
      console.log('Current version is...');
      super.execute("mvn help:evaluate -Dexpression=project.version|grep -Ev '(^\\[|Download\\w+:)'");
      this.printHelp();
      return false;
    }

    const baseCommand = `mvn versions:set -DnewVersion=${newVersion} -Djava.awt.headless=true -DgenerateBackupPoms=false`;
    return super.execute(baseCommand);
  }
}

module.exports = MavenPomChange;
