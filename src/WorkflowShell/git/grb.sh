#!/usr/bin/env bash

function printGRBhelp {
    echo "usage: wsh grb <number of commits to rebase>"
}

function grb {
    if [[ $# != 1 ]]
    	then printGRBhelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMhelp; exit 1;;
        	esac
    fi

    git rebase -i HEAD~"$1"
}