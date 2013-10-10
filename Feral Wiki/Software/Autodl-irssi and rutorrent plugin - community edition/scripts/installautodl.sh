#!/bin/bash
# installautodl.sh
scriptversion="1.2.8"
scriptname="installautodl"
# Bobtentpeg, randomessence
#
# wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh
#
# Install and configure Autodl-irssi and its rutorrent plugin
# FeralHosting  || www.feralhosting.com
# Feral Hosting is a small team of individuals working towards managed solutions for a variety of problems focusing on minimal systems that can do more.
#
############################
## Version History Starts ##
############################
#
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
#
############################
###### Variable Start ######
############################
#
# Uses shuf to pick a random port between 6000 and 50000
port=$(shuf -i 6000-50000 -n 1)
# sets of two new variables to make things easier in the echo
autodlPort='$autodlPort'
autodlPassword='$autodlPassword'
pass=$(< /dev/urandom tr -dc '12345!@#ANCDEFGHIJKLMNOPabcdefghijklmnop' | head -c${1:-20};echo;)
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
if [ ! -f $HOME/installautodl.sh ]
then
    wget -qO $HOME/installautodl.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
fi
if [ ! -f $HOME/bin/installautodl ]
then
    wget -qO $HOME/bin/installautodl https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
fi
#
wget -qO $HOME/000installautodl.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
#
if ! diff -q $HOME/000installautodl.sh $HOME/installautodl.sh > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/installautodl.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
    wget -qO $HOME/bin/installautodl https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
    bash $HOME/installautodl.sh
    exit 1' > $HOME/111installautodl.sh
    bash $HOME/111installautodl.sh
    exit 1
fi
if ! diff -q $HOME/000installautodl.sh $HOME/bin/installautodl > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/installautodl.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
    wget -qO $HOME/bin/installautodl https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/scripts/installautodl.sh
    bash $HOME/installautodl.sh
    exit 1' > $HOME/222installautodl.sh
    bash $HOME/222installautodl.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000installautodl.sh $HOME/111installautodl.sh $HOME/222installautodl.sh
chmod -f 700 $HOME/bin/installautodl
#
############################
##### Self Updater End #####
############################
#
read -ep "The script has been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ $updatestatus =~ ^[Yy]$ ]]
then
#
############################
####### Script Start #######
############################
    #
    echo -e "    ######################################""\033[33m""DISCLAIMER""\e[0m""#############################################
    #############################################################################################
    #############################################################################################
    ### This script is supplied as is, neither I nor FeralHosting take any responsibility for ###
    ### any problems arising due to usage of this script.  There is no implied or explicit    ###
    ### warranty and FeralHosting will provide no support for autodl-irssi. If updates and or ###
    ### revisions to either autodl or its plugin cause this script to break, this script will ###
    ### be updated at the authors convenience if at all.                                      ###
    #############################################################################################
    #############################################################################################
    #############################################################################################"
    echo
    read -ep "If you understand the above disclaimer, enter 'yes' to continue: " license
    echo
    if [[ $license = yes ]]
    then
        # checks for rutorrent...see bottom else statement for negative return
        if [ -d ~/www/$(whoami).$(hostname)/public_html/rutorrent/ ]
        then
            echo -e "\033[32m""Installing autodl-irssi and its rutorrent plugin""\e[0m"
            echo
            # Makes the directories for irssi and autodl, as well as make the autodl config file
            mkdir -p ~/.irssi/scripts/autorun ~/.autodl
            # Ask for user to enter their password. 
            # Saves password as $sedpass variable for usage later
            echo -e "\033[31m""A randomly generated password has been set for you, you can just press enter""\e[0m"
            echo
            read -ep "Enter Password (No spaces please!): " -i "$pass" pass
            echo
            # Shows uers the password they entered
            echo -e "You entered" "\033[32m""$pass""\e[0m" "as your password."
            echo
            # Confirms user password before they start
            read -p "Please confirm this is the password you wish to use [y/n]: " confirm
            echo
            # If they like their chosen password, the script installs autodl. =~ ^[Yy] is matching for Y or y
            if [[ $confirm =~ ^[Yy]$ ]]
            then
                # autodl irssi begins
                #
                # Please note, the sleep lines are there to artificially slow down the process at some steps and to allow ample time to give user feedback
                # Kill any existing processes
                killall -9 -u $(whoami) irssi 2> /dev/null 
                screen -wipe > /dev/null 2>&1
                # Clean install
                rm -rf ~/.irssi/scripts/AutodlIrssi
                rm -f ~/.irssi/scripts/autorun/autodl-irssi.pl
                rm -rf ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi
                echo "Downloading autodl-irssi"
                # Downloads the newest  RELEASE version  of the autodl community edition and saves it as a zip file
                wget -qO ~/autodl-irssi.zip https://autodl-irssi-community.googlecode.com/files/autodl-irssi-community.zip
                wget -qO ~/autodl-trackers.zip https://autodl-irssi-community.googlecode.com/files/autodl-trackers.zip
                echo "autodl-irssi download finished"
                # Unzips the files downloaded above
                echo "Unzipping"
                unzip -qo ~/autodl-irssi.zip -d ~/.irssi/scripts/
                unzip -qo ~/autodl-trackers.zip -d ~/.irssi/scripts/AutodlIrssi/trackers/
                echo "Unzipping complete"
                # Moves the files around to their proper homes.  The .pl file is moved to autorun so that autodl starts automatically when we open irssi
                # the AutodlIrssi folder is moved to scripts  (inside the perl path) so that  its contents can be loaded by irssi when it starts
                echo "Moving files around"
                cp -f ~/.irssi/scripts/autodl-irssi.pl ~/.irssi/scripts/autorun/ 
                rm -f ~/autodl-irssi.zip ~/.irssi/scripts/README* ~/autodl-irssi.zip ~/.irssi/scripts/CONTRIBUTING.md ~/.irssi/scripts/autodl-irssi.pl ~/autodl-trackers.zip
                # Uses echo to make our autodl.cfg config file.  Takes the two previously made variables, $port and $pass to  populate per user
                echo "Writing configuration files"
                if [[ -f ~/.autodl/autodl.cfg ]]
                then
                    sed -ri 's/(.*)gui-server-port =(.*)/gui-server-port = '$port'/g' ~/.autodl/autodl.cfg
                    sed -ri 's/(.*)gui-server-password =(.*)/gui-server-password = '$pass'/g' ~/.autodl/autodl.cfg
                else 
                    echo -e "[options]\ngui-server-port = $port\ngui-server-password = $pass" > ~/.autodl/autodl.cfg
                fi
                echo
                sleep 2
                #
                # autodl irssiends
                # rutorrent plugin begins
                #
                # cd into your www/.../rutorrent/plugins folder to make paths nicer
                cd ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/
                # Downloads the latest version of the autodl-irssi plugin
                echo "Downloading autodl-irssi Rutorrent plugin"
                wget -qO autodl-rutorrent.zip https://github.com/autodl-community/autodl-rutorrent/archive/master.zip
                echo "Plugin download finished"
                unzip -qo autodl-rutorrent.zip
                cp -rf autodl-rutorrent-master/. autodl-irssi
                rm -rf autodl-rutorrent.zip autodl-rutorrent-master
                echo "Creating configuration file"
                # Uses echo to make the config file for the rutorrent plugun. Uses previously set vars to populate
                echo -e "<?php\n$autodlPort = $port;\n$autodlPassword = \"$pass\";\n?>" > ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/conf.php
                # If they dont like it, it restarts the script because Im lazy and I dont feel like writing this properly
                echo
                sleep 2
                #
                # rutorrent plugin ends
            else
                bash ~/installautodl.sh
            fi
        else
            echo -e "\033[31m Install rtorrent/rutorrent first" "\e[0m"
        fi
    else
        echo "This installer will now exit"
        sleep 2
        exit 1
    fi
    # Now we fix the installation
    echo "Applying the fix script as part of the installation:"
    sleep 2
    echo
    if [ -d ~/.irssi/scripts/AutodlIrssi/ ]
    then
        sed -i "s/use constant LISTEN_ADDRESS => '127.0.0.1';/use constant LISTEN_ADDRESS => '10.0.0.1';/g" ~/.irssi/scripts/AutodlIrssi/GuiServer.pm
        sed -i 's|$rtAddress = "127.0.0.1$rtAddress"|$rtAddress = "10.0.0.1$rtAddress"|g' ~/.irssi/scripts/AutodlIrssi/MatchedRelease.pm
        sed -i 's/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "127.0.0.1"});/my $scgi = new AutodlIrssi::Scgi($rtAddress, {REMOTE_ADDR => "10.0.0.1"});/g' ~/.irssi/scripts/AutodlIrssi/MatchedRelease.pm
        #
        echo -e "\033[33m""Autodl fix has been applied""\e[0m"
    else
        echo -e "\033[36m""~/.irssi/scripts/AutodlIrssi/""\e[0m" "does not exist"
        echo -e "\033[36m""Install autodl using the bash script installer in the FAQ"
        echo
        exit
    fi
    #
    if [ -d ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/ ]
    then
        sed -i 's/if (!socket_connect($socket, "127.0.0.1", $autodlPort))/if (!socket_connect($socket, "10.0.0.1", $autodlPort))/g' ~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/getConf.php
        echo -e "\033[33m""Autodl-rutorrent fix has been applied""\e[0m"
        echo
    else
        echo -e "\033[36m""~/www/$(whoami).$(hostname)/public_html/rutorrent/plugins/autodl-irssi/""\e[0m" "does not exist"
        echo
        exit 1
    fi
    killall -9 -u $(whoami) irssi 2> /dev/null 
    screen -wipe > /dev/null 2>&1
    screen -dmS autodl irssi
    echo -e "\033[32m""Checking we have started irssi or if there are multiple screens/processes""\e[0m"
    echo -e "\033[31m"
    screen -ls | grep autodl
    echo -e "\e[0m"
    echo -e "Done. Please refresh/reload rutorrent using CTRL + F5 and start using autodl"
    echo -e "You can attach to the screen using this command:"
    echo
    echo -e "\033[32m""screen -r autodl""\e[0m"
    echo
    echo -e "The fix script in the Autodl FAQ will have to be run each time you update/overwrite the autodl or autodl-rutorrent files."
    echo
    exit 1
    #
else
    echo -e "You chose to exit after updating the scripts."
    exit 1
    cd && bash
fi
############################
####### Script Ends  #######
############################
#