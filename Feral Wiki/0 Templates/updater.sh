#!/bin/bash
# Script name goes here
scriptversion="0.0.0"
scriptname="somescript"
# Author name goes here
#
# Bash Command goes here
#
############################
#### Script Notes Start ####
############################
#
# This updater deals with updating a single file, the "~/bin/somescript", by updating and switching to this script.
#
# How do I customise this updater?
#
# 1: scriptversion="0.0.0" - replace "0.0.0" with your script version. This will be shown to the user at the current version check.
# 2: scriptname="somescript" - replace "somescript" with your script name. Make it unique to this script. Do not include the file extension.
# 3: Set the scripturl variable in the variable section to the RAW github URl of the script for updating.
# 4: Insert your script in the "User Script" labelled section - Indented by two tabs to be in line with the script.
# 5: Disable the updater - you can either set "updaterenabled" variable to 0 in the variable section or use the argument nu when calling the script, for example - "somescript nu"
# 6: quick load - use the argument qw when calling the script, for example - "somescript qw"
# 7: To pass your own variables to the script start from $3 onwards.
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
# v1.0.0 -Script updater template
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Disables the built in script updater permanently.
updaterenabled="1"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion=""$scriptversion"-nu"
else
    if [[ "$updaterenabled" -eq 1 ]]
    then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        #
        wget -qO ~/.000"$scriptname" "$scripturl"
        #
        if [[ $(sha256sum ~/.000"$scriptname" | awk '{print $1}') != $(sha256sum ~/bin/"$scriptname" | awk '{print $1}') ]]
        then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
            bash ~/.111"$scriptname"
            exit
        else
            if [[ -z $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') && $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') -ne "$$" ]]
            then
                echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname"
                bash ~/.222"$scriptname"
                exit
            fi
        fi
        cd && rm -f .{000,111,222}"$scriptname"
        chmod -f 700 ~/bin/"$scriptname"
        echo
    else
        echo
        echo "The Updater has been disabled"
        echo
        scriptversion=""$scriptversion"-DEV"
    fi
fi
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ ! -z $1 && $1 == 'qw' ]] || [[ ! -z $2 && $2 == 'qw' ]]
then
    updatestatus="y"
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
    echo
fi
    if [[ "$updatestatus" =~ ^[Yy]$ ]]
    then
#
############################
#### User Script Starts ####
############################
#
        #
#
############################
##### User Script End  #####
############################
#
    else
        echo -e "You chose to exit after updating the scripts."
        echo
        cd && bash
        exit 1
    fi
#
############################
##### Core Script Ends #####
############################
#