#!/bin/bash
# Script name
scriptversion="1.0.0"
scriptname="delugethin"
# randomessence
#
# wget -qO ~/delugethin.sh http://git.io/obe0mA && bash ~/delugethin.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.0 templated updated
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Deluge%20Daemon%20-%20Remote%20control%20with%20the%20local%20Thin%20client/scripts/delugethin.sh"
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
    if [ -f ~/.config/deluge/core.conf ]
    then
        # Get hostname
        echo -e "Your" "\033[36m""hostname""\e[0m" "is:" "\033[36m""$(hostname)""\e[0m"
        # Get port
        echo -e "Your" "\033[31m""daemon port""\e[0m" "for the thin client is:" "\033[31m""$(sed -n -e 's/  "daemon_port": \(.*\),/\1/p' ~/.config/deluge/core.conf)""\e[0m"
        # Get username
        echo -e "Your" "\033[33m""username""\e[0m" "is:" "\033[33m""$(whoami)""\e[0m"
        # Get Password
        echo -e "Your" "\033[32m""password""\e[0m" "for the thin client is:" "\033[32m""$(cat ~/.config/deluge/auth | grep $(whoami) | cut -d\:  -f2)""\e[0m"
        # Enable remote connections
        sed -i 's|"allow_remote": false|"allow_remote": true|g' ~/.config/deluge/core.conf
        # kill deluge and the web gui
        killall -9 -u $(whoami) deluged deluge-web
        # restart it.
        deluged && deluge-web --fork
        echo
    else
        echo -e "\033[31m""Deluge is not installed""\e[0m" "or the" "\033[36m""~/.config/deluge/core.conf""\e[0m" "is missing. Please install it via the software page in your manager first.""\e[0m"
        echo
        exit 1
    fi
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