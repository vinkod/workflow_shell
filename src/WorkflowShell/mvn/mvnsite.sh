#!/usr/bin/env bash

function printMVNSITEhelp {
    echo "usage: wsh mvnsite"
}

function mvnsite {
    if [[ $# != 0 ]]
    	then printMVNSITEhelp
    		exit 1
    fi

    mvn -U -T 2C clean install site
}