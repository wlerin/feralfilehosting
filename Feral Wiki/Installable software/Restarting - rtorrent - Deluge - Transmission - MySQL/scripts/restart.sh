#!/bin/bash
#
# http://grover.open2space.com/content/bash-script-menus-and-functions

showMenu () 
{
        echo "1"": rtorrent"
        echo "2"": Deluge"
        echo "3"": Tranmission"
        echo "4"": MySQL"
        echo "5"": quit"
}

while [ 1 ]
do
        showMenu
        read CHOICE
        case "$CHOICE" in
                "1")
                        echo "Killing all instances and restarting rtorrent"
                        killall -9 -u $(whoami) rtorrent
                        screen -wipe > /dev/null 2>&1
                        sleep 2
                        screen -fa -dmS rtorrent rtorrent
                        sleep 2
                        echo "Is the process running?"
                        echo
                        ps x | grep current/bin/rtorrent | grep -v grep
                        echo "Is the screen running?"
                        screen -ls | grep rtorrent
                        echo
                        echo "If rtorrent is not running please refer to the FAQ for troubleshooting."
                        ;;
                "2")
                        echo "Restarting Deluge"
                        killall -9 -u $(whoami) deluged deluge-web
                        deluged && deluge-web --fork
                        ;;
                "3")
                        echo "Restarting Transmission"
                        killall -9 -u $(whoami) transmission-daemon
                        echo "It can take up to 5 minutes for transmission to restart."
                        ;;
                "4")
                        echo "Restarting MySQL"
                        killall -9 -u $(whoami) mysqld mysqld_safe
                        bash ~/private/mysql/launch.sh &
                        ;;
                "5")
                        exit
                        ;;
        esac
done
