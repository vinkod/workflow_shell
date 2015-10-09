#!/usr/bin/env bash

function printMVNGOQUIEThelp {
    echo "usage: wsh mvngoquiet"
}

function mvngoquiet {
    if [[ $# != 0 ]]
    	then printMVNGOQUIEThelp
    		exit 1
    fi

    mvn -U --quiet clean compile test-compile install
}