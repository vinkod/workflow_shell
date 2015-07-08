# Workflow Shell

Workflow Shell is a collection of bash scripts that aims to abstract away some of the more tedious and repetitive aspects of your daily workflow. Including, but not limited to:

  - Building in Maven without tests
  - Uploading console JARs to util boxes
  - Managing git history and new commits
  - Pushing changes to the remote repository

Ideally, you should already be familiar with all of the actions that these scripts can take, but normally type them out fully each time you want to perform them. Here's a copy of the help as of July 7th, 2015. 

```
usage: wsh <command> [<args>]

The full list of commands is as follows:
   gad            Stages all files and folders in the current directory.
   gcam           Takes one argument, the message.
                  Commits all staged changes with the given message.
   gitamend       Amends the most recent commit to ensure that it has the correct author and an updated timestamp.
   gitgo          Takes one arguemnt, the number of commits to rebase.
                  Commits all staged changes, rebases interactively, amends the most recent commit, then force pushes.
   gitlive        Commits all staged changes, force pushes.
   gitlog         Displays the git log with nice colors and stuff
   gitpretty      Displays the git log with each commit taking only one line
   gpfo           Force pushes
   grb            Takes one arguemnt, the number of commits to rebase.
                  Rebases interactively with the given number.
   gs             Displays the current status of the git repository
   mvncompile     Updates, cleans, compiles, and compiles tests
   mvngo          Updates, cleans, and installs
   mvngolive      Updates, cleans, installs (skipping all tests) and uploads console JARs to pophdevutil30
                  (must be run in the project's root or in one of the console modules' folders)
   mvngonotest    Updates, cleans, installs (skipping all tests)
   mvnpomchange   Takes one argument, the new POM version.
                  Changes the version of the module in the current directory and all submodules to the new verison
   mvnsite        Updates, cleans, and installs, generates site
   mvntest        Takes one argument, the name of a class which contains tests.
                  Updates, then attempts to run all specified tests
   uploadjars     Uploads console JARs to pophdevutil30
                  (must be run in the project's root or in one of the console modules' folders)
```

### Installation

```sh
⇒  git clone https://github.com/sjdurfey/workflow_shell.git
     Cloning into 'workflow_shell'...
     remote: Counting objects: 69, done.
     remote: Compressing objects: 100% (8/8), done.
     remote: Total 69 (delta 1), reused 0 (delta 0), pack-reused 60
     Unpacking objects: 100% (69/69), done.
     Checking connectivity... done.
⇒  cd workflow_shell 
⇒  git checkout Bash_Branch        
     Branch Bash_Branch set up to track remote branch Bash_Branch from origin.
     Switched to a new branch 'Bash_Branch'
⇒  sh install.sh
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/WorkflowShell to /Users/mc023219/.zshrc
     Please close and reopen your terminal or re-source your .zshrc file
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/WorkflowShell to /Users/mc023219/.bash_profile
     Please close and reopen your terminal or re-source your .bash_profile file
     Adding a PATH entry for /Users/mc023219/GitRepos/workflow_shell/src/WorkflowShell to /Users/mc023219/.profile
     Please close and reopen your terminal or re-source your .profile file
```

### Usage

If everything installed correctly (let me know if it didn't) you should be able to close and reopen your terminal window and have access to the "wsh" command. Type that, and it will print out the current help information. From there, you need to pick which script you want to run, and feed any parameters in that it wants. The simplest ones take no parameters: 
```
wsh gitlive
```
Commits all unstaged changes with the message, "test commit, please squash" and then force pushes your branch to the "origin" repo. 

Some take parameters:
```
wsh mvntest PersonRecordExtractionHBaseIT
```
When run in the ref-record-extract-crunch module, will find the test specified ("PersonRecordExtractionHBaseIT" in this case) and execute all tests within that class. 

### Reference

If at any time you want to know exactly what a script will do, you can look in the various subdirectories of src/WorkflowShell. Each script has its own file. Each does a little input parsing, prints some help if something goes wrong, and then executes a few lines of bash. 

Some are complicated, and call on other scripts:
```
    gcam "test commit, please squash" || true
    grb "$1"
    gitamend
    gpfo
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