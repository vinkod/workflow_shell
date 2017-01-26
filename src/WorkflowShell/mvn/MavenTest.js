const Command = require('../models/Command');

class MavenTest extends Command {

  static getString() {
    return 'mtest';
  }

  static getDescription() {
    return 'Takes one argument, the name of a class which contains tests. Updates, then attempts to run all specified tests.';
  }

  getUsage() {
    return `${MavenTest.getString()} <Test Class Name>`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const testName = args._.shift();
    if (!testName) {
      console.log('You MUST specify the test name!');
      this.printHelp();
      return false;
    }

    const baseCommand = `mvn -U -Dtest=${testName} test -Djava.awt.headless=true`;
    return super.execute(baseCommand);
  }
}

module.exports = MavenTest;
