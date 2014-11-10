#!/bin/bash
# trackerlist.sh
scriptversion="1.0.3"
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
autodltrackers="http://update.autodl-community.com/autodl-trackers.zip"
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
[[ ! -d ~/bin ]] && mkdir -p ~/bin
[[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
#
wget -qO ~/.000"$scriptname" "$scripturl"
#
if [[ $(sha256sum ~/.000"$scriptname" | awk '{print $1}') != $(sha256sum ~/bin/"$scriptname" | awk '{print $1}') ]]
then
    echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
    bash ~/.111"$scriptname"
    exit
else
    if [[ -z $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') && $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') -ne "$$" ]]
    then
        echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname"
        bash ~/.222"$scriptname"
        exit
    fi
fi
cd && rm -f .{000,111,222}"$scriptname"
chmod -f 700 ~/bin/"$scriptname"
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
read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
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
		echo "Closing some required stuff"
        # Kill all irssi instances before starting
        screen -S autodl -X quit > /dev/null 2>&1
        # Wipe any dead screens left behind
        screen -wipe >/dev/null 2>&1
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
		echo -e "\033[32m""wget -qO ~/install.autodl.sh http://git.io/oTUCMg && bash ~/install.autodl.sh""\e[0m"
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