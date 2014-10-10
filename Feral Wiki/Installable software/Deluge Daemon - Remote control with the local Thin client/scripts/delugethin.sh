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
        echo -e "Your" "\033[36m""hostname""\e[0m" "is:" "\033[36m""$(hostname -f)""\e[0m"
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