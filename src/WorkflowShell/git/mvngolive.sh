#!/usr/bin/env bash

function printMVNGOLIVEhelp {
    echo "usage: wsh mvngolive"
}

function mvngolive {
    if [[ $# != 0 ]]
    	then printMVNGOLIVEhelp
    		exit 1
    fi

    #TODO: Don't upload those "original" jars.
    mvn -U clean install -Dmaven.test.skip=true -DskipITs
    scp *-console/target/*console*SNAPSHOT.jar "$USER@pophdevutil30:~/"
    scp target/*console*SNAPSHOT.jar "$USER@pophdevutil30:~/"
}