const Command = require('../models/Command');

class MavenCompile extends Command {

  static getString() {
    return 'mcompile';
  }

  static getDescription() {
    return 'Updates, cleans, compiles, and compiles tests.';
  }

  getUsage() {
    return MavenCompile.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = 'mvn -U -T 3C clean compile test-compile -Djava.awt.headless=true';
    return super.execute(baseCommand);
  }
}

module.exports = MavenCompile;
