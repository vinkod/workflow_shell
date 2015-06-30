#!/usr/bin/env bash

function printMVNCOMPILEhelp {
    echo "usage: wsh mvncompile"
}

function mvncompile {
    if [[ $# != 0 ]]
    	then printMVNCOMPILEhelp
    		exit 1
    fi

    mvn -U clean compile test-compile
}