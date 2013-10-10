#!/bin/bash
# restart.sh
#
# wget -qO ~/restart.sh http://git.io/5Uw8Gw && bash ~/restart.sh
#
scriptversion="1.0.0"
scriptname="restart"
# randomessence
#
############################
## Version History Starts ##
############################
#
# How do I customise this updater? 
# 1: scriptversion="0.0.0" replace "0.0.0" with your script version. This will be shown to the user at the current version.
# 2: scriptname="somescript" replace "somescript" with your script name. this will be shown to the user when they first run the script.
# 3: Search and replace all instances of "somescript", 29 including this one, with the name of your script, do not include the .sh aside from doing step 2.
# 4: Then replace ALL "https://raw.github.com/feralhosting" with the URL to the RAW script URL.
# 5: Insert you script in the "Script goes here" labelled section 
#
# This updater deals with updating a single file, the  "~/somescript.sh".
#
############################
### Version History Ends ###
############################
#
#
############################
###### Variable Start ######
############################
#
#
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
if [ ! -f $HOME/restart.sh ]
then
    wget -qO $HOME/restart.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Restarting%20-%20rtorrent%20-%20Deluge%20-%20Transmission%20-%20MySQL/scripts/restart.sh
fi
#
wget -qO $HOME/000restart.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Restarting%20-%20rtorrent%20-%20Deluge%20-%20Transmission%20-%20MySQL/scripts/restart.sh
#
if ! diff -q $HOME/000restart.sh $HOME/restart.sh > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/restart.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Restarting%20-%20rtorrent%20-%20Deluge%20-%20Transmission%20-%20MySQL/scripts/restart.sh
    bash $HOME/restart.sh
    exit 1' > $HOME/111restart.sh
    bash $HOME/111restart.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000restart.sh $HOME/111restart.sh
#
############################
##### Self Updater End #####
############################
#
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ $updatestatus =~ ^[Yy]$ ]]
then
#
############################
####### Script Start #######
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
                            echo "Restaring rtorrent"
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
####### Script Ends  #######
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    exit 1
    cd && bash
fi