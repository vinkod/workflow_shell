const Command = require('../models/Command');

class MavenDependencyAnalysis extends Command {

  static getString() {
    return 'mdeps';
  }

  static getDescription() {
    return 'Prints a dependency report, showing used but undeclared dependencies and other useful stuff.';
  }

  getUsage() {
    return MavenDependencyAnalysis.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'mvn -U -T 3C clean dependency:analyze -Djava.awt.headless=true';
    return super.execute(baseCommand);
  }
}

module.exports = MavenDependencyAnalysis;
