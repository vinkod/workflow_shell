#!/usr/bin/env bash

function printMVNDEPShelp {
    echo "usage: wsh mvndeps"
}

function mvndeps {
    if [[ $# != 0 ]]
    	then printMVNDEPShelp
    		exit 1
    fi

    mvn -U -T 2C clean dependency:analyze
}