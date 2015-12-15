#!/usr/bin/env bash
set -o nounset
#set -o xtrace

function printPRODhelp {
    echo "usage: wsh prod"
    echo "This command will take quite a bit of config. "
    echo "You will need to set up 4 files in your home directory "
    echo "which contain connection information including your pin, "
    echo "your password, the SSH Jump Gate address you wish to use, "
    echo "and the utility node to which you want to connect."
    echo "These files are as follows:"
    echo "~/.pin - your RSA token pin"
    echo "~/.password - your password"
    echo "~/.portal - the IP address of your SSH Jump Gate"
    echo "~/.utilNode - the IP address of the util node to which you wish to connect"
    echo ""
    echo "More information about the available SSH Jump Gates can be found here:"
    echo "https://wiki.ucern.com/pages/viewpage.action?pageId=1235753143"

}

function prod {
    if [[ $# != 0 ]]
    	then printPRODhelp
    		exit 1
    fi

    #Find where this script exists
    SOURCE="${BASH_SOURCE[0]}"
    while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      [[ ${SOURCE} != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    SCRIPT_DIRECTORY="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

    # https://wiki.ucern.com/pages/viewpage.action?pageId=1235753143

    osascript "${SCRIPT_DIRECTORY}/GetToken.scpt"
    osascript "${SCRIPT_DIRECTORY}/LogOn.scpt"
}