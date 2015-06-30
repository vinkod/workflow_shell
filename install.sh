#!/bin/bash
#===== Static Vartiables =========
PROJECT_NAME="Workflow Shell"
#=====/Static Vartiables =========



#===== Private Functions =========
add_path () {
    echo $'\n'\#${PROJECT_NAME} Path$'\n'export PATH='$PATH:'$1 >> $2
}
#=====/Private Functions =========


#Find where this script exists
SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ ${SOURCE} != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIRECTORY="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#Look for the different profile files. 
if [[ -e $HOME/.zsh_profile ]] #Lots of people are using zshell these days
    then
    echo "Adding a PATH entry for ${SCRIPT_DIRECTORY}/WorkflowShell to $HOME/.zsh_profile"
    add_path "${SCRIPT_DIRECTORY}/src/WorkflowShell" "$HOME/.zsh_profile"
    echo "Please close and reopen your terminal or re-source your .zsh_profile file"
elif [[ -e $HOME/.zshrc ]]
    then
    echo "Adding a PATH entry for ${SCRIPT_DIRECTORY}/WorkflowShell to $HOME/.zshrc"
    add_path "${SCRIPT_DIRECTORY}/src/WorkflowShell" "$HOME/.zshrc"
    echo "Please close and reopen your terminal or re-source your .zshrc file"
fi

if [[ -e $HOME/.bash_profile ]] #They might not have zshell installed
    then
    echo "Adding a PATH entry for ${SCRIPT_DIRECTORY}/WorkflowShell to $HOME/.bash_profile"
    add_path "${SCRIPT_DIRECTORY}/src/WorkflowShell" "$HOME/.bash_profile"
    echo "Please close and reopen your terminal or re-source your .bash_profile file"
elif [[ -e $HOME/.bashrc ]]
    then
    echo "Adding a PATH entry for ${SCRIPT_DIRECTORY}/WorkflowShell to $HOME/.bashrc"
    add_path "${SCRIPT_DIRECTORY}/src/WorkflowShell" "$HOME/.bashrc"
    echo "Please close and reopen your terminal or re-source your .bashrc file"
fi

#As a fallback, just in case both of those don't exist, add it to the generic .profile
echo "Adding a PATH entry for ${SCRIPT_DIRECTORY}/src/WorkflowShell to $HOME/.profile"
add_path "${SCRIPT_DIRECTORY}/src/WorkflowShell" "$HOME/.profile"
echo "Please close and reopen your terminal or re-source your .profile file"
