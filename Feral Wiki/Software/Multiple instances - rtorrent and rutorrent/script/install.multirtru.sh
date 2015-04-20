#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomessence
#
# Script Contributors: 
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/install.multirtru http://git.io/_zVu0A && bash ~/install.multirtru
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
##
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z $1 && $1 == 'changelog' ]]; then echo
    #
    echo 'v1.3.0 Moved to menu style script. auto password generation to make sure nginx rpc is set. new update option that uses rutorrent github. new autodl fix only option. various other tweaks and fixes.'
    echo 'v1.2.2 bug fixes'
    echo 'v1.1.6 random password option'
    echo 'v1.1.5 more tweaks and fixed loop.'
    echo 'v1.1.3 small tweaks to installation script'
    echo 'v1.1.2 template updated'
    echo 'v1.2.1 autodl custom installation included'
    echo 'v1.2.0 hostname -f'
    #
    echo
    exit
fi
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Script Version number is set here.
scriptversion="1.3.0"
#
# Script name goes here. Please prefix with install.
scriptname="install.multirtru"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/_zVu0A"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Multiple%20instances%20-%20rtorrent%20and%20rutorrent/script/install.multirtru.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport=$(shuf -i 10001-49999 -n 1); done
#
# Script user's http www URL in the format http://username.server.feralhosting.com/
host1http="http://$(whoami).$(hostname -f)/"
# Script user's https www URL in the format https://username.server.feralhosting.com/
host1https="https://$(whoami).$(hostname -f)/"
# Script user's http www url in the format https://server.feralhosting.com/username/
host2http="http://$(hostname -f)/$(whoami)/"
# Script user's https www url in the format https://server.feralhosting.com/username/
host2https="https://$(hostname -f)/$(whoami)/"
#
# feralwww - sets the full path to the default public_html directory if it exists.
[[ -d ~/www/$(whoami).$(hostname -f)/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
# Bug reporting varaibles.
makeissue=".makeissue $scriptname A description of the issue"
ticketurl="https://www.feralhosting.com/manager/tickets/new"
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
option1="Install a Custom Instance."
option2="Update a custom Instance"
option3="Remove a Custom Instance"
option4="Fix autoldl on a custom Instance"
option5="Quit the Script"
#
giturl="https://github.com/Novik/ruTorrent.git"
#
# autodl configuration passwords
autodlpass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
#
# Some basic plugins
feralstats="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Feralstats%20plugin%20for%20ruTorrent/files/feralstats.zip"
ratiocolor="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Rutorrent%20-%20Colored%20Ratio%20Column%20Plugin/ratiocolor-1/ratiocolor.zip"
#
# rtorrent.rc template
confurl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Multiple%20instances%20-%20rtorrent%20and%20rutorrent/conf/.rtorrent.rc"
#
autodlirssicommunity="http://update.autodl-community.com/autodl-irssi-community.zip"
autodltrackers="http://update.autodl-community.com/autodl-trackers.zip"
#
# URL for autodl-rutorrent
autodlrutorrent="https://github.com/autodl-community/autodl-rutorrent/archive/master.zip"
#
rutorrentgit="https://github.com/Novik/ruTorrent/archive/master.zip"
rutorrentconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Multiple%20instances%20-%20rtorrent%20and%20rutorrent/conf/rutorrent-3.7.conf"
#
############################
### Custom Variables End ###
############################
#
# Disables the built in script updater permanently by setting this variable to 0.
updaterenabled="1"
#
############################
####### Variable End #######
############################
#
############################
###### Function Start ######
############################
#
function functionone {
    if [[ -f ~/multirtru.restart.txt && -s ~/multirtru.restart.txt ]]
    then
        echo -e "\033[32m""Existing custom installations read from the ~/multirtru.restart.txt""\e[0m"
        echo
        sed -rn "s/screen -fa -dmS rtorrent-(.*) rtorrent -n -o import=\~\/.rtorrent-(.*).rc/\2/p" ~/multirtru.restart.txt
        echo
    fi
}
#
function functiontwo {
    suffix=""
    functionone
    while [[ -z "$suffix" ]]
    do
        read -ep "What is the name of suffix you wish to modify?: " suffix
        echo
    done
}
#
############################
####### Function End #######
############################
#
############################
#### Script Help Starts ####
############################
#
if [[ ! -z $1 && $1 == 'help' ]]
then
    echo
    echo -e "\033[32m""Script help and usage instructions:""\e[0m"
    echo
    #
    ###################################
    ##### Custom Help Info Starts #####
    ###################################
    #
    echo -e "Put your help instructions or script guidance here"
    #
    ###################################
    ###### Custom Help Info Ends ######
    ###################################
    #
    echo
    exit
fi
#
############################
##### Script Help Ends #####
############################
#
############################
#### Script Info Starts ####
############################
#
# Use this to show a user script information when they use the info option with the script.
if [[ ! -z $1 && $1 == 'info' ]]
then
    echo
    echo -e "\033[32m""Script Details:""\e[0m"
    echo
    echo "Script version: $scriptversion"
    echo
    echo "Script Author: $scriptauthor"
    echo
    echo "Script Contributors: $contributors"
    echo
    echo -e "\033[32m""Script options:""\e[0m"
    echo
    echo -e "\033[36mhelp\e[0m = See the help section for this script."
    echo
    echo -e "Example usage: \033[36m$scriptname help\e[0m"
    echo
    echo -e "\033[36mchangelog\e[0m = See the version history and change log of this script."
    echo
    echo -e "Example usage: \033[36m$scriptname changelog\e[0m"
    echo
    echo -e "\033[36minfo\e[0m = Show the script information and usage instructions."
    echo
    echo -e "Example usage: \033[36m$scriptname info\e[0m"
    echo
    echo -e "\033[31mImportant note:\e[0m Options \033[36mqr\e[0m and \033[36mnu\e[0m are interchangeable and usable together."
    echo
    echo -e "For example: \033[36m$scriptname qr nu\e[0m or \033[36m$scriptname nu qr\e[0m will both work"
    echo
    echo -e "\033[36mqr\e[0m = Quick Run - use this to bypass the default update prompts and run the main script directly."
    echo
    echo -e "Example usage: \033[36m$scriptname qr\e[0m"
    echo
    echo -e "\033[36mnu\e[0m = No Update - disable the built in updater. Useful for testing new features or debugging."
    echo
    echo -e "Example usage: \033[36m$scriptname nu\e[0m"
    echo
    echo -e "\033[32mBash Commands:\e[0m"
    echo
    echo -e "\033[36m""$gitiocommand""\e[0m"
    echo
    echo -e "\033[36m""~/bin/$scriptname""\e[0m"
    echo
    echo -e "\033[36m""$scriptname""\e[0m"
    echo
    echo -e "\033[32m""Bug Reporting:""\e[0m"
    echo
    echo -e "These are the recommended ways to report bugs for scripts in the FAQs:"
    echo
    echo -e "1: In IRC you can use wikibot to create a github issue by using this command format:"
    echo
    echo -e "\033[36m""$makeissue""\e[0m"
    echo
    echo -e "2: You could open a ticket describing the problem with details of which script and what the problem is."
    echo
    echo -e "\033[36m""$ticketurl""\e[0m"
    echo
    echo -e "3: You can create an issue directly on github using your github account."
    echo
    echo -e "\033[36m""$gitissue""\e[0m"
    echo
    echo -e "\033[33m""All bug reports are welcomed and very much appreciated, as they benefit all users.""\033[32m"
    #
    echo
    exit
fi
#
############################
##### Script Info Ends #####
############################
#
############################
#### Self Updater Start ####
############################
#
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq 1 ]]
    then
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
        echo
    else
        echo
        echo "The Updater has been disabled"
        echo
        scriptversion="$scriptversion-DEV"
    fi
fi
#
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
if [[ -f ~/.quickrun ]];then updatestatus="y"; rm -f ~/.quickrun; fi
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" == "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
    echo
fi
#
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    showMenu () 
    {
            #
            echo "1) $option1"
            echo "2) $option2"
            echo "3) $option3"
        echo "4) $option4"
            echo "5) $option5"
            #
            echo
    }

    while [ 1 ]
    do
            showMenu
            read -e CHOICE
            echo
            case "$CHOICE" in
                    "1")
                            suffix=""
                            echo -e "This script will create a new rutorrent,rtorrent and (optionally) autodl instance using a suffix, for example:"
                            echo
                            echo -e "For example: ""\033[32m""rutorrent-1 ""\e[0m""\033[33m""autodl-1 and irssi-1 ""\e[0m""\033[36m""rtorrent-1 and ~/.rtorrent-1.rc""\e[0m"
                            echo
                            echo -e "\033[31m""The first thing we need to do is pick a suffix to use:""\e[0m"
                            echo
                            while [[ -z "$suffix" ]]
                            do
                                read -ep "Please chose a suffix to use for our new installations: " suffix
                            done
                            echo
                            if [[ ! -f ~/.rtorrent-"$suffix".rc && ! -d ~/private/rtorrent-"$suffix" && ! -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix" ]]
                            then
                                echo -e "\033[31m""1:""\e[0m" "Creating the installation"
                                echo
                                # Create some folders we need
                                mkdir -p ~/private/rtorrent-"$suffix"/data ~/private/rtorrent-"$suffix"/watch ~/private/rtorrent-"$suffix"/work
                                # Copy the Feral rutorrent template
                                cp -rf /opt/rutorrent/current/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"
                                # Make sure rtorrent adder will work with nginx by creating this folder.
                                mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/share/torrents
                                # Download and install the Feral stats plugin
                                wget -qO ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip "$feralstats"
                                unzip -qo ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/
                                rm -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip
                                # Download and install the ratio colour plugin
                                wget -qO ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip "$ratiocolor"
                                unzip -qo ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/
                                rm -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip
                                # Download and configure the custom .rtorrent.rc
                                wget -qO ~/.rtorrent-"$suffix".rc "$confurl"
                                #
                                # sed custom ~/.rtorrent.rc
                                echo -e "\033[31m""2:""\e[0m" "\033[32m""Part 1""\e[0m" "Editing the files: rtorrent"
                                echo
                                sed -i 's|/media/DiskID/home/username/private/rtorrent/|'"$HOME"'/private/rtorrent-'"$suffix"'/|g' ~/.rtorrent-"$suffix".rc
                                sed -i 's|/media/DiskID/home/username/www/username.server.feralhosting.com/public_html/rutorrent/php/initplugins.php username|'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/rutorrent-'"$suffix"'/php/initplugins.php '$(whoami)'|g' ~/.rtorrent-"$suffix".rc
                                # sed /rutorrent/
                                echo -e "\033[31m""2:""\e[0m" "\033[33m""Part 2""\e[0m" "Editing the files: rutorrent"
                                echo
                                sed -i 's|/private/rtorrent/.socket|/private/rtorrent-'"$suffix"'/.socket|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/conf/config.php
                                #
                                echo 'screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~/.rtorrent-'"$suffix"'.rc' >> ~/multirtru.restart.txt
                                ############################
                                ############################
                                ############################
                                read -ep "Would you like this script to install and configure Autodl-irssi for this instance to? [y]es or [n]o: " -i "y" autodlinstall
                                echo
                                if [[ "$autodlinstall" =~ ^[Yy]$ ]]
                                then
                                    ############################
                                    ####### Autodl Start #######
                                    ############################
                                    #
                                    echo -e "\033[32m""Installing autodl-irssi and the rutorrent plugin for your custom instance""\e[0m"
                                    # Makes the directories we require for the irssi and autodl installation.
                                    mkdir -p ~/{.autodl-"$suffix",.irssi-"$suffix"/scripts/autorun}
                                    echo -e "\033[31m""A randomly generated 20 character password has been set for you by this script""\e[0m"
                                    echo "Downloading autodl-irssi"
                                    # Downloads the newest RELEASE version of the autodl community edition and saves it as a zip file.
                                    wget -qO ~/autodl-irssi.zip "$autodlirssicommunity"
                                    # Downloads the newest  RELEASE version  of the autodl community trackers file and saves it as a zip file.
                                    wget -qO ~/autodl-trackers.zip "$autodltrackers"
                                    # Unpack core autodl files to the desired location for further processing
                                    unzip -qo ~/autodl-irssi.zip -d ~/.irssi-"$suffix"/scripts/
                                    # Unpack the latest trackers file just to make sure we are they are current.
                                    unzip -qo ~/autodl-trackers.zip -d ~/.irssi-"$suffix"/scripts/AutodlIrssi/trackers/
                                    # Moves the files around to their proper homes. The .pl file is moved to autorun so that autodl starts automatically when we open irssi
                                    cp -f ~/.irssi-"$suffix"/scripts/autodl-irssi.pl ~/.irssi-"$suffix"/scripts/autorun/
                                    # Delete files we no longer need.
                                    rm -f ~/autodl-{irssi,trackers}.zip ~/.irssi-"$suffix"/scripts/{README*,CONTRIBUTING.md,autodl-irssi.pl}
                                    echo "Writing configuration files"
                                    echo -e "[options]\ngui-server-port = $appport\ngui-server-password = $autodlpass" > ~/.autodl-"$suffix"/autodl.cfg
                                    #
                                    ############################
                                    ######## Autodl End ########
                                    ############################
                                    #
                                    ############################
                                    ##### RuTorrent Starts #####
                                    ############################
                                    #
                                    # Downloads the latest version of the autodl-irssi plugin
                                    wget -qO ~/autodl-rutorrent.zip "$autodlrutorrent"
                                    # Unpacks the autodl rutorrent plugin here
                                    unzip -qo ~/autodl-rutorrent.zip
                                    # Copy the contents from autodl-rutorrent-master to a folder called autodl-irssi in the rutorrent plug-in directory, creating it if absent
                                    mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins
                                    cp -rf ~/autodl-rutorrent-master/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi
                                    # Delete the downloaded zip and the unpacked folder we no longer require.
                                    cd && rm -rf autodl-rutorrent{-master,.zip}
                                    # Uses echo to make the config file for the rutorrent plugun to work with autodl using the variables port and pass
                                    echo -ne '<?php\n$autodlPort = '"$appport"';\n$autodlPassword = "'"$autodlpass"'";\n?>' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi/conf.php
                                    #
                                    ############################
                                    ###### RuTorrent Ends ######
                                    ############################
                                    ############################
                                    ##### Fix script Start #####
                                    ############################
                                    #
                                    echo "Applying the fix script as part of the installation:"
                                    # Set a custom home dir for autodl to ~/.autodl-$suffix
                                    sed -i 's|return File::Spec->catfile(getHomeDir(), ".autodl");|return File::Spec->catfile(getHomeDir(), ".autodl-'"$suffix"'");|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/Dirs.pm
                                    # Fix the core Autodl files by changing 127.0.0.1 to 10.0.0.1 using sed in 3 places in 2 files.
                                    sed -i "s|use constant LISTEN_ADDRESS => '127.0.0.1';|use constant LISTEN_ADDRESS => '10.0.0.1';|g" ~/.irssi-"$suffix"/scripts/AutodlIrssi/GuiServer.pm
                                    sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/MatchedRelease.pm
                                    sed -i 's|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/MatchedRelease.pm
                                    #
                                    echo -e "\033[33m""Autodl fix has been applied""\e[0m"
                                    # Fix the relevent rutorrent plugin file by changing 127.0.0.1 to 10.0.0.1 using sed
                                    sed -i 's|if (!socket_connect($socket, "127.0.0.1", $autodlPort))|if (!socket_connect($socket, "10.0.0.1", $autodlPort))|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi/getConf.php
                                    echo -e "\033[33m""Autodl-rutorrent fix has been applied""\e[0m"
                                    echo
                                    #
                                    ############################
                                    ###### Fix script End ######
                                    ############################
                                    #
                                    screen -wipe > /dev/null 2>&1
                                    screen -dmS autodl-"$suffix" irssi --home="$HOME"/.irssi-"$suffix"/
                                    echo 'screen -dmS autodl-'"$suffix"' irssi --home=$HOME/.irssi-'"$suffix"'/' >> ~/multirtru.restart.txt
                                    # Send a command to the new screen telling Autodl to update itself. This basically generates the ~/.autodl/AutodlState.xml files with updated info.
                                    screen -S autodl-"$suffix" -p 0 -X stuff '/autodl update^M'
                                    ############################
                                    ############################
                                    ############################
                                else
                                    echo "This instance has been installed without autodl-irssi"
                                    echo
                                fi
                                #
                                # Password protect the setup
                                #
                                echo -e "\033[31m""3:""\e[0m" "Password Protect the Installation"
                                echo
                                #
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    echo -e 'location /rutorrent-'"$suffix"' {\n    auth_basic "rutorrent-'"$suffix"'";\n    auth_basic_user_file '"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/rutorrent-'"$suffix"'/.htpasswd;\n}\n\nlocation /rutorrent-'"$suffix"'/conf { deny all; }\nlocation /rutorrent-'"$suffix"'/share { deny all; }' > ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix".conf
                                    echo -e 'location /rtorrent-'"$suffix"'/rpc {\n    include   /etc/nginx/scgi_params;\n    scgi_pass unix://'"$HOME"'/private/rtorrent-'"$suffix"'/.socket;\n\n    auth_basic '\''rtorrent SCGI for rutorrent-'"$suffix"''\'';\n    auth_basic_user_file conf.d/000-default-server.d/scgi-'"$suffix"'-htpasswd;\n}' > ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix"-rpc.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                                #
                                echo -e 'AuthType Basic\nAuthName "rtorrent-'"$suffix"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/rutorrent-'"$suffix"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/.htaccess
                                chmod 644 ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/.htaccess
                                #
                                while [[ -z "$username" ]]
                                do
                                    read -ep "Please give me a username for the user we are creating: " -i "rutorrent-$suffix" username
                                done
                                #
                                echo
                                echo -e "Generating a random 20 character random password for the user:" "\033[32m""$username""\e[0m"
                                echo
                                #
                                htpasswd -cbm ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/.htpasswd "$username" "$apppass"
                                chmod 644 ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/.htpasswd
                                echo
                                #
                                # nginx copy rutorrent-suffix htpasswd to create the rpc htpasswd file.
                                #
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    cp -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/.htpasswd ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                                    sed -i 's/\(.*\):\(.*\)/rutorrent:\2/g' ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                                fi
                                #
                                # create the screen
                                if [[ -d ~/.autodl-"$suffix" && ~/.irssi-"$suffix" ]]
                                    then
                                    echo -e "\033[32m""Checking we have started irssi or if there are multiple screens/processes""\e[0m"
                                    echo
                                    echo -e "\033[31m"$(screen -ls | grep autodl-"$suffix")"\e[0m"
                                    echo
                                    echo -e "You can attach to the screen using this command: ""\033[32m""screen -r autodl-$suffix""\e[0m"
                                    echo
                                fi
                                echo -e "\033[32m""4:""\e[0m" "Creating the screen process"
                                echo
                                #
                                screen -fa -dmS rtorrent-"$suffix" rtorrent -n -o import=~/.rtorrent-"$suffix".rc
                                #
                                echo -e "\033[32m""This command was added to""\e[0m" "\033[36m""~/multirtru.restart.txt""\e[0m" "\033[32m""so you can easily restart this instance""\e[0m"
                                echo
                                echo -e "To reattach to this screen type: ""\033[33m""screen -r rtorrent-$suffix""\e[0m"
                                echo
                                echo -e "Is it running? ""\033[33m"$(screen -ls | grep rtorrent-"$suffix")"\e[0m"
                                echo
                                echo -e "The username for this instance is:" "\033[32m""$username""\e[0m"
                                echo
                                echo -e "Visit this URL to see your new instance:"
                                echo
                                echo -e "\033[32m""https://$username:$apppass@$(hostname -f)/$(whoami)/rutorrent-$suffix/""\e[0m"
                                echo
                                echo -e "Your password for ""\033[32m""rutorrent-$suffix""\e[0m" "is" "\033[32m""$apppass""\e[0m" "Please make a note of this password now."
                                echo
                                echo -e "If you forget the pass you will have to use the script in this FAQ - https://www.feralhosting.com/faq/view?question=22"
                                echo
                                echo -e "\033[33m""Don't forget, you can manage your passwords with this FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=22""\e[0m"
                                echo
                                sleep 3
                            else
                                echo -e "\033[31m""This suffix is already in use. Please use another.""\e[0m"
                                echo
                            fi
                            sleep 3
                            ;;
                    "2")
                            functiontwo
                            #
                            if [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix" ]]
                            then
                                echo -e "Updating ruTorrent"
                                echo
                                # Copy the Feral rutorrent template
                                wget -qO ~/rutorrentgit.zip $rutorrentgit
                                unzip -qo ~/rutorrentgit.zip
                                cp -rf ~/ruTorrent-master/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"
                                sed -i 's|/private/rtorrent/.socket|/private/rtorrent-'"$suffix"'/.socket|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/conf/config.php
                                rm -rf ~/www/konichiwa.asteria.feralhosting.com/public_html/rutorrent-12345/plugins/
                                cd && rm -rf ruTorrent-master rutorrentgit.zip
                                # cp -rf /opt/rutorrent/current/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"
                                #
                                # Make sure rtorrent adder will work with nginx by creating this folder.
                                mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/share/torrents
                                # Download and install the Feral stats plugin
                                wget -qO ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip "$feralstats"
                                unzip -qo ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/
                                rm -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip
                                # Download and install the ratio colour plugin
                                wget -qO ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip "$ratiocolor"
                                unzip -qo ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/
                                rm -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip
                                #
                                rm -rf ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/{diskspace,cpuload}
                                #
                                echo -e "Editing the files: rutorrent"
                                echo
                                sed -i 's|/private/rtorrent/.socket|/private/rtorrent-'"$suffix"'/.socket|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/conf/config.php
                                #
                                if [[ $(grep -c '^screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~/.rtorrent-'"$suffix"'.rc$' ~/multirtru.restart.txt) -eq "0" ]]
                                then
                                    echo 'screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~/.rtorrent-'"$suffix"'.rc' >> ~/multirtru.restart.txt
                                fi
                                ############################
                                ############################
                                ############################
                            else 
                                echo -e "\033[31m""No matching rutorrent instances exist. Try again.""\e[0m"
                                echo
                            fi
                            #
                            if [[ -d ~/.autodl-"$suffix" && -d ~/.irssi-"$suffix" ]]
                            then
                                ############################
                                ####### Autodl Start #######
                                ############################
                                #
                                echo -e "Updating autodl-$suffix"
                                echo
                                kill -9 $(screen -ls autodl | sed -rn 's/(.*).autodl-(.*)/\1/p')  > /dev/null 2>&1
                                # Makes the directories we require for the irssi and autodl update.
                                mkdir -p ~/{.autodl-"$suffix",.irssi-"$suffix"/scripts/autorun}
                                # Downloads the newest RELEASE version of the autodl community edition and saves it as a zip file.
                                wget -qO ~/autodl-irssi.zip "$autodlirssicommunity"
                                # Downloads the newest  RELEASE version  of the autodl community trackers file and saves it as a zip file.
                                wget -qO ~/autodl-trackers.zip "$autodltrackers"
                                # Unpack core autodl files to the desired location for further processing
                                unzip -qo ~/autodl-irssi.zip -d ~/.irssi-"$suffix"/scripts/
                                # Unpack the latest trackers file just to make sure we are they are current.
                                unzip -qo ~/autodl-trackers.zip -d ~/.irssi-"$suffix"/scripts/AutodlIrssi/trackers/
                                # Moves the files around to their proper homes. The .pl file is moved to autorun so that autodl starts automatically when we open irssi
                                cp -f ~/.irssi-"$suffix"/scripts/autodl-irssi.pl ~/.irssi-"$suffix"/scripts/autorun/
                                # Delete files we no longer need.
                                rm -f ~/autodl-{irssi,trackers}.zip ~/.irssi-"$suffix"/scripts/{README*,CONTRIBUTING.md,autodl-irssi.pl}
                                echo -e "[options]\ngui-server-port = $appport\ngui-server-password = $autodlpass" > ~/.autodl-"$suffix"/autodl.cfg
                                #
                                ############################
                                ######## Autodl End ########
                                ############################
                                #
                                ############################
                                ##### RuTorrent Starts #####
                                ############################
                                #
                                # Downloads the latest version of the autodl-irssi plugin
                                wget -qO ~/autodl-rutorrent.zip "$autodlrutorrent"
                                # Unpacks the autodl rutorrent plugin here
                                unzip -qo ~/autodl-rutorrent.zip
                                # Copy the contents from autodl-rutorrent-master to a folder called autodl-irssi in the rutorrent plug-in directory, creating it if absent
                                mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins
                                cp -rf ~/autodl-rutorrent-master/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi
                                # Delete the downloaded zip and the unpacked folder we no longer require.
                                cd && rm -rf autodl-rutorrent{-master,.zip}
                                # Uses echo to make the config file for the rutorrent plugun to work with autodl using the variables port and pass
                                echo -ne '<?php\n$autodlPort = '"$appport"';\n$autodlPassword = "'"$autodlpass"'";\n?>' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi/conf.php
                                if [[ $(grep -c '^screen -dmS autodl-'"$suffix"' irssi --home=$HOME/.irssi-'"$suffix"'/$' ~/multirtru.restart.txt) -eq "0" ]]
                                then
                                    echo 'screen -dmS autodl-'"$suffix"' irssi --home=$HOME/.irssi-'"$suffix"'/' >> ~/multirtru.restart.txt
                                fi
                                #
                                ############################
                                ###### RuTorrent Ends ######
                                ############################
                                #
                                ############################
                                ##### Fix script Start #####
                                ############################
                                #
                                echo "Applying the fix script as part of the update:"
                                # Set a custom home dir for autodl to ~/.autodl-$suffix
                                sed -i 's|return File::Spec->catfile(getHomeDir(), ".autodl");|return File::Spec->catfile(getHomeDir(), ".autodl-'"$suffix"'");|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/Dirs.pm
                                # Fix the core Autodl files by changing 127.0.0.1 to 10.0.0.1 using sed in 3 places in 2 files.
                                sed -i "s|use constant LISTEN_ADDRESS => '127.0.0.1';|use constant LISTEN_ADDRESS => '10.0.0.1';|g" ~/.irssi-"$suffix"/scripts/AutodlIrssi/GuiServer.pm
                                sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/MatchedRelease.pm
                                sed -i 's|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});|g' ~/.irssi-"$suffix"/scripts/AutodlIrssi/MatchedRelease.pm
                                #
                                echo -e "\033[33m""Autodl fix has been applied""\e[0m"
                                # Fix the relevent rutorrent plugin file by changing 127.0.0.1 to 10.0.0.1 using sed
                                sed -i 's|if (!socket_connect($socket, "127.0.0.1", $autodlPort))|if (!socket_connect($socket, "10.0.0.1", $autodlPort))|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"/plugins/autodl-irssi/getConf.php
                                echo -e "\033[33m""Autodl-rutorrent fix has been applied""\e[0m"
                                echo
                                #
                                ############################
                                ###### Fix script End ######
                                ############################
                                #
                                # restart autodl.
                                screen -wipe > /dev/null 2>&1
                                screen -dmS autodl-"$suffix" irssi --home="$HOME"/.irssi-"$suffix"/
                                # Send a command to the new screen telling Autodl to update itself. This basically generates the ~/.autodl/AutodlState.xml files with updated info.
                                screen -S autodl-"$suffix" -p 0 -X stuff '/autodl update^M'
                                #
                                ############################
                                ############################
                                ############################
                                echo -e "rutorrent-$suffix and autodl-$suffix have been updated."
                                echo
                                sleep 3
                            else 
                                echo -e "\033[31m""No matching autodl instances exist. Try again.""\e[0m"
                                echo
                                sleep 3
                            fi
                            ;;
                    "3")
                            functiontwo
                            #
                            kill -9 $(screen -ls rtorrent | sed -rn 's/(.*).rtorrent-(.*)/\1/p')  > /dev/null 2>&1
                            kill -9 $(screen -ls autodl | sed -rn 's/(.*).autodl-(.*)/\1/p')  > /dev/null 2>&1
                            screen -wipe > /dev/null 2>&1
                            #
                            echo -e "\033[32m""Custom instance has been shutdown: if it was running""\e[0m"
                            echo
                            if [[ -f ~/.rtorrent-"$suffix".rc ]]
                            then
                                rm -f ~/.rtorrent-"$suffix".rc
                                echo "~/.rtorrent-$suffix.rc has been removed"
                                echo
                            else
                                echo "~/.rtorrent-$suffix.rc file not found, skipping"
                                echo
                            fi
                            #
                            if [[ -d ~/private/rtorrent-"$suffix" ]]
                            then
                                rm -rf ~/private/rtorrent-"$suffix"
                                echo "~/private/rtorrent-$suffix has been removed"
                                echo
                            else
                                echo "~/private/rtorrent-$suffix not found, skipping"
                                echo
                            fi
                            #
                            if [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix" ]]
                            then
                                rm -rf ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-"$suffix"
                                echo "~/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix has been removed"
                                echo
                            else
                                echo "~/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix not found, skipping"
                                echo
                            fi
                            if [[ -d ~/.irssi-"$suffix" ]]
                            then
                                rm -rf ~/.irssi-"$suffix"
                                echo "~/.irssi-$suffix has been removed"
                                echo
                            else
                                echo "~/.irssi-$suffix not found, skipping"
                                echo
                            fi
                            if [[ -d ~/.autodl-"$suffix" ]]
                            then
                                rm -rf ~/.autodl-"$suffix"
                                echo "~/.autodl-$suffix has been removed"
                                echo
                            else
                                echo "~/.autodl-$suffix not found, skipping"
                                echo
                            fi
                            #
                            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                            then
                                rm -f ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                                rm -f ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix".conf
                                rm -f ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix"-rpc.conf
                                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                echo "Nginx related files have been removed and nginx has been reloaded"
                                echo
                            fi
                            if [[ -f ~/multirtru.restart.txt ]]
                            then
                                sed -i '/screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~\/.rtorrent-'"$suffix"'.rc/d' ~/multirtru.restart.txt
                                sed -i '/screen -dmS autodl-'"$suffix"' irssi --home=$HOME\/.irssi-'"$suffix"'\//d' ~/multirtru.restart.txt
                                sed -i '/^$/d' ~/multirtru.restart.txt
                            fi
                            echo -e "\033[31m""Done""\e[0m"
                            echo
                            sleep 3
                            ;;
                    "4")
                            functiontwo
                            #
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
                                echo -e "\033[31m""Install autodl using option 1"
                                echo
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
                                exit
                            fi
                            kill -9 $(screen -ls autodl | sed -rn 's/(.*).autodl-(.*)/\1/p')  > /dev/null 2>&1
                            screen -wipe > /dev/null 2>&1
                            screen -dmS autodl-"$suffix" irssi --home="$HOME"/.irssi-"$suffix"/
                            echo -e "\033[33m""Checking we restarted irssi or if there are multiple screens/processes""\e[0m"
                            echo
                            echo $(screen -ls | grep autodl-"$suffix")
                            echo
                            echo -e "Done. Please refresh/reload rutorrent using CTRL + F5"
                            echo
                            echo -e "This fix might have to be run each time you update/overwrite the autodl or autodl-rutorrent files."
                            echo
                            sleep 3
                            ;;
                    "5")
                            echo "You chose to quit the script."
                            echo
                            exit
                            ;;
            esac
    done
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit
fi
#
############################
##### Core Script Ends #####
############################
#