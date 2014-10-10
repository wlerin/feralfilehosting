#!/bin/bash
# autodlrutorrentfix.sh
scriptversion="1.1.0"
scriptname="autodlrutorrentfix"
# randomessence
#
# wget -qO ~/autodlrutorrentfix.sh http://git.io/BBUryw && bash ~/autodlrutorrentfix.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.6 updater template merged
# v1.1.0 autodl multi instances
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/autodlrutorrentfix.sh"
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
read -ep "Do you need to fix a custom instance [y]es or [n]o: " yesido
echo
if [[ "$yesido" =~ ^[Yy]$ ]]
then
    read -ep "What is the suffix of the instance you need to fix:" suffix
    if [[ -d "$HOME/.irssi-$suffix/scripts/AutodlIrssi" ]]
    then
        echo -e "\033[33m""Autodl Before""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/GuiServer.pm =" "\033[31m""$(sed -n "s/use constant LISTEN_ADDRESS => '\(.*\)';/\1/p" $HOME/.irssi-$suffix/scripts/AutodlIrssi/GuiServer.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm Result 1 =" "\033[31m""$(sed -n 's/\(.*\)$rtAddress = "\(.*\)$rtAddress" if $rtAddress =~ \/^:\\d{1,5}$\/;/\2/p' $HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm Result 2 =" "\033[31m""$(sed -n 's/\(.*\)my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "\(.*\)"});/\2/p' $HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m" 
        echo
        #
        echo -e "\033[31m""Applying some fixes to autodl if needed.""\e[0m"
        echo
        sed -i 's|return File::Spec->catfile(getHomeDir(), ".autodl");|return File::Spec->catfile(getHomeDir(), ".autodl-'"$suffix"'");|g' "$HOME/.irssi-$suffix/scripts/AutodlIrssi/Dirs.pm"
        sed -i "s/use constant LISTEN_ADDRESS => '127.0.0.1';/use constant LISTEN_ADDRESS => '10.0.0.1';/g" "$HOME/.irssi-$suffix/scripts/AutodlIrssi/GuiServer.pm"
        sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' "$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm"
        sed -i 's/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});/g' "$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm"
        #
        echo -e "\033[33m""Autodl After""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/GuiServer.pm =" "\033[31m""$(sed -n "s/use constant LISTEN_ADDRESS => '\(.*\)';/\1/p" $HOME/.irssi-$suffix/scripts/AutodlIrssi/GuiServer.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm Result 1 =" "\033[31m""$(sed -n 's/\(.*\)$rtAddress = "\(.*\)$rtAddress" if $rtAddress =~ \/^:\\d{1,5}$\/;/\2/p' $HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm Result 2 =" "\033[31m""$(sed -n 's/\(.*\)my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "\(.*\)"});/\2/p' $HOME/.irssi-$suffix/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m" 
        echo
    else
        echo -e "\033[36m""$HOME/.irssi-$suffix/scripts/AutodlIrssi/""\e[0m" "does not exist"
        echo
        echo -e "\033[36m""Install autodl using the bash script installer in the FAQ"
        echo
        exit
    fi
    #
    if [[ -d "$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/plugins/autodl-irssi" ]]
    then
        echo -e "\033[33m""Autodl-rutorrent Before""\e[0m"
        echo -e "\033[32m""/rutorrent-$suffix/plugins/autodl-irssi/getConf.php =" "\033[31m""$(sed -n 's/\(.*\)if (\!socket_connect($socket, "\(.*\)", $autodlPort))/\2/p' $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/getConf.php 2> /dev/null)""\e[0m"
        echo
        #
        echo -e "\033[31m""Applying some fixes to autodl rutorrent plugin if needed.""\e[0m"
        echo
        sed -i 's/if (!socket_connect($socket, "127.0.0.1", $autodlPort))/if (!socket_connect($socket, "10.0.0.1", $autodlPort))/g' "$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/plugins/autodl-irssi/getConf.php"
        echo -e "\033[33m""Autodl-rutorrent After""\e[0m"
        echo -e "\033[32m""/rutorrent/plugins/autodl-irssi/getConf.php =" "\033[31m""$(sed -n 's/\(.*\)if (\!socket_connect($socket, "\(.*\)", $autodlPort))/\2/p' $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/plugins/autodl-irssi/getConf.php 2> /dev/null)""\e[0m"
        echo
    else
        echo -e "\033[36m""$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/plugins/autodl-irssi/""\e[0m" "does not exist"
        echo
        exit 1
    fi
    screen -S autodl-"$suffix" -X quit > /dev/null 2>&1
    screen -wipe > /dev/null 2>&1
    screen -dmS autodl-"$suffix" irssi --home="$HOME"/.irssi-"$suffix"/
    echo -e "\033[33m""Checking we restarted irssi or if there are multiple screens/processes""\e[0m"
    echo
    screen -ls | grep autodl-"$suffix"
    echo
    echo -e "Done. Please refresh/reload rutorrent using CTRL + F5"
    echo
    echo -e "This fix might have to be run each time you update/overwrite the autodl or autodl-rutorrent files."
    echo
    exit 1
else
    if [[ -d "$HOME/.irssi/scripts/AutodlIrssi" ]]
    then
        echo -e "\033[33m""Autodl Before""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/GuiServer.pm =" "\033[31m""$(sed -n "s/use constant LISTEN_ADDRESS => '\(.*\)';/\1/p" $HOME/.irssi/scripts/AutodlIrssi/GuiServer.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm Result 1 =" "\033[31m""$(sed -n 's/\(.*\)$rtAddress = "\(.*\)$rtAddress" if $rtAddress =~ \/^:\\d{1,5}$\/;/\2/p' $HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm Result 2 =" "\033[31m""$(sed -n 's/\(.*\)my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "\(.*\)"});/\2/p' $HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m" 
        echo
        #
        echo -e "\033[31m""Applying some fixes to autodl if needed.""\e[0m"
        echo
        sed -i "s/use constant LISTEN_ADDRESS => '127.0.0.1';/use constant LISTEN_ADDRESS => '10.0.0.1';/g" "$HOME/.irssi/scripts/AutodlIrssi/GuiServer.pm"
        sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' "$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm"
        sed -i 's/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});/g' "$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm"
        #
        echo -e "\033[33m""Autodl After""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/GuiServer.pm =" "\033[31m""$(sed -n "s/use constant LISTEN_ADDRESS => '\(.*\)';/\1/p" $HOME/.irssi/scripts/AutodlIrssi/GuiServer.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm Result 1 =" "\033[31m""$(sed -n 's/\(.*\)$rtAddress = "\(.*\)$rtAddress" if $rtAddress =~ \/^:\\d{1,5}$\/;/\2/p' $HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m"
        echo -e "\033[32m""$HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm Result 2 =" "\033[31m""$(sed -n 's/\(.*\)my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "\(.*\)"});/\2/p' $HOME/.irssi/scripts/AutodlIrssi/MatchedRelease.pm 2> /dev/null)""\e[0m" 
        echo
    else
        echo -e "\033[36m""$HOME/.irssi/scripts/AutodlIrssi/""\e[0m" "does not exist"
        echo
        echo -e "\033[36m""Install autodl using the bash script installer in the FAQ"
        echo
        exit
    fi
    #
    if [[ -d "$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi" ]]
    then
        echo -e "\033[33m""Autodl-rutorrent Before""\e[0m"
        echo -e "\033[32m""/rutorrent/plugins/autodl-irssi/getConf.php =" "\033[31m""$(sed -n 's/\(.*\)if (\!socket_connect($socket, "\(.*\)", $autodlPort))/\2/p' $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/getConf.php 2> /dev/null)""\e[0m"
        echo
        #
        echo -e "\033[31m""Applying some fixes to autodl rutorrent plugin if needed.""\e[0m"
        echo
        sed -i 's/if (!socket_connect($socket, "127.0.0.1", $autodlPort))/if (!socket_connect($socket, "10.0.0.1", $autodlPort))/g' "$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/getConf.php"
        echo -e "\033[33m""Autodl-rutorrent After""\e[0m"
        echo -e "\033[32m""/rutorrent/plugins/autodl-irssi/getConf.php =" "\033[31m""$(sed -n 's/\(.*\)if (\!socket_connect($socket, "\(.*\)", $autodlPort))/\2/p' $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/getConf.php 2> /dev/null)""\e[0m"
        echo
    else
        echo -e "\033[36m""$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/""\e[0m" "does not exist"
        echo
        exit 1
    fi
    screen -S autodl -X quit > /dev/null 2>&1
    screen -wipe > /dev/null 2>&1
    screen -dmS autodl irssi
    echo -e "\033[33m""Checking we restarted irssi or if there are multiple screens/processes""\e[0m"
    echo
    screen -ls | grep autodl
    echo
    echo -e "Done. Please refresh/reload rutorrent using CTRL + F5"
    echo
    echo -e "This fix might have to be run each time you update/overwrite the autodl or autodl-rutorrent files."
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