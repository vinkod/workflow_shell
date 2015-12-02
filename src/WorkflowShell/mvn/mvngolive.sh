#!/usr/bin/env bash

function printMVNGOLIVEhelp {
    echo "usage: wsh mvngolive"
}

function mvngolive {
    if [[ $# != 0 ]]
    	then printMVNGOLIVEhelp
    		exit 1
    fi

    mvn -U -T 2C clean install -Dmaven.test.skip=true -DskipITs -Djava.awt.headless=true
    uploadjars
}