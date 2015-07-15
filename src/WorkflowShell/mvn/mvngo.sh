#!/usr/bin/env bash

function printMVNGOhelp {
    echo "usage: wsh mvngo"
}

function mvngo {
    if [[ $# != 0 ]]
    	then printMVNGOhelp
    		exit 1
    fi

    mvn -U -T 2C clean compile test-compile install
}