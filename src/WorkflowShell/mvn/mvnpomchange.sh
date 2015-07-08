#!/usr/bin/env bash

function printMVNPOMCHANGEhelp {
    echo "usage: wsh mvnpomchange <new pom version>"
}

function mvnpomchange {
    if [[ $# != 1 ]]
    	then printMVNPOMCHANGEhelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMhelp; exit 1;;
        	esac
    fi

    mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false;
}