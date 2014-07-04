#!/bin/bash
# install autodl
scriptversion="1.3.5"
scriptname="install.autodl"
# Bobtentpeg, randomessence
#
# wget -qO ~/install.autodl.sh http://git.io/oTUCMg && bash ~/install.autodl.sh
#
############################
## Version History Starts ##
############################
#
# v1.3.5 - does not force rutorrent and will install and configure autodl without it.
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
# v1.0.1 - Finish rutorrent check mechanism -- checks for rutorrent folder in vhost
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
# Bitbucket URLs for the core files.
autodlirssicommunity="http://update.autodl-community.com/autodl-irssi-community.zip"
autodltrackers="http://update.autodl-community.com/autodl-trackers.zip"
# URL for autodl-rutorrent
autodlrutorrent="https://github.com/autodl-community/autodl-rutorrent/archive/master.zip"
# Uses shuf to pick a random port between 6000 and 50000
port=$(shuf -i 6000-50000 -n 1)
# Random password generation
pass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
# Raw script URL for self updating
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/install.autodl.sh"
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" >/dev/null 2>&1
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" >/dev/null 2>&1
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
cd && rm -f {000,111,222}"$scriptname.sh" installautodl.sh bin/installautodl
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
# Please note, the sleep lines are there to artificially slow down the process at some steps and to allow ample time to give user feedback
# Echoes are not commented since they are informative notices that are self explanatory
#
    #
    ############################
    ####### Autodl Start #######
    ############################
    #
    echo -e "\033[32m""Installing autodl-irssi and the rutorrent plugin""\e[0m"
    echo
    # Makes the directories we require for the irssi and autodl installation.
    mkdir -p ~/{.autodl,.irssi/scripts/autorun}
    echo -e "\033[31m""A randomly generated 20 character password has been set for you by this script""\e[0m"
    echo
    # Kill any existing irssi processes to make sure the installation can be finalised later.
    killall -9 -u $(whoami) irssi >/dev/null 2>&1
    # Wipe any dead screens left behind
    screen -wipe >/dev/null 2>&1
    # Make a backup of the ~/.autodl/autodl.cfg just in case
    if [[ -f ~/.autodl/autodl.cfg ]]
    then
        cp -f ~/.autodl/autodl.cfg ~/.autodl/autodl.cfg.bak-$(date +"%m.%d.%y@%H:%M:%S")
    fi
    # Clean install by removing the related irssi folder and files and the rutorrent plug in folder
    rm -rf ~/.irssi/scripts/AutodlIrssi
    rm -f ~/.irssi/scripts/autorun/autodl-irssi.pl
    rm -rf ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi
    echo "Downloading autodl-irssi"
    echo
    sleep 1
    # Downloads the newest RELEASE version of the autodl community edition and saves it as a zip file.
    wget -qO ~/autodl-irssi.zip "$autodlirssicommunity"
    # Downloads the newest  RELEASE version  of the autodl community trackers file and saves it as a zip file.
    wget -qO ~/autodl-trackers.zip "$autodltrackers"
    echo "autodl-irssi download finished"
    echo
    sleep 1
    echo "Unzipping files"
    echo
    sleep 1
    # Unpack core autodl files to the desired location for further processing
    unzip -qo ~/autodl-irssi.zip -d ~/.irssi/scripts/
    # Unpack the latest trackers file just to make sure we are they are current.
    unzip -qo ~/autodl-trackers.zip -d ~/.irssi/scripts/AutodlIrssi/trackers/
    echo "Moving files around"
    echo
    sleep 1
    # Moves the files around to their proper homes. The .pl file is moved to autorun so that autodl starts automatically when we open irssi
    cp -f ~/.irssi/scripts/autodl-irssi.pl ~/.irssi/scripts/autorun/
    # Delete files we no longer need.
    rm -f ~/autodl-{irssi,trackers}.zip ~/.irssi/scripts/{README*,CONTRIBUTING.md,autodl-irssi.pl}
    echo "Writing configuration files"
    # If the autodl.cfg exists we use sed to update the existing username and pass with the ones the script has generated.
    # else we use and echo to create our autodl.cfg file. Takes the two previously made variables, $port and $pass to update/create the required info.
    if [[ -f ~/.autodl/autodl.cfg ]]
    then
        # Sed command to enter the port variable
        sed -ri 's|(.*)gui-server-port =(.*)|gui-server-port = '"$port"'|g' ~/.autodl/autodl.cfg
        # Sed command to enter the password variable
        sed -ri 's|(.*)gui-server-password =(.*)|gui-server-password = '"$pass"'|g' ~/.autodl/autodl.cfg
    else 
        echo -e "[options]\ngui-server-port = $port\ngui-server-password = $pass" > ~/.autodl/autodl.cfg
    fi
    echo
    sleep 1
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
        echo "Downloading autodl-irssi Rutorrent plugin"
        echo
        sleep 1
        # Downloads the latest version of the autodl-irssi plugin
        wget -qO ~/autodl-rutorrent.zip "$autodlrutorrent"
        echo "Plugin download finished"
        echo
        sleep 1
        # Unpacks the autodl rutorrent plugin here
        unzip -qo ~/autodl-rutorrent.zip
        # Copy the contents from autodl-rutorrent-master to a folder called autodl-irssi in the rutorrent plug-in directory, creating it if absent
        mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins
        cp -rf ~/autodl-rutorrent-master/. ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi
        # Delete the downloaded zip and the unpacked folder we no longer require.
        cd && rm -rf autodl-rutorrent{-master,.zip}
        echo "Creating configuration file"
        echo
        sleep 1
        # Uses echo to make the config file for the rutorrent plugun to work with autodl using the variables port and pass
        echo -ne '<?php\n$autodlPort = '"$port"';\n$autodlPassword = "'"$pass"'";\n?>' > ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi/conf.php
        sleep 1
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
    echo "Applying the fix script as part of the installation:"
    echo
    sleep 1
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
        exit 1
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
    # Kill all irssi instances before starting
    killall -9 -u $(whoami) irssi >/dev/null 2>&1
    # Clear dead screens
    screen -wipe >/dev/null 2>&1
    # Start autodl irssi in a screen in the background.
    screen -dmS autodl irssi
    # Send a command to the new screen telling Autodl to update itself. This basically generates the ~/.autodl/AutodlState.xml files with updated info.
	screen -S autodl -p 0 -X stuff '/autodl update^M'
    echo -e "\033[32m""Checking we have started irssi or if there are multiple screens/processes""\e[0m"
    echo -e "\033[31m"
    # Check if the screen is running for the user
    screen -ls | grep autodl
    echo -e "\e[0m"
    echo -e "Done. Please refresh/reload rutorrent using CTRL + F5 and start using autodl"
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
    exit 1
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