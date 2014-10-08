#!/bin/bash
#
# http://grover.open2space.com/content/bash-script-menus-and-functions

showMenu () 
{
        echo "1) bob"
        echo "2) amy"
        echo "3) quit"
        echo
}

while [ 1 ]
do
        showMenu
        read -e CHOICE
        echo
        case "$CHOICE" in
                "1")
                        echo
                        echo "Bob was here"
                        echo
                        ;;
                "2")
                        echo
                        echo "Amy was here"
                        echo
                        ;;
                "3")
                        echo
                        echo "You chose to quit the script."
                        echo
                        exit
                        ;;
        esac
done
