const Command = require('../models/Command');

class GitFixIgnore extends Command {

  static getString() {
    return 'gfi';
  }

  static getDescription() {
    return 'Attempts to fix gitignore not working properly.';
  }

  getUsage() {
    return `${GitFixIgnore.getString()}`;
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    super.execute('git commit -a -m "Before Fixing gitignore"');
    super.execute('git rm -r --cached .');
    super.execute('git add .');
    super.execute('git commit -a -m "Fixed gitignore"');
    return true;
  }
}

module.exports = GitFixIgnore;
