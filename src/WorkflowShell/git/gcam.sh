#!/usr/bin/env bash

function printGCAMHelp {
    echo "GCAM help stuff goes here"
}

function gcam {
    if [[ $# != 1 ]]
    	then printGCAMHelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMHelp; exit 1;;
#            	"gcam" ) gcam;;
        	    #The default case
        	    * ) printHelp; exit 1;;
        	esac
    fi

    git commit -a -m $1
}