#!/bin/bash
# trackerlist.sh
scriptversion="1.0.0"
scriptname="trackerlist"
# randomessence
#
# wget -qO ~/trackerlist.sh http://git.io/kv9LsQ && bash ~/trackerlist.sh
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
if [ ! -f $HOME/trackerlist.sh ]
then
    wget -qO $HOME/trackerlist.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
fi
if [ ! -f $HOME/bin/trackerlist ]
then
    wget -qO $HOME/bin/trackerlist https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
fi
#
wget -qO $HOME/000trackerlist.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
#
if ! diff -q $HOME/000trackerlist.sh $HOME/trackerlist.sh > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/trackerlist.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
    wget -qO $HOME/bin/trackerlist https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
    bash $HOME/trackerlist.sh
    exit 1' > $HOME/111trackerlist.sh
    bash $HOME/111trackerlist.sh
    exit 1
fi
if ! diff -q $HOME/000trackerlist.sh $HOME/bin/trackerlist > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/trackerlist.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
    wget -qO $HOME/bin/trackerlist https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh
    bash $HOME/trackerlist.sh
    exit 1' > $HOME/222trackerlist.sh
    bash $HOME/222trackerlist.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000trackerlist.sh $HOME/111trackerlist.sh $HOME/222trackerlist.sh
chmod -f 700 $HOME/bin/trackerlist
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
if [[ -d ~/.irssi/scripts/AutodlIrssi ]]
then
    echo "Downloading and extracting latest tracker list"
    rm -rf ~/.irssi/scripts/AutodlIrssi/trackers/*
    wget -qO ~/autodl-trackers.zip https://autodl-irssi-community.googlecode.com/files/autodl-trackers.zip
    unzip -qo ~/autodl-trackers.zip -d ~/.irssi/scripts/AutodlIrssi/trackers/
    rm -f ~/autodl-trackers.zip
    echo "Killing all Irssi processes"
    killall -u $(whoami) irssi
    echo "Restarting Irssi for the changes to take effect"
    screen -dmS autodl irssi
    echo "done"
    echo
    screen -ls | grep autodl
    echo
else
    echo -e "\033[31m""Make sure you have installed autodl first before using this trackerlist script:""\e[0m"
    echo
    echo -e "\033[32m""wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh""\e[0m"
    echo
    exit 1
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