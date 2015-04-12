#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: Bobtentpeg
#
# Script Contributors: randomessence
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/install.autodl http://git.io/oTUCMg && bash ~/install.autodl qr
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
# v1.4.5 - Template
# v1.4.4 - Template
# v1.4.3 - Template
# v1.4.2 - Template
# v1.4.1 - Visual tweaks.
# v1.4.0 - better isolating of screen PIDS
# v1.3.9 - test for existing but empty autodl.cfg
# v1.3.8 - template
# v1.3.6 - $(hostname -f) *points fingers*
# v1.3.5 - does not force ruTorrent and will install and configure autodl without it.
# v1.3.4 - update URLs changed to http://update.autodl-community.com
# v1.3.3 - small tweaks
# v1.3.2 - confusion = automation + comments
# v1.3.1 - updater template merged
# v1.3.0 - URLs updated as google code is being phased out.
# v1.2.9 - modernised
# v1.2.8 - removes autodl files before installing. Clean install. No longer overwrites existing autodl.cfg if present when reinstalling
# v1.2.7 - also gets and installs most current tracker list
# v1.2.6 - random pass generated and inserted but still requires user confirmation.
# v1.2.5 - general tidy up and less verbose output
# v1.2.4 - merged fix script
# v1.2.3 - Added disclaimer
# v1.2.2 - Fixed mv steps, dir struct did in fact change by using the release builds
# v1.2.1 - Code cleanup (cleaner var names, better structure)...more commenting
# v1.2 - Updated plugin to community edition, freeleech flag and a few other extras
# v1.1 - Set the password prompt to tell you not to use spaces, fixed a typo and made sure to set svn to --quiet. Groundwork for version checking
# v1.0.1 - Finish ruTorrent check mechanism -- checks for ruTorrent folder in vhost
# v1.0 - Initial release
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
scriptversion="1.4.5"
#
# Script name goes here. Please prefix with install.
scriptname="install.autodl"
#
# Author name goes here.
scriptauthor="Bobtentpeg"
#
# Contributor's names go here.
contributors="randomessence"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/oTUCMg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# URLs for the core files.
autodlirssicommunity="http://update.autodl-community.com/autodl-irssi-community.zip"
autodltrackers="http://update.autodl-community.com/autodl-trackers.zip"
# URL for autodl-rutorrent
autodlrutorrent="https://github.com/autodl-community/autodl-rutorrent/archive/master.zip"
#
# Uses shuf to pick a random port between 10001 and 49999
port=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$port"'' | grep -c 'LISTEN')" -eq "1" ]]
do
    port=$(shuf -i 10001-49999 -n 1)
done
#
# Random password generation
pass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/install.autodl.sh"
#
if [[ -d ~/.autodl ]]
then
    shoutout1="Updating"
    shoutout2="update" 
else
    shoutout1="Installing"
    shoutout2="installation"
fi
#
# Disables the built in script updater permanently by setting this variable to 0.
updaterenabled="1"
#
############################
####### Variable End #######
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
    echo "Script Author: $scriptauthor"
    echo
    echo "Script Contributors: $contributors"
    echo
    #
    ################# Custom Script Notes #################
    echo -e "\033[32m""Script Notes - this script will do these things:""\e[0m"
    echo
    echo "Put your instructions or script information here"
    echo
    #######################################################
    #
    echo -e "\033[32m""Script options:""\e[0m"
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
    echo -e "$gitiocommand"
    echo
    echo -e "~/bin/$scriptname"
    echo
    echo -e "$scriptname"
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
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion=""$scriptversion"-nu"
else
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
        scriptversion=""$scriptversion"-DEV"
    fi
fi
#
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
    screen -wipe >/dev/null 2>&1
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
    # else we use and echo to create our autodl.cfg file. Takes the two previously made variables, $port and $pass to update/create the required info.
    if [[ -f ~/.autodl/autodl.cfg ]]
    then
        if [[ $(tr -d "\r\n" < ~/.autodl/autodl.cfg | wc -c) -eq 0 ]]
        then
            echo -e "[options]\ngui-server-port = $port\ngui-server-password = $pass" > ~/.autodl/autodl.cfg
        else
            # Sed command to enter the port variable
            sed -ri 's|(.*)gui-server-port =(.*)|gui-server-port = '"$port"'|g' ~/.autodl/autodl.cfg
            # Sed command to enter the password variable
            sed -ri 's|(.*)gui-server-password =(.*)|gui-server-password = '"$pass"'|g' ~/.autodl/autodl.cfg
        fi
    else 
        echo -e "[options]\ngui-server-port = $port\ngui-server-password = $pass" > ~/.autodl/autodl.cfg
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
        echo -ne '<?php\n$autodlPort = '"$port"';\n$autodlPassword = "'"$pass"'";\n?>' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/conf.php
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
    screen -wipe >/dev/null 2>&1
    # Start autodl irssi in a screen in the background.
    screen -dmS autodl irssi
    # Send a command to the new screen telling Autodl to update itself. This basically generates the ~/.autodl/AutodlState.xml files with updated info.
    screen -S autodl -p 0 -X stuff '/autodl update^M'
    echo -e "\033[32m""Checking we have started irssi or if there are multiple screens/processes""\e[0m"
    echo -e "\033[31m"
    # Check if the screen is running for the user
    echo $(screen -ls | grep autodl)
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