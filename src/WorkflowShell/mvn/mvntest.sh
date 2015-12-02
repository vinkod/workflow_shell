#!/usr/bin/env bash

function printMVNTESThelp {
    echo "usage: wsh mvntest <class name of test>"
}

function mvntest {
    if [[ $# != 1 ]]
    	then printMVNTESThelp
    		exit 1
    	else
            option=$1
        	case ${option} in
        	    "-h" ) printGCAMhelp; exit 1;;
        	esac
    fi

    mvn -U -Dtest=$1 test -Djava.awt.headless=true
}