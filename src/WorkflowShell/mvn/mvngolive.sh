#!/usr/bin/env bash

function printMVNGOLIVEhelp {
    echo "usage: wsh mvngolive"
}

function mvngolive {
    if [[ $# != 0 ]]
    	then printMVNGOLIVEhelp
    		exit 1
    fi

    mvn -U clean install -Dmaven.test.skip=true -DskipITs
    uploadjars
}