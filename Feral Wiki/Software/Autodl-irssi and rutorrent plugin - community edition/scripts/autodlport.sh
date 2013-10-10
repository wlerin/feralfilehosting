#!/bin/bash
# autodlport.sh
scriptversion="1.0.0"
scriptname="autodlport"
# randomessence
#
# wget -qO ~/autodlport.sh http://git.io/vCft_Q && bash ~/autodlport.sh
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
# This updater deals with updating two files at the same time, the  "~/somescript.sh" and the "~/bin/somescript" . You can remove one part of the updater, if you wish, to focus on a single file instance.
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
mkdir -p $HOME/bin
#
if [ ! -f $HOME/autodlport.sh ]
then
    wget -qO $HOME/autodlport.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
fi
if [ ! -f $HOME/bin/autodlport ]
then
    wget -qO $HOME/bin/autodlport https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
fi
#
wget -qO $HOME/000autodlport.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
#
if ! diff -q $HOME/000autodlport.sh $HOME/autodlport.sh > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/autodlport.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
    wget -qO $HOME/bin/autodlport https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
    bash $HOME/autodlport.sh
    exit 1' > $HOME/111autodlport.sh
    bash $HOME/111autodlport.sh
    exit 1
fi
if ! diff -q $HOME/000autodlport.sh $HOME/bin/autodlport > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/autodlport.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
    wget -qO $HOME/bin/autodlport https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlport.sh
    bash $HOME/autodlport.sh
    exit 1' > $HOME/222autodlport.sh
    bash $HOME/222autodlport.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000autodlport.sh $HOME/111autodlport.sh $HOME/222autodlport.sh
chmod -f 700 $HOME/bin/autodlport
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
    port=$(shuf -i 6000-50000 -n 1)
    if [[ -f ~/.autodl/autodl.cfg && -f ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php ]]
    then
        echo
        echo "This script will change your password and port for autodl and the rutorrent plugin, then restart irssi."
        echo
        read -ep "Enter Password (No spaces please!): " pass
        echo
        echo -e "You entered" "\033[32m""$pass""\e[0m" "as your password."
        echo
        read -ep "Please confirm this is the password you wish to use [y/n]: " confirm
        echo
        if [[ $confirm =~ ^[Yy]$ ]]
        then
            sed -ri 's/(.*)gui-server-port =(.*)/gui-server-port = '$port'/g' ~/.autodl/autodl.cfg
            sed -ri 's/(.*)gui-server-password =(.*)/gui-server-password = '$pass'/g' ~/.autodl/autodl.cfg
            echo -e "<?php\n\$autodlPort = $port;\n\$autodlPassword = \"$pass\";\n?>" > ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php
            killall -9 irssi -u $(whoami) 2> /dev/null 
            screen -wipe > /dev/null 2>&1
            screen -dmS autodl irssi
            echo "The port and password have been updated. Attach to the running screen using this command:"
            echo
            echo -e "\033[32m""screen -r autodl""\e[0m"
            echo
        else
            bash ~/autodlport.sh
        fi        
    else
        echo
        echo -e "The required files do not exist, please install autodl irssi using the bash script first."
        echo
        if [[ ! -f ~/.autodl/autodl.cfg ]]
        then
            echo -e "\033[36m""~/.autodl/autodl.cfg""\e[0m"" is missing"
        fi
        if [[ ! -f ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php ]]
        then
            echo -e "\033[36m""/rutorrent/plugins/autodl-irssi/conf.php""\e[0m"" is missing"
        fi
        echo
    fi
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