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
                        echo "Restarting rtorrent"
                        ;;
                "2")
                        echo "Restarting Deluge"
                        ;;
                "3")
                        echo "Restarting Transmission"
                        ;;
                "4")
                        echo "Restarting MySQL"
                        ;;
                "5")
                        exit
                        ;;
        esac
done
