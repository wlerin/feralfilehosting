#!/bin/bash
# autodlport.sh
scriptversion="1.0.4"
scriptname="autodlport"
# randomessence
#
# wget -qO ~/autodlport.sh http://git.io/vCft_Q && bash ~/autodlport.sh
#
############################
## Version History Starts ##
############################
#
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
pass=$(< /dev/urandom tr -dc '12345!@#ANCDEFGHIJKLMNOPabcdefghijklmnop' | head -c${1:-20};echo;)
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
    if [[ -f "$HOME/.autodl/autodl.cfg" && -f "$HOME/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php" ]]
    then
        echo "This script will change your password and port for autodl and the rutorrent plugin, then restart irssi."
        echo
        echo -e "\033[31m""A randomly generated password has been set for you, you can just press enter""\e[0m"
        echo
        read -ep "Enter Password (No spaces please!): " -i "$pass" pass
        echo
        echo -e "You entered" "\033[32m""$pass""\e[0m" "as your password."
        echo
        read -ep "Please confirm this is the password you wish to use [y/n]: " confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
            sed -ri 's/(.*)gui-server-port =(.*)/gui-server-port = '"$port"'/g' "$HOME/.autodl/autodl.cfg"
            sed -ri 's/(.*)gui-server-password =(.*)/gui-server-password = '"$pass"'/g' "$HOME/.autodl/autodl.cfg"
            echo -e "<?php\n\$autodlPort = $port;\n\$autodlPassword = \"$pass\";\n?>" > "$HOME/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php"
            killall -9 irssi -u $(whoami) 2> /dev/null 
            screen -wipe > /dev/null 2>&1
            screen -dmS autodl irssi
            echo "The port and password have been updated. Attach to the running screen using this command:"
            echo
            echo -e "\033[32m""screen -r autodl""\e[0m"
            echo
        else
            bash "$HOME/autodlport.sh"
        fi        
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
        e
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