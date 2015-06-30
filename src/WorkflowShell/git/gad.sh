#!/usr/bin/env bash

function printGADhelp {
    echo "usage: wsh gad"
}

function gad {
    if [[ $# != 0 ]]
    	then printGADhelp
    		exit 1
    fi

    git add .
}