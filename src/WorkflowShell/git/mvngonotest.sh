#!/usr/bin/env bash

function printMVNGOhelp {
    echo "usage: wsh mvngonotest"
}

function mvngo {
    if [[ $# != 0 ]]
    	then printMVNGOhelp
    		exit 1
    fi

    mvn -U clean compile test-compile install
}