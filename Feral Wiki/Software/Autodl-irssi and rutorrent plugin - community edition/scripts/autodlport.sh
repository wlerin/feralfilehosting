#!/bin/bash
# autodlport.sh
scriptversion="1.0.5"
scriptname="autodlport"
# randomessence
#
# wget -qO ~/autodlport.sh http://git.io/vCft_Q && bash ~/autodlport.sh
#
############################
## Version History Starts ##
############################
#
# 1.0.5 updater template merged
# 1.0.4 updater template merged
# 1.0.3 general formatting
# 1.0.2 generates optional password for the user like the install script.
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
port=$(shuf -i 6000-50000 -n 1)
pass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh"
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" >/dev/null 2>&1
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" >/dev/null 2>&1
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
    if [[ -f ~/.autodl/autodl.cfg && -f ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php ]]
    then
        echo "This script will change your password and port for autodl and the rutorrent plugin, then restart irssi."
        echo
        echo -e "\033[31m""A randomly generated 20 character password has been set for you by this script""\e[0m"
        echo
        # Sed command to enter the port variable
        sed -ri 's|(.*)gui-server-port =(.*)|gui-server-port = '"$port"'|g' ~/.autodl/autodl.cfg
        # Sed command to enter the password variable
        sed -ri 's|(.*)gui-server-password =(.*)|gui-server-password = '"$pass"'|g' ~/.autodl/autodl.cfg
        # Uses echo to make the config file for the rutorrent plugun to work with autodl uinsg the variables port and pass
        echo -ne '<?php\n$autodlPort = '"$port"';\n$autodlPassword = "'"$pass"'";\n?>' > ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php
        # Kill all irssi instances before starting
        killall -9 -u $(whoami) irssi >/dev/null 2>&1
        # Clear dead screens
        screen -wipe >/dev/null 2>&1
        # Start autodl irssi in a screen in the background.
        screen -dmS autodl irssi
        echo "The port and password have been updated. Attach to the running screen using this command:"
        echo
        echo -e "\033[32m""screen -r autodl""\e[0m"
        echo
    else
        echo
        echo -e "The required files do not exist, please install autodl irssi using the bash script first."
        echo
        if [[ ! -f "$HOME/.autodl/autodl.cfg" ]]
        then
            echo -e "\033[36m""~/.autodl/autodl.cfg""\e[0m"" is missing"
        fi
        if [[ ! -f "$HOME/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php" ]]
        then
            echo -e "\033[36m""/rutorrent/plugins/autodl-irssi/conf.php""\e[0m"" is missing"
        fi
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