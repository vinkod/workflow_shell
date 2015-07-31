#!/usr/bin/env bash

function printHGREPhelp {
    echo "Usage: wsh hgrep <search term> <output filename>"
    echo "Example: wsh hgrep \"Normalization Failed\" normfail.txt"
}

function hgrep {
    if [[ $# != 2 ]]
    	then printHGREPhelp
    		exit 2
    fi

    grep -R --include="*all*" "$1" . > "$2"
}