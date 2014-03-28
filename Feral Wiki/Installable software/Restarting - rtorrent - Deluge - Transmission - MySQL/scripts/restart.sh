#!/bin/bash
# restart.sh
scriptversion="1.0.2"
scriptname="restart"
# randomessence
#
# wget -qO ~/restart.sh http://git.io/5Uw8Gw && bash ~/restart.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.2 templated updated
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Restarting%20-%20rtorrent%20-%20Deluge%20-%20Transmission%20-%20MySQL/scripts/restart.sh"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p "$HOME/bin"
#
if [[ ! -f "$HOME/$scriptname.sh" ]]
then
    wget -qO "$HOME/$scriptname.sh" "$scripturl"
fi
if [[ ! -f "$HOME/bin/$scriptname" ]]
then
    wget -qO "$HOME/bin/$scriptname" "$scripturl"
fi
#
wget -qO "$HOME/000$scriptname.sh" "$scripturl"
#
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/111$scriptname.sh"
    bash "$HOME/111$scriptname.sh"
    exit 1
fi
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/222$scriptname.sh"
    bash "$HOME/222$scriptname.sh"
    exit 1
fi
cd && rm -f {000,111,222}"$scriptname.sh"
chmod -f 700 "$HOME/bin/$scriptname"
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
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
                            echo -e "\033[31m""Killing all instances of rtorrent""\e[0m"
                            echo
                            killall -9 -u $(whoami) rtorrent
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
                            ;;
                    "2")
                            echo
                            echo -e "\033[31m""Stopping Deluge and Deluge Web""\e[0m"
                            killall -9 -u $(whoami) deluged deluge-web
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
                            ;;
                    "3")
                            echo
                            echo -e "\033[31m""Restarting Transmission""\e[0m"
                            killall -9 -u $(whoami) transmission-daemon
                            echo "It can take up to 5 minutes for transmission to restart."
                            echo
                            echo "Do this command to see if it is running":
                            echo
                            echo -e "\033[31m""ps x | grep transmission | grep -v grep""\e[0m"
                            echo
                            echo -e "\033[32m""For troubleshooting refer to the FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=158""\e[0m"
                            echo
                            sleep 2
                            ;;
                    "4")
                            echo
                            if [[ -d ~/private/mysql ]]
                                then
                                echo -e "\033[31m""Restarting MySQL""\e[0m"
                                killall -9 -u $(whoami) mysqld mysqld_safe
                                bash ~/private/mysql/launch.sh > /dev/null 2>&1
                                echo "Mysql restarted"
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#