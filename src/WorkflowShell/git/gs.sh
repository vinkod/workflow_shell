#!/usr/bin/env bash

function printGShelp {
    echo "usage: wsh gs"
}

function gs {
    if [[ $# != 0 ]]
    	then printGShelp
    		exit 1
    fi

    git status
}