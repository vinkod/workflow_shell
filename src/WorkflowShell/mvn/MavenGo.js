const Command = require('../models/Command');

const quiet = { short: 'q', long: 'quiet', description: 'Suppress most output.' };
const noTest = { short: 'n', long: 'noTest', description: 'Skip unit and integration tests.' };
const fast = { short: 'f', long: 'fast', description: 'Build with multiple threads.' };
const site = { short: 's', long: 'site', description: 'Build with a site report.' };

class MavenGo extends Command {

  static getString() {
    return 'mgo';
  }

  static getDescription() {
    return 'Builds a Maven project with various options.';
  }



  getUsage() {
    let usage = `${MavenGo.getString()} -options\n`;
    usage = usage.concat(Command.format(fast)).concat('\n');
    usage = usage.concat(Command.format(noTest)).concat('\n');
    usage = usage.concat(Command.format(quiet)).concat('\n');
    usage = usage.concat(Command.format(site)).concat('\n');
    usage = usage.concat('\n');
    usage = usage.concat('Some of these options may not work well together, specifically building with multiple threads.');
    return usage;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    console.log(`${JSON.stringify(args)}`);

    let baseCommand = 'mvn -U clean install';
    if (site.short in args || site.long in args) {
      baseCommand = baseCommand.concat(' site');
    }
    if (fast.short in args || fast.long in args) {
      baseCommand = baseCommand.concat(' -T 3C');
    }
    if (quiet.short in args || quiet.long in args) {
      baseCommand = baseCommand.concat(' --quiet');
    }
    if (noTest.short in args || noTest.long in args) {
      baseCommand = baseCommand.concat(' -Dmaven.test.skip=true -DskipITs');
    }
    baseCommand = baseCommand.concat(' -Djava.awt.headless=true');

    return super.execute(baseCommand);
  }
}

module.exports = MavenGo;
