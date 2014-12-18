#!/bin/bash
# Install Syncthing
scriptversion="1.0.1"
scriptname="install.syncthing"
syncthingversion="0.10.12"
# randomessence
#
# wget -qO ~/install.syncthing http://git.io/-MNlxQ && bash ~/install.syncthing
#
############################
## Version History Starts ##
############################
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/scripts/install.syncthing.sh"
#
############################
####### Variable End #######
############################
#
guiport=$(shuf -i 10001-49000 -n 1)
syncport=$(expr 1 + $guiport)
#
apacheconf="http://git.io/WqUqBQ"
nginxconf="http://git.io/TnhqpA"
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
    read -ep "What is the current version of syncthing, for example 0.10.12 ?: " -i "$syncthingversion" mainversion
	wget -qO ~/syncthing.tar.gz "https://github.com/syncthing/syncthing/releases/download/v$mainversion/syncthing-linux-amd64-v$mainversion.tar.gz"
    tar xf ~/syncthing.tar.gz
    mv ~/syncthing-linux-amd64-v"$syncthingversion"/syncthing ~/bin/
    cd && rm -rf syncthing{-linux-amd64-v"$syncthingversion",.tar.gz}
    #
    ~/bin/syncthing -generate="~/.config/syncthing"
    sed -i -r 's#<address>127.0.0.1:(.*)</address>#<address>10.0.0.1:'"$guiport"'</address>#g' ~/.config/syncthing/config.xml
    sed -i 's#<listenAddress>0.0.0.0:22000</listenAddress>#<listenAddress>0.0.0.0:'"$syncport"'</listenAddress>#g' ~/.config/syncthing/config.xml
    # Apache proxypass
    wget -qO ~/.apache2/conf.d/syncthing.conf "$apacheconf"
    sed -i -r 's#PORT#'"$guiport"'#g' ~/.apache2/conf.d/syncthing.conf
    /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
    # nginx proxypass
    if [[ -d ~/.nginx ]]
    then
        wget -qO ~/.nginx/conf.d/000-default-server.d/syncthing.conf "$nginxconf"
        sed -i -r 's#USERNAME#'"$(whoami)"'#g' ~/.nginx/conf.d/000-default-server.d/syncthing.conf
        sed -i -r 's#PORT#'"$guiport"'#g' ~/.nginx/conf.d/000-default-server.d/syncthing.conf
        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    fi
    screen -dmS syncthing ~/bin/syncthing
    echo
    echo "https://$(hostname -f)/$(whoami)/syncthing/"
    echo
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