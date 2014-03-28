#!/bin/bash
# trackerlist.sh
scriptversion="1.0.2"
scriptname="trackerlist"
# randomessence
#
# wget -qO ~/trackerlist.sh http://git.io/kv9LsQ && bash ~/trackerlist.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.2 updater template merged
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
autodltrackers="https://bitbucket.org/autodl-community/autodl-irssi/downloads/autodl-trackers.zip"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/trackerlist.sh"
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
	if [[ -d ~/.irssi/scripts/AutodlIrssi ]]
	then
		echo "Downloading and extracting latest tracker list"
		rm -rf ~/.irssi/scripts/AutodlIrssi/trackers/*
		wget -qO ~/autodl-trackers.zip "$autodltrackers"
		unzip -qo ~/autodl-trackers.zip -d ~/.irssi/scripts/AutodlIrssi/trackers/
		rm -f ~/autodl-trackers.zip
		echo "Killing all Irssi processes"
		killall -u $(whoami) irssi
		echo "Restarting Irssi for the changes to take effect"
		screen -dmS autodl irssi
		screen -S autodl -p 0 -X stuff '/autodl update^M'
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