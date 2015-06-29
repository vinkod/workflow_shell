#!/bin/bash

#Exit the script if any individual command fails
set -e

#Un-comment this next line if you want to see exactly what this script is doing
#set -x

#Assign a default value if the 4th input parameter is missing
mergeMessage=${4-Merging $3 into $2}

#Check the number of arguments and confirm with user if they are correct
if [ $# -lt 3 ] 
	then echo "At least three arguments must be specified: <project> <mergeTo> <mergeFrom> <OPTIONAL merge commit message>"
		exit 1
	else
		echo
		echo "Project:                    " $1
		echo "Branch to merge to:         " $2
		echo "Branch to merge from:       " $3
		#This variable surrounded by quotes to make sure the user knows exactly what this command is going to try to input as their commit message.
		echo "Commit message:             " \"$mergeMessage\"
		echo
		echo "Is this input correct? Please confirm or abort."
		select yn in "to Confirm" "to Abort"; do
    		case $yn in
        		"to Confirm" ) break;;
    		    "to Abort" ) echo exiting...; echo; exit 1;;
    		esac
		done
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

#Perform the merge
merge $1 $2 $3 $mergeMessage

echo Success. \"$1\" has been cloned into MERGETESTING/$1
echo You must review your changes to both \"$2\" AND \"$3\" and push them to remote if they are acceptable. 
