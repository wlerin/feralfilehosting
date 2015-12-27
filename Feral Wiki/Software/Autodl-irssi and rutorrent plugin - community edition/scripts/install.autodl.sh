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
# Bash Command for easy reference:
#
# wget -qO ~/install.autodl http://git.io/oTUCMg && bash ~/install.autodl
#
# The MIT License (MIT)
#
# Copyright (c) 2016 randomessence
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
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
if [[ ! -z "$1" && "$1" = 'changelog' ]]
then
    echo
    #
    echo 'v1.4.9 - licensing MIT'
    echo 'v1.4.8 - Download URLs are now generated from the Github Latest URI to get the current releases from github directly.'
    echo 'v1.4.7 - Template and minor tweaks.'
    echo 'v1.4.6 - Template and minor tweaks.'
    echo 'v1.4.5 - Template.'
    echo 'v1.4.4 - Template.'
    echo 'v1.4.3 - Template.'
    echo 'v1.4.2 - Template.'
    echo 'v1.4.1 - Visual tweaks.'
    echo 'v1.4.0 - better isolating of screen PIDS.'
    echo 'v1.3.9 - test for existing but empty autodl.cfg.'
    echo 'v1.3.8 - template.'
    echo 'v1.3.6 - $(hostname -f) *points fingers*.'
    echo 'v1.3.5 - does not force ruTorrent and will install and configure autodl without it.'
    echo 'v1.3.4 - update URLs changed to http://update.autodl-community.com.'
    echo 'v1.3.3 - small tweaks.'
    echo 'v1.3.2 - confusion = automation + comments.'
    echo 'v1.3.1 - updater template merged.'
    echo 'v1.3.0 - URLs updated as google code is being phased out.'
    echo 'v1.2.9 - modernised.'
    echo 'v1.2.8 - removes autodl files before installing. Clean install. No longer overwrites existing autodl.cfg if present when reinstalling.'
    echo 'v1.2.7 - also gets and installs most current tracker list.'
    echo 'v1.2.6 - random pass generated and inserted but still requires user confirmation.'
    echo 'v1.2.5 - general tidy up and less verbose output.'
    echo 'v1.2.4 - merged fix script.'
    echo 'v1.2.3 - Added disclaimer.'
    echo 'v1.2.2 - Fixed mv steps, dir struct did in fact change by using the release builds.'
    echo 'v1.2.1 - Code cleanup (cleaner var names, better structure)...more commenting.'
    echo 'v1.2 - Updated plugin to community edition, freeleech flag and a few other extras.'
    echo 'v1.1 - Set the password prompt to tell you not to use spaces, fixed a typo and made sure to set svn to --quiet. Groundwork for version checking.'
    echo 'v1.0.1 - Finish ruTorrent check mechanism -- checks for ruTorrent folder in vhost.'
    echo 'v1.0 - Initial release.'
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
scriptversion="1.4.9"
#
# Script name goes here. Please prefix with install.
scriptname="install.autodl"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
scriptauthor="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/oTUCMg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/install.autodl.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass="$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)"
# This will generate a random port for the script between the range 10001 to 32001 to use with applications. You can ignore this unless needed.
appport="$(shuf -i 10001-32001 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport="$(shuf -i 10001-32001 -n 1)"; done
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
[[ -d ~/www/"$(whoami)"."$(hostname -f)"/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
# Bug reporting varaibles.
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
autodllatest="$(curl -s https://api.github.com/repos/autodl-community/autodl-irssi/releases/latest | sed -rn 's/(.*)"tag_name": "community-v(.*)",/\2/p')"
trackerslatest="$(curl -s https://api.github.com/repos/autodl-community/autodl-trackers/releases/latest | sed -rn 's/(.*)"tag_name": "community-v(.*)",/\2/p')"
#
# URLs for the core files.
# autodlirssicommunity="http://update.autodl-community.com/autodl-irssi-community.zip"
#
autodlirssicommunity="https://github.com/autodl-community/autodl-irssi/releases/download/community-v$autodllatest/autodl-irssi-community-v$autodllatest.zip"
autodltrackers="https://github.com/autodl-community/autodl-trackers/releases/download/community-v$trackerslatest/autodl-trackers-v$trackerslatest.zip"
# URL for autodl-rutorrent
autodlrutorrent="https://github.com/autodl-community/autodl-rutorrent/archive/master.zip"
#
# This is a test to decide the output of an echoed variable depending of the presence of the ~/.autodl folder
if [[ -d ~/.autodl ]]
then
    shoutout1="Updating"
    shoutout2="update" 
else
    shoutout1="Installing"
    shoutout2="installation"
fi
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
example () {
    echo "This is my example function"
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
if [[ ! -z "$1" && "$1" = 'help' ]]
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
if [[ ! -z "$1" && "$1" = 'info' ]]
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
    echo -e "You can create an issue directly on github using your github account."
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
if [[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z "$1" && "$1" = 'nu' ]] || [[ ! -z "$2" && "$2" = 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq "1" ]]
    then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        #
        wget -qO ~/.000"$scriptname" "$scripturl"
        #
        if [[ "$(sha256sum ~/.000"$scriptname" | awk '{print $1}')" != "$(sha256sum ~/bin/"$scriptname" | awk '{print $1}')" ]]
        then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
            bash ~/.111"$scriptname"
            exit
        else
            if [[ -z "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" && "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" -ne "$$" ]]
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
if [[ "$updatestatus" = "y" ]]
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
    #
    ############################
    ####### Autodl Start #######
    ############################
    #
    echo -e "\033[32m""$shoutout1 autodl-irssi and the rutorrent plugin""\e[0m"
    echo
    # Makes the directories we require for the irssi and autodl installation.
    mkdir -p ~/{.autodl,.irssi/scripts/autorun}
    echo -e "\033[31m""A randomly generated 20 character password has been set for you by this script""\e[0m"
    echo
    # Kill any existing autodl screen processes to make sure the installation can be finalised later.
    kill $(screen -ls autodl | sed -rn 's/(.*).autodl(.*)/\1/p') > /dev/null 2>&1
    # Wipe any dead screens left behind
    screen -wipe > /dev/null 2>&1
    # Make a backup of the ~/.autodl/autodl.cfg just in case
    if [[ -f ~/.autodl/autodl.cfg ]]
    then
        cp -f ~/.autodl/autodl.cfg ~/.autodl/autodl.cfg.bak-$(date +"%d.%m.%y@%H:%M:%S")
    fi
    # Clean install by removing the related irssi folder and files and the rutorrent plug in folder
    rm -rf ~/.irssi/scripts/AutodlIrssi
    rm -f ~/.irssi/scripts/autorun/autodl-irssi.pl
    rm -rf ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi
    # Downloads the newest RELEASE version of the autodl community edition and saves it as a zip file.
    wget -qO ~/autodl-irssi.zip "$autodlirssicommunity"
    # Downloads the newest  RELEASE version  of the autodl community trackers file and saves it as a zip file.
    wget -qO ~/autodl-trackers.zip "$autodltrackers"
    # Unpack core autodl files to the desired location for further processing
    unzip -qo ~/autodl-irssi.zip -d ~/.irssi/scripts/
    # Unpack the latest trackers file just to make sure we are they are current.
    unzip -qo ~/autodl-trackers.zip -d ~/.irssi/scripts/AutodlIrssi/trackers/
    # Moves the files around to their proper homes. The .pl file is moved to autorun so that autodl starts automatically when we open irssi
    cp -f ~/.irssi/scripts/autodl-irssi.pl ~/.irssi/scripts/autorun/
    # Delete files we no longer need.
    rm -f ~/autodl-{irssi,trackers}.zip ~/.irssi/scripts/{README*,CONTRIBUTING.md,autodl-irssi.pl}
    # If the autodl.cfg exists we use sed to update the existing username and pass with the ones the script has generated.
    # else we use and echo to create our autodl.cfg file. Takes the two previously made variables, $appport and $apppass to update/create the required info.
    if [[ -f ~/.autodl/autodl.cfg ]]
    then
        if [[ $(tr -d "\r\n" < ~/.autodl/autodl.cfg | wc -c) -eq 0 ]]
        then
            echo -e "[options]\ngui-server-port = $appport\ngui-server-password = $apppass" > ~/.autodl/autodl.cfg
        else
            # Sed command to enter the port variable
            sed -ri 's|(.*)gui-server-port =(.*)|gui-server-port = '"$appport"'|g' ~/.autodl/autodl.cfg
            # Sed command to enter the password variable
            sed -ri 's|(.*)gui-server-password =(.*)|gui-server-password = '"$apppass"'|g' ~/.autodl/autodl.cfg
        fi
    else 
        echo -e "[options]\ngui-server-port = $appport\ngui-server-password = $apppass" > ~/.autodl/autodl.cfg
    fi
    #
    ############################
    ######## Autodl End ########
    ############################
    #
    ############################
    ##### RuTorrent Starts #####
    ############################
    #
    # Checks for rutorrent. If the folder does not exist in the required location the script moves to the else statement.
    if [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent ]]
    then
        # Downloads the latest version of the autodl-irssi plugin
        wget -qO ~/autodl-rutorrent.zip "$autodlrutorrent"
        # Unpacks the autodl rutorrent plugin here
        unzip -qo ~/autodl-rutorrent.zip
        # Copy the contents from autodl-rutorrent-master to a folder called autodl-irssi in the rutorrent plug-in directory, creating it if absent
        mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins
        cp -rf ~/autodl-rutorrent-master/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi
        # Delete the downloaded zip and the unpacked folder we no longer require.
        cd && rm -rf autodl-rutorrent{-master,.zip}
        # Uses echo to make the config file for the rutorrent plugun to work with autodl using the variables port and pass
        echo -ne '<?php\n$autodlPort = '"$appport"';\n$autodlPassword = "'"$apppass"'";\n?>' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/conf.php
        #
        ############################
        ###### RuTorrent Ends ######
        ############################
        #
    else
        # If the ~/www/$(whoami).$(hostname -f)/public_html/rutorrent does not exist say this.
        echo -e "\033[31m""If you wish to use the rutorrent plug-in then please install rutorrent and then run this script again""\e[0m"
        echo
    fi
    #
    ############################
    ##### Fix script Start #####
    ############################
    #
    echo "Applying the fix script as part of the $shoutout2:"
    echo
    # If the ~/.irssi/scripts/AutodlIrssi folder exists then apply the fix or else warn the user the directory is missing.
    if [[ -d ~/.irssi/scripts/AutodlIrssi ]]
    then
        # Fix the core Autodl files by changing 127.0.0.1 to 10.0.0.1 using sed in 3 places in 2 files.
        sed -i "s|use constant LISTEN_ADDRESS => '127.0.0.1';|use constant LISTEN_ADDRESS => '10.0.0.1';|g" ~/.irssi/scripts/AutodlIrssi/GuiServer.pm
        sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' ~/.irssi/scripts/AutodlIrssi/MatchedRelease.pm
        sed -i 's|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});|my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});|g' ~/.irssi/scripts/AutodlIrssi/MatchedRelease.pm
        #
        echo -e "\033[33m""Autodl fix has been applied""\e[0m"
        echo
    else
        echo -e "\033[36m""~/.irssi/scripts/AutodlIrssi/""\e[0m" "does not exist"
        echo -e "\033[36m""Install autodl using the bash script installer in the FAQ"
        echo
        exit
    fi
    #
    # If the ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/ apply the fix else warn the user the directory is missing.
    if [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/ ]]
    then
        # Fix the relevent rutorrent plugin file by changing 127.0.0.1 to 10.0.0.1 using sed
        sed -i 's|if (!socket_connect($socket, "127.0.0.1", $autodlPort))|if (!socket_connect($socket, "10.0.0.1", $autodlPort))|g' ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/getConf.php
        echo -e "\033[33m""Autodl-rutorrent fix has been applied""\e[0m"
        echo
    else
        echo -e "\033[36m""~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/""\e[0m" "does not exist. Skipped."
        echo
    fi
    #
    ############################
    ###### Fix script End ######
    ############################
    #
    # Kill any existing autodl screen processes before starting
    kill $(screen -ls autodl | sed -rn 's/(.*).autodl(.*)/\1/p') > /dev/null 2>&1
    # Clear dead screens
    screen -wipe > /dev/null 2>&1
    # Start autodl irssi in a screen in the background.
    screen -dmS autodl irssi
    # Send a command to the new screen telling Autodl to update itself. This basically generates the ~/.autodl/AutodlState.xml files with updated info.
    screen -S autodl -p 0 -X stuff '/autodl update^M'
    echo -e "\033[32m""Checking we have started irssi or if there are multiple screens/processes""\e[0m"
    echo -e "\033[31m"
    # Check if the screen is running for the user
    echo $(screen -ls | grep 'autodl\s')
    echo -e "\e[0m"
    echo -e "Done. Please refresh/reload rutorrent using CTRL + F5 and start using autodl"
    echo
    echo -e "You can attach to the screen using this command:"
    echo
    echo -e "\033[32m""screen -r autodl""\e[0m"
    echo
    if [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/ ]]
    then
        echo -e "This script will have to be run each time you update/overwrite the autodl or autodl-rutorrent files to apply the fix."
        echo
        echo "Visit your updated rutorrent installation here:"
        echo
        echo -e "\033[32m""https://$(hostname -f)/$(whoami)/rutorrent/""\e[0m"
        echo
    else
        echo -e "\033[31m""This script will have to be run each time you update/overwrite the autodl files to apply the fix.""\e[0m"
        echo
    fi
    exit
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