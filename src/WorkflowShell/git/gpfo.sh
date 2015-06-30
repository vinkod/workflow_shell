#!/usr/bin/env bash

function printGPFOhelp {
    echo "usage: wsh gpfo"
}

function gpfo {
    if [[ $# != 0 ]]
    	then printGPFOhelp
    		exit 1
    fi

    branch_name=$(git rev-parse --abbrev-ref HEAD)
    git push -f origin ${branch_name}
    #git branch --set-upstream-to ${branch_name} origin/${branch_name}
}