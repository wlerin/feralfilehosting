#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomesessence
#
# Script Contributors: none
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/restart http://git.io/5Uw8Gw && bash ~/restart
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
##
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z $1 && $1 == 'changelog' ]]; then echo
    #
    echo 'v1.0.6 - Template updated'
    echo 'v1.0.5 - Template updated'
    #
    echo
    exit
fi
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Script Version number is set here.
scriptversion="1.0.6"
#
# Script name goes here. Please prefix with install.
scriptname="restart"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/5Uw8Gw"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Restarting%20-%20rtorrent%20-%20Deluge%20-%20Transmission%20-%20MySQL/scripts/restart.sh"
#
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]
do
    appport=$(shuf -i 10001-49999 -n 1)
done
#
# Disables the built in script updater permanently by setting this variable to 0.
updaterenabled="1"
#
############################
####### Variable End #######
############################
#
############################
#### Script Info Starts ####
############################
#
# Use this to show a user script information when they use the info option with the script.
if [[ ! -z $1 && $1 == 'info' ]]
then
    echo
    echo -e "\033[32m""Script Details:""\e[0m"
    echo
    echo "Script Author: $scriptauthor"
    echo
    echo "Script Contributors: $contributors"
    echo
    echo -e "\033[32m""Script Information and usage instructions:""\e[0m"
    echo
    #
    ###################################
    #### Custom Script Notes Start ####
    ###################################
    #
    echo -e "Put your instructions or script information here using echoes"
    #
    ###################################
    ##### Custom Script Notes End #####
    ###################################
    #
    echo
    echo -e "\033[32m""Script options:""\e[0m"
    echo
    echo -e "\033[31mImportant note:\e[0m Options \033[36mqr\e[0m and \033[36mnu\e[0m are interchangeable and usable together."
    echo
    echo -e "For example: \033[36m$scriptname qr nu\e[0m or \033[36m$scriptname nu qr\e[0m will both work"
    echo
    echo -e "\033[36mqr\e[0m = Quick Run - use this to bypass the default update prompts and run the main script directly."
    echo
    echo -e "Example usage: \033[36m$scriptname qr\e[0m"
    echo
    echo -e "\033[36mnu\e[0m = No Update - disable the built in updater. Useful for testing new features or debugging."
    echo
    echo -e "Example usage: \033[36m$scriptname nu\e[0m"
    echo
    echo -e "\033[32mBash Commands:\e[0m"
    echo
    echo -e "$gitiocommand"
    echo
    echo -e "~/bin/$scriptname"
    echo
    echo -e "$scriptname"
    #
    echo
    exit
fi
#
############################
##### Script Info Ends #####
############################
#
############################
#### Self Updater Start ####
############################
#
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, whihc woudl reset the option, it will then find this file and set it back.
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
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
        scriptversion="$scriptversion-DEV"
    fi
fi
#
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
if [[ -f ~/.quickrun ]];then updatestatus="y"; rm -f ~/.quickrun; fi
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" == "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
    echo
fi
#
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    showMenu () 
    {
            echo "1"": Restart rtorrent"
            echo "2"": Restart Deluge"
            echo "3"": Restart Tranmission"
            echo "4"": Restart MySQL"
            echo "5"": quit"
    }

    while [ 1 ]
    do
            showMenu
            echo
            read -ep "Enter the number of the action you wish to complete: " CHOICE
            case "$CHOICE" in
                    "1")
                        echo
                        if [[ -d ~/private/rtorrent ]]
                        then
                            echo -e "\033[31m""Killing all instances of rtorrent""\e[0m"
                            echo
                            killall -u $(whoami) rtorrent
                            screen -wipe > /dev/null 2>&1
                            echo "Restarting rtorrent"
                            echo
                            screen -fa -dmS rtorrent rtorrent
                            sleep 2
                            echo -e "\033[33m""Checking if the process is running:""\e[0m"
                            echo
                            ps x | grep current/bin/rtorrent | grep -v grep
                            echo
                            echo -e "\033[33m""Checking if the screen is running""\e[0m"
                            echo
                            screen -ls | grep rtorrent
                            echo
                            echo -e "\033[32m""For troubleshooting refer to the FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=158""\e[0m"
                            echo
                            echo -e "To restart other instances of rtorrent/rutorrent installed by the script check this file:" "\033[36m""~/multirtru.restart.txt""\e[0m"
                            echo
                            sleep 2
                        else
                            echo -e "\033[31m""rTorrent is not installed. Nothing to do""\e[0m"
                            echo
                        fi
                            ;;
                    "2")
                        echo
                        if [[ -d ~/private/deluge ]]
                        then
                            echo -e "\033[31m""Stopping Deluge and Deluge Web""\e[0m"
                            killall -u $(whoami) deluged deluge-web
                            echo "Restarting Deluge"
                            deluged
                            echo "Restarting Deluge Web"
                            deluge-web --fork
                            echo
                            echo -e "\033[33m""Are the processes running?""\e[0m"
                            echo
                            ps x | grep deluge | grep -v grep
                            echo
                            echo -e "\033[32m""For troubleshooting refer to the FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=158""\e[0m"
                            echo
                            sleep 2
                        else
                            echo -e "\033[31m""Deluge is not installed. Nothing to do""\e[0m"
                            echo
                        fi
                            ;;
                    "3")
                        echo
                        if [[ -d ~/private/transmission ]]
                        then
                            echo -e "\033[31m""Restarting Transmission""\e[0m"
                            killall -u $(whoami) transmission-daemon
                            echo "It can take up to 5 minutes for transmission to restart."
                            echo
                            echo "Do this command to see if it is running":
                            echo
                            echo -e "\033[31m""ps x | grep transmission | grep -v grep""\e[0m"
                            echo
                            echo -e "\033[32m""For troubleshooting refer to the FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=158""\e[0m"
                            echo
                            sleep 2
                        else
                            echo -e "\033[31m""Transmission is not installed. Nothing to do""\e[0m"
                            echo
                        fi
                            ;;
                    "4")
                            echo
                            if [[ -d ~/private/mysql ]]
                                then
                                echo -e "\033[31m""Restarting MySQL""\e[0m"
                                killall -9 -u $(whoami) mysqld mysqld_safe
                                bash ~/private/mysql/launch.sh > /dev/null 2>&1
                                echo "Mysql has been restarted"
                                echo
                                echo -e "\033[32m""For troubleshooting refer to the FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=158""\e[0m"
                                echo
                                sleep 2
                            else
                                echo -e "\033[31m""Mysql is not installed, nothing to restart. Please install it first""\e[0m"
                                echo
                            fi
                            ;;
                    "5")
                            echo
                            echo -e "\033[31m""You chose to quit this script""\e[0m"
                            echo
                            exit
                            ;;
            esac
    done
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit
fi
#
############################
##### Core Script Ends #####
############################
#