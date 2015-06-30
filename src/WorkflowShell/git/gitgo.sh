#!/usr/bin/env bash

function printGITGOhelp {
    echo "usage: wsh gitgo <number of commits to rebase>"
}

function gitgo {
    if [[ $# != 1 ]]
    	then printGITGOhelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMhelp; exit 1;;
        	esac
    fi

    gcam "test commit, please squash" || true
    grb "$1"
    gitamend
    gpfo
}