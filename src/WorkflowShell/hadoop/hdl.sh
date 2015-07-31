#!/usr/bin/env bash

function printHDLhelp {
    echo "usage: wsh hdl <job ID> <URL to job>"
    echo "Example: wsh hdl \"201507281713_19288\" \"http://pophdevhadoopmstr01.northamerica.cerner.net:50030/jobdetails.jsp?jobid=job_201507281713_19288\""
}

function hdl {
    if [[ $# != 2 ]]
    	then printHDLhelp
    		exit 1
    fi

    wget --recursive -H --accept-regex "$1" "$2"
}