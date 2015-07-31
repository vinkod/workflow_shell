#!/usr/bin/env bash

function printMVNGOLIVEQUIEThelp {
    echo "usage: wsh mvngolivequiet"
}

function mvngolivequiet {
    if [[ $# != 0 ]]
    	then printMVNGOLIVEQUIEThelp
    		exit 1
    fi

    mvn -U -T 2C --quiet clean install -Dmaven.test.skip=true -DskipITs
    uploadjars
}