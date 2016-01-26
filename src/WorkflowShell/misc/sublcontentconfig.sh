#!/usr/bin/env bash

function printSUBLCONTENTCONFIGhelp {
    echo "usage: wsh sublcontentconfig"
}

function sublcontentconfig {
    if [[ $# != 0 ]]
    	then printSUBLCONTENTCONFIGhelp
    		exit 1
    fi

    subl config/dev/contentLoad/config.yaml config/mapping/contentLoad/config.yaml config/prod/contentLoad/config.yaml config/staging/contentLoad/config.yaml config/wip/contentLoad/config.yaml
}