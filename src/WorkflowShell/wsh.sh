#!/usr/bin/env bash

#Exit the script if any individual command fails
set -o errexit

#Exit the script if it tries to use any undeclared variables
set -o nounset

#Un-comment this next line if you want to see exactly what this script is doing
set -o xtrace

#Imports
source "git/gcam.sh"

function printHelp {
    echo "help stuff goes here"
}

#Check the number of arguments and confirm with user if they are correct
if [[ $# -lt 1 ]]
	then printHelp
		exit 1
	else
        workFlowCommand=$1
        shift #eats the first argument
    	case ${workFlowCommand} in
    	    "-h" )
    	        printHelp;;
        	"gcam" )
        	    gcam "$@";; #calls gcam with the remaining arguments

    	    #The default case
    	    * ) printHelp; exit 1;;
    	esac
fi

#This function performs the merge. It expects 4 input variables. 
#<project> <mergeTo> <mergeFrom> <merge commit message>
function merge {
	#Clone the repo and change into the new directory
	mkdir -p MERGETESTING
	cd MERGETESTING
	git clone http://github.cerner.com/phrecorddev/$1.git
	cd $1

	#Make sure that the branch to merge from is checked out and fully updated
	git fetch origin
	git checkout $3
	git pull

	#Replace 'WIP-SNAPSHOT' with just 'SNAPSHOT' in all pom files in the branch to merge from
	find . -type f -name 'pom.xml' -exec sed -i '' s/WIP-SNAPSHOT/SNAPSHOT/ {} +
	git commit -a -m "Preparing $3 poms for merge to $2"

	#Make sure that the branch to merge to is checked out and fully updated
	git checkout $2
	git pull
	
	#Attempt the merge
	git merge $3 --no-ff -m "$mergeMessage"

	#Some poms aren't in the project's base folder
	if [ $1 == 'record-dev-common' ]
		then cd $1
	fi

	#Check and make sure a maven build will not fail
	mvn -U clean verify -DskipITs


	#Build succeeded, undo the pom changes in the branch to merge from 
	git checkout $3
	find . -type f -name 'pom.xml' -exec sed -i '' s/SNAPSHOT/WIP-SNAPSHOT/ {} +
	git commit -a -m "Restoring $3 poms after merge to $2"

}

