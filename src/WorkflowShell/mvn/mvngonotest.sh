#!/usr/bin/env bash

function printMVNGONOTESThelp {
    echo "usage: wsh mvngonotest"
}

function mvngonotest {
    if [[ $# != 0 ]]
    	then printMVNGOhelp
    		exit 1
    fi

    mvn -U -T 2C clean install -Dmaven.test.skip=true -DskipITs -Djava.awt.headless=true
}