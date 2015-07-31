#!/usr/bin/env bash

function printGITAMENDhelp {
    echo "usage: wsh gitamend"
}

function gitamend {
    if [[ $# != 0 ]]
    	then printGITAMENDhelp
    		exit 1
    fi

    git commit --amend --reset-author
}