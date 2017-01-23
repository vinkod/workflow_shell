const Command = require('../models/Command');

class GitLog extends Command {

  static getString() {
    return 'glog';
  }

  static getDescription() {
    return 'Displays the git log with each commit on one line in nice colors.';
  }

  getUsage() {
    return GitLog.getString();
  }

  run(args) {
    const ok = super.run(args);
    if (!ok) {
      return false;
    }

    const baseCommand = "git reflog --pretty=format:'%Cred %H %Cgreen %gD %Cblue %s %C(Yellow) %aN'";
    return super.execute(baseCommand);
  }
}

module.exports = GitLog;
