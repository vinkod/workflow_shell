# Workflow Shell

Workflow Shell is a collection of bash scripts that aims to abstract away some of the more tedious and repetitive aspects of your daily workflow. Including, but not limited to:

  - Building in Maven without tests
  - Uploading console JARs to util boxes
  - Managing git history and new commits
  - Pushing changes to the remote repository

Ideally, you should already be familiar with all of the actions that these scripts can take, but normally type them out fully each time you want to perform them. Here's a copy of the help as of May 3rd, 2016. 

```
⇒  wsh
Need help? Here are the currently available commands:
           gad                   Stages all files and folders in the current directory.
           gcam                  Takes one argument, the message. Commits all staged changes with the given message.
           gitamend              Amends the most recent commit to ensure that it has the correct author and an updated timestamp.
           gitgo                 Runs 'grb'. Commits all staged changes, rebases interactively, amends the most recent commit, then force pushes.
           gitlog                Displays the git log with each commit on one line in nice colors.
           gitpretty             Displays the git log with each commit taking only one line.
           gpfo                  Force pushes the current branch into a remote branch of the same name.
           grb                   Takes one argument, the number of commits to rebase. Rebases interactively with the given number.
           gs                    Displays the current status of the git repository.
           hdl                   Downloads hadoop logs.
           hgrep                 Greps through hadoop logs downloaded with ''hdl''.
           mvncompile            Updates, cleans, compiles, and compiles tests.
           mvndeps               Prints a dependency report, showing used but undeclared dependencies and other useful stuff.
           mvngo                 Builds a Maven project with various options.
           mvnpomchange          Changes the version of the module in the current directory and all submodules to the input version.
           mvntest               Takes one argument, the name of a class which contains tests. Updates, then attempts to run all specified tests.
           sublcontent           Opens, in Sublime, all content record config files in deployment repo.
           uploadjars            Uploads console JARs to various util nodes. This command must be run in the project's root or in one of the console modules' folders)

Run 'wsh <command> -h' for more information about a particular command
```
You can find a full list of commands and their documentation sorted roughly by which workflows they 

### Installation

```sh
⇒  git clone https://github.com/champgm/workflow_shell.git
     Cloning into 'workflow_shell'...
     remote: Counting objects: 69, done.
     remote: Compressing objects: 100% (8/8), done.
     remote: Total 69 (delta 1), reused 0 (delta 0), pack-reused 60
     Unpacking objects: 100% (69/69), done.
     Checking connectivity... done.
⇒  cd workflow_shell 
⇒  sh install.sh
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/WorkflowShell to /Users/mc023219/.zshrc
     Please close and reopen your terminal or re-source your .zshrc file
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/WorkflowShell to /Users/mc023219/.bash_profile
     Please close and reopen your terminal or re-source your .bash_profile file
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/src/WorkflowShell to /Users/mc023219/.profile
     Please close and reopen your terminal or re-source your .profile file
```

### Usage

If everything installed correctly (let me know if it didn't) you should be able to close and reopen your terminal window and have access to the "wsh" command. Type that, and it will print out the current help information. From there, you need to pick which script you want to run, and feed any parameters in that it wants. The simplest ones have only optional parameters: 
```
    wsh gitgo
```
Commits all unstaged changes with the message, "test commit, please squash" and then force pushes your branch to the "origin" repo. 

Some take arguments:
```
    wsh mvntest PersonRecordExtractionHBaseIT
```
When run in the correct module, will find the specified test class ("PersonRecordExtractionHBaseIT" in this case) and execute all tests within that class. 

### Reference

If at any time you want to know exactly what a script will do, you can look in the various subdirectories of src/WorkflowShell. Each script has its own file. Each does a little input parsing, prints some help if something goes wrong, and then executes a few lines. You can look in the branch "Bash_Branch" if you don't know much Ruby, but I can't guarantee that it's up to date.

Some are complicated, and call on other scripts:
```
    GitCommitAllMessage.new.run_command(["test commit, please squash"])
    unless commits_to_rebase.nil?
      GitRebase.new.run_command([commits_to_rebase])
      GitAmend.new.run_command([])
    end
    GitPushForceOrigin.new.run_command([])
```

But most are simple one-liners that you probably use every day:
```
    git add .
```
```
    git rebase -i HEAD~"$1"
```
```
    mvn -U clean install -Dmaven.test.skip=true -DskipITs
```