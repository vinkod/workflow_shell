#!/usr/bin/env bash

function printUPLOADJARShelp {
    echo "usage: wsh uploadjars"
}

function uploadjars {
    if [[ $# != 0 ]]
    	then printUPLOADJARShelp
    		exit 1
    fi

    #TODO: exclude those "original" jars
    scp *-console/target/*console*SNAPSHOT.jar "$USER@pophdevutil30:~/" || true
    scp target/*console*SNAPSHOT.jar "$USER@pophdevutil30:~/" || true
    scp *-console/target/*console*SNAPSHOT.jar "$USER@pophdevvm219:~/" || true
    scp target/*console*SNAPSHOT.jar "$USER@pophdevvm219:~/" || true
}