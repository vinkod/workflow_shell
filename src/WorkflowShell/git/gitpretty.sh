#!/usr/bin/env bash

function printGITPRETTYhelp {
    echo "usage: wsh gitpretty"
}

function gitpretty {
    if [[ $# != 0 ]]
    	then printGITPRETTYhelp
    		exit 1
    fi

    git log --pretty=oneline
}