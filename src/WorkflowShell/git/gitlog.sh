#!/usr/bin/env bash

function printGITLOGhelp {
    echo "usage: wsh gitlog"
}

function gitlog {
    if [[ $# != 0 ]]
    	then printGITLOGhelp
    		exit 1
    fi

    git reflog --pretty=format:'%Cred %H %Cgreen %gD %Cblue %s %C(Yellow) %aN'
}