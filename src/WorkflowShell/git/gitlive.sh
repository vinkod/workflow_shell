#!/usr/bin/env bash

function printGITLIVEhelp {
    echo "usage: wsh gitlive"
}

function gitlive {
    if [[ $# != 0 ]]
    	then printGITLIVEhelp
    		exit 1
    fi

    gcam "test commit, please squash" || true
    gpfo
}