#!/usr/bin/env bash

function printGCAMHelp {
    echo "usage: wsh gcam <message>"
}

function gcam {
    if [[ $# != 1 ]]
    	then printGCAMHelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMHelp; exit 1;;
        	esac
    fi

    git commit --all --message "$1"
}