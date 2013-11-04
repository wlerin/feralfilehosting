#!/bin/bash
# Install Subsonic
#
scriptversion="1.6.0"
scriptname="subsonic.4.8.sh"
subsonicversion="4.8"
madsonicversion="5.0 Build 3780"
javaversion="1.7 Update 45"
jvdecimal="1.7.0_45"
#
# Bobtentpeg 01/30/2013
# randomessence 04/24/2013
#
# * * * * * bash -l ~/bin/subsonicron
#
# wget -qO ~/subsonic.4.8.sh http://git.io/aFIIXg && bash ~/subsonic.4.8.sh
#
############################
## Version History Starts ##
############################
# 
# See version.txt
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Sets a random port between 6000-50000 for http
http=$(shuf -i 6000-50000 -n 1)
# Defines https as + 1 from http
https=$(expr 1 + $http)
# Defines the memory memory variable
#subsonic
submemory="3072"
# Madsonic
initmemory="2048"
maxmemory="3072"
# Gets the Java version from the last time this scrip installed Java
installedjavaversion=$(cat ~/programs/javaversion 2> /dev/null)
# Java URL
javaupdatev="http://javadl.sun.com/webapps/download/AutoDL?BundleId=81812"
# Some variable links for subsonic
subsonicfv="https://sourceforge.net/projects/subsonic/files/subsonic/4.8/subsonic-4.8-standalone.tar.gz"
subsonicfvs="subsonic-4.8-standalone.tar.gz"
sffmpegfv="https://bitbucket.org/feralhosting/feralfiles/downloads/ffmpeg.31.10.2013.zip"
sffmpegfvs="ffmpeg.31.10.2013.zip"
# Some variable links for madsonic
madsonicfv="https://bitbucket.org/feralhosting/feralfiles/downloads/5.0.3780-standalone.zip"
madsonicfvs="5.0.3780-standalone.zip"
# Madsonic custom ffmpeg with Audioffmpeg
mffmpegfvc="https://bitbucket.org/feralhosting/feralfiles/downloads/ffmpeg.31.10.2013.zip"
mffmpegfvcs="ffmpeg.31.10.2013.zip"
#
############################
####### Variable End #######
############################
#
############################
####### Script Start #######
############################
#
###### Self Updater Starts
#
mkdir -p $HOME/bin
#
if [[ ! -f  "$HOME/subsonic.4.8.sh" ]]
then
    wget -qO $HOME/subsonic.4.8.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
fi
if [[ ! -f  "$HOME/bin/subsonic.4.8" ]]
then
    wget -qO $HOME/bin/subsonic.4.8 https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
fi
#
wget -qO $HOME/000subsonic.4.8.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
#
if ! diff -q "$HOME/000subsonic.4.8.sh" "$HOME/subsonic.4.8.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/subsonic.4.8.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
    wget -qO $HOME/bin/subsonic.4.8 https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
    bash $HOME/subsonic.4.8.sh
    exit 1' > $HOME/111subsonic.4.8.sh
    bash $HOME/111subsonic.4.8.sh
    exit 1
fi
if ! diff -q "$HOME/000subsonic.4.8.sh" "$HOME/bin/subsonic.4.8" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/subsonic.4.8.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
    wget -qO $HOME/bin/subsonic.4.8 https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
    bash $HOME/subsonic.4.8.sh
    exit 1' > $HOME/222subsonic.4.8.sh
    bash $HOME/222subsonic.4.8.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
echo -e "The version of the" "\033[33m""Subsonic""\e[0m" "server being used in this script is:" "\033[31m""$subsonicversion""\e[0m"
echo -e "The version of the" "\033[33m""Madsonic""\e[0m" "server being used in this script is:" "\033[31m""$madsonicversion""\e[0m"
echo -e "The version of the" "\033[33m""Java""\e[0m" "being used in this script is:" "\033[31m""$javaversion""\e[0m"
if [[ -f ~/private/subsonic/.version ]]
then
    echo
    echo -e "Your currently installed version is:" "\033[32m""$(sed -n '1p' ~/private/subsonic/.version)""\e[0m"
fi    
echo
#
rm -f $HOME/000subsonic.4.8.sh $HOME/111subsonic.4.8.sh $HOME/222subsonic.4.8.sh $HOME/294857.sh $HOME/6273846.sh
chmod -f 700 ~/bin/subsonic.4.8
### Self Updater ends
#
#############################
#### subsonicrsk starts  ####
#############################
#
# This section MUST be escaped properly using backslash when adding to it.
echo -e "#!/bin/bash
#
httpport=\$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)
httpsport=\$(sed -n -e 's/SUBSONIC_HTTPS_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)
#
# v 1.2.0  Kill Start Restart Script generated by the subsonic installer script
#
echo
echo -e \"\\\033[33m1:\\\e[0m This is the process PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m used the last time \\\033[36m~/private/subsonic/subsonic.sh\\\e[0m was started.\"
echo
echo -e \"\\\033[33m2:\\\e[0m These are the URLs and ports Subsonic/Madsonic is configured to use:\"
echo
echo -e \"\\\033[31mHTTP\\\e[0m last accessible at \\\033[31mhttp://\$(hostname)\\\e[0m:\\\033[33m\$httpport\\\e[0m\"
echo -e \"\\\033[32mHTTPS\\\e[0m last accessible at \\\033[32mhttps://\$(hostname)\\\e[0m:\\\033[33m\$httpsport\\\e[0m\"
echo
echo -e \"\\\033[33m3:\\\e[0m Running instances checks:\"
echo
echo -e \"Checking to see, specifically, if the \\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is running\"
echo -e \"\\\033[32m\"
if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
then
    echo -e \"Nothing to show.\"
    echo -e \"\\\e[0m\"
else
    ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
    echo -e \"\\\e[0m\"
fi
if [[ \"\$(ps -U \$(whoami) | grep -c java)\" -gt \"1\" ]]
then
    echo -e \"There are currently \\\033[31m\$(ps -U \$(whoami) | grep -c java 2> /dev/null)\\\e[0m running Java processes.\"
    echo -e \"\\\033[31mWarning:\\\e[0m \\\033[32mSubsonic or Madsonic might not load or be unpredicatable with multiple instances running.\\\e[0m\"
    echo -e \"\\\033[33mIf there are multiple Subsonic or Madsonic processes please use the killall by using option [a] then use the restart option.\\\e[0m\"
    echo -e \"\\\033[31m\"
    ps -U \$(whoami) | grep java
    echo -e \"\\\e[0m\"
fi
echo -e \"\\\033[33m4:\\\e[0m Options for killing and restarting Subsonic or Madsonic:\"
echo
echo -e \"\\\033[36mKill PID only\\\e[0m \\\033[31m[y]\\\e[0m \\\033[36mKillall java processes\\\e[0m \\\033[31m[a]\\\e[0m \\\033[36mSkip to restart (where you can quit the script)\\\e[0m \\\033[31m[r]\\\e[0m\"
echo
read -ep \"Please press one of these options [y] or [a] or [r] and press enter: \"  confirm
echo
if [[ \$confirm =~ ^[Yy]\$ ]]
then
    kill -9 \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) 2> /dev/null
    echo -e \"The process PID:\\\033[31m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m that was started by the installer or custom scripts has been killed.\"
    echo
    echo -e \"Checking to see if the PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is running:\\\e[0m\"
    echo -e \"\\\033[32m\"
    if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
    then
        echo -e \"Nothing to show, job done.\"
        echo -e \"\\\e[0m\"
    else
        ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
        echo -e \"\\\e[0m\"
    fi
elif [[ \$confirm =~ ^[Aa]\$ ]]
then
    killall -9 -u \$(whoami) java 2> /dev/null
    echo -e \"\\\033[31mAll java processes have been killed\\\e[0m\"
    echo
    echo -e \"\\\033[33mChecking for open java processes:\\\e[0m\"
    echo -e \"\\\033[32m\"
    if [[ -z \"\$(ps -U \$(whoami) | grep java 2> /dev/null)\" ]]
    then
        echo -e \"Nothing to show, job done.\"
        echo -e \"\\\e[0m\"
    else
        ps -U \$(whoami) | grep java
        echo -e \"\\\e[0m\"
    fi
else
    echo -e \"Skipping to restart or quit\"
    echo
fi
if [[ -f ~/private/subsonic/subsonic.sh ]]
then
    read -ep \"Would you like to restart subsonic? [r] reload the kill features? [l] or quit the script? [q]: \"  confirm
    echo
    if [[ \$confirm =~ ^[Rr]\$ ]]
    then
        if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
        then
            bash ~/private/subsonic/subsonic.sh
            echo -e \"Started Subsonic at PID:\\\033[31m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m\"
            echo
            echo -e \"\\\033[31mHTTP\\\e[0m Accessible at \\\033[31mhttp://\$(hostname)\\\e[0m:\\\033[33m\$httpport\\\e[0m\"
            echo -e \"\\\033[32mHTTPS\\\e[0m Accessible at \\\033[32mhttps://\$(hostname)\\\e[0m:\\\033[33m\$httpsport\\\e[0m\"
            echo -e \"\\\033[32m\"
            if [[ -z \"\$(ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
            then
                echo -e \"Nothing to show, job done.\"
                echo -e \"\\\e[0m\"
            else
                ps -p \$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
                echo -e \"\\\e[0m\"
            fi
            exit 1
        else
            echo -e \"Subsonic with the PID:\\\033[32m\$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)\\\e[0m is already running. Kill it first then restart\"
            echo
            read -ep \"Would you like to restart the RSK script? [y] reload it? [q] or quit the script?: \"  confirmrsk
            echo
            if [[ \$confirmrsk =~ ^[Yy]\$ ]]
            then
                bash ~/bin/subsonicrsk
            fi
            exit 1
        fi
    elif [[ \$confirm =~ ^[Ll]\$ ]]
    then
        echo -e \"\\\033[31mReloading subsonicrsk to access kill features.\\\e[0m\"
        echo
        bash ~/bin/subsonicrsk
    else
        echo This script has done its job and will now exit.
        echo
        exit 1
    fi
else
    echo
    echo -e \"The \\\033[31m~/private/subsonic/subsonic.sh\\\e[0m does not exist.\"
    echo -e \"please run the \\\033[31m~/subsonic.4.8.sh\\\e[0m to install and configure subsonic\"
    exit 1
fi" > ~/bin/subsonicrsk
#
#############################
##### subsonicrsk ends  #####
#############################
#
#############################
#### subsonicron starts  ####
#############################
#
echo '#!/bin/bash
echo "$(date +"%H:%M on the %d.%m.%y")" >> subsonicrun.log
if [[ -z "$(ps -p $(cat ~/private/subsonic/subsonic.sh.PID) --no-headers)" ]]
then
    bash ~/private/subsonic/subsonic.sh
else
    exit 1
fi' > ~/bin/subsonicron
#
#############################
##### subsonicron ends  #####
#############################
#
chmod -f 700 ~/bin/subsonicrsk
chmod -f 700 ~/bin/subsonicron
#
echo -e "The" "\033[36m""~/bin/subsonicrsk""\e[0m" "has been updated."
echo
read -ep "Do you want to continue with the installer? [y] or quit now? [n] : " confirm
echo
#
###### Installer Starts here
#
if [[ $confirm =~ ^[Yy]$ ]]
then
    echo -e "\033[31m""User Notice:""\e[0m" "\033[33m""This is a user supported script. Please don't expect or ask staff to support this directly.\nTo get support you can jump on IRC and ask other users for help.\nAll critical bugs should be reported and bug fixes or improvements are welcomed and encouraged.""\e[0m"
    echo
    sleep 2
    ###### Install Java 1.7 Start
    if [[ "$installedjavaversion" != "$javaversion" ]]
    then
        echo "Please wait a moment while java is installed"
        rm -rf ~/private/java
        wget -qO ~/java.tar.gz $javaupdatev
        tar xf ~/java.tar.gz
        cp -rf ~/jre$jvdecimal/. ~/programs
        rm -f ~/java.tar.gz
        rm -rf ~/jre$jvdecimal
        if [[ ! "$(grep -o 'PATH=~/programs/bin:$PATH' ~/.bashrc)" ]]
        then
            echo 'export PATH=~/programs/bin:$PATH' >> ~/.bashrc
        fi
        echo -n "$javaversion" > ~/programs/javaversion
        # we create a custom Java version file for comparison so the installer only runs once
        echo -e "\033[31m""Important:""\e[0m" "Java" "\033[32m""$javaversion""\e[0m" "has been installed to" "\033[36m""~/private/java""\e[0m"
        echo
        echo -e "This Script needs to exit for the Java changes to take effect. Please restart the Script using this command:"
        echo
        echo 'bash ~/subsonic.4.8.sh'
        echo
        bash
        exit 1
    fi
    ### Install Java 1.7 end
    if [[ ! -d ~/private/subsonic/ ]]
    then
        read -ep "Install Subsonic [s] or install Madsonic [m]: "  whichversion
        echo
        if [[ $whichversion =~ ^[Ss]$ ]]
        then
            # Checks to see if the directory ~/private/subsonic/ exists. If NOT it does the then. If it is found it does the else.
            echo -e "Congratulations," "\033[31m""Java is installed""\e[0m"". Continuing with the installation."
            sleep 1
            echo
            # An echo telling the user that Java is already installed.
            #
            echo -e "Path" "\033[36m""~/private/subsonic/""\e[0m" "created. Moving to next step."
            mkdir -p ~/private/subsonic/transcode
            mkdir -p ~/private/subsonic/playlists
            mkdir -p ~/private/subsonic/Podcasts
            echo -n "$subsonicfvs" > ~/private/subsonic/.version
            echo
            # Creates some directories we need for configuring the start-up script
            #
            echo -e "\033[32m""$subsonicfvs""\e[0m" "Is downloading now."
            wget -qO ~/private/subsonic/subsonic.tar.gz $subsonicfv
            echo -e "\033[36m""$subsonicfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""subsonic.tar.gz\e[0m"
            # Gets the latest version of subsonic from sourceforge. Currently at 4.8
            #
            echo -e "\033[36m""subsonic.tar.gz""\e[0m" "Is unpacking now."
            tar xf ~/private/subsonic/subsonic.tar.gz -C ~/private/subsonic/
            echo -e "\033[36m""subsonic.tar.gz""\e[0m" "Has been unpacked to" "\033[36m""~/private/subsonic/\e[0m"
            # Unpack this this version from its tar.gz archive to the ~/private/subsonic/ directory
            #
            rm -f ~/private/subsonic/subsonic.tar.gz
            sleep 1
            echo
            # tidy up
            #
            echo -e "\033[32m""$sffmpegfvs""\e[0m" "Is downloading now."
            wget -qO ~/private/subsonic/transcode/ffmpeg.tar.gz $sffmpegfv
            echo -e "\033[36m""$sffmpegfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""ffmpeg.tar.gz\e[0m"
            # Downloads a perma hosted version of ffmpeg static and renames it to ffmpeg.tar.gz. Dated at 14/06/2013
            #
            echo -e "\033[36m""$sffmpegfvs""\e[0m" "Is being unpacked now."
            tar -xzf ~/private/subsonic/transcode/ffmpeg.tar.gz -C ~/private/subsonic/transcode/
            chmod -f 700 ~/private/subsonic/transcode/ffmpeg
            echo -e "\033[36m""$sffmpegfvs""\e[0m" "Has been unpacked to" "\033[36m~/private/subsonic/transcode/\e[0m"
            # Unpacks this static ffmpeg binary from its tar.gz archive to ~/private/subsonic/transcode/
            #
            rm -f ~/private/subsonic/transcode/ffmpeg.tar.gz
            sleep 1
            echo
            # tidy up
            #
            echo -e "\033[32m""Copying over a local version of lame.""\e[0m"
            cp -f /usr/local/bin/lame ~/private/subsonic/transcode/ 2> /dev/null
            chmod -f 700 ~/private/subsonic/transcode/lame
            echo -e "Lame copied to" "\033[36m""~/private/subsonic/transcode/\e[0m"
            sleep 1
            echo
            # copies over the local version of lame to ~/private/subsonic/transcode/
            #
            echo -e "\033[32m""Copying over a local version of flac.""\e[0m"
            cp -f /usr/bin/flac ~/private/subsonic/transcode/ 2> /dev/null
            chmod -f 700 ~/private/subsonic/transcode/flac
            echo -e "Flac copied to" "\033[36m""~/private/subsonic/transcode/""\e[0m"
            sleep 1
            echo
            # copies over the local version of flac to ~/private/subsonic/transcode/
            #
            echo -e "\033[31m""Configuring the start-up script.""\e[0m"
            echo -e "\033[35m""User input is required for this next step:""\e[0m"
            echo -e "\033[33m""Note on user input:""\e[0m" "It is OK to use a relative path like:" "\033[33m""~/private/rtorrent/data""\e[0m"
            #
            sed -i 's|SUBSONIC_HOME=/var/subsonic|SUBSONIC_HOME=~/private/subsonic|g' ~/private/subsonic/subsonic.sh
            sed -i "s/SUBSONIC_PORT=4040/SUBSONIC_PORT=$http/g" ~/private/subsonic/subsonic.sh
            sed -i "s/SUBSONIC_HTTPS_PORT=0/SUBSONIC_HTTPS_PORT=$https/g" ~/private/subsonic/subsonic.sh
            sed -i "s/SUBSONIC_MAX_MEMORY=150/SUBSONIC_MAX_MEMORY=$submemory/g" ~/private/subsonic/subsonic.sh
            sed -i '0,/SUBSONIC_PIDFILE=/s|SUBSONIC_PIDFILE=|SUBSONIC_PIDFILE=~/private/subsonic/subsonic.sh.PID|g' ~/private/subsonic/subsonic.sh
            # Edit the mains settings.
            #
            read -ep "Enter the path to your media or leave blank and press enter to skip: " path
            sed -i "s|SUBSONIC_DEFAULT_MUSIC_FOLDER=/var/music|SUBSONIC_DEFAULT_MUSIC_FOLDER=$path|g" ~/private/subsonic/subsonic.sh
            sed -i 's|SUBSONIC_DEFAULT_PODCAST_FOLDER=/var/music/Podcast|SUBSONIC_DEFAULT_PODCAST_FOLDER=~/private/subsonic/Podcast|g' ~/private/subsonic/subsonic.sh
            sed -i 's|SUBSONIC_DEFAULT_PLAYLIST_FOLDER=/var/playlist|SUBSONIC_DEFAULT_PLAYLIST_FOLDER=~/private/subsonic/playlists|g' ~/private/subsonic/subsonic.sh
            # Edit the paths
            #
            sed -i 's/quiet=0/quiet=1/g' ~/private/subsonic/subsonic.sh
            # Set the process to be quiet
            #
            sed -i "22 i export LC_ALL=en_GB.UTF-8\n" ~/private/subsonic/subsonic.sh
            sed -i '22 i export LANG=en_GB.UTF-8' ~/private/subsonic/subsonic.sh
            sed -i '22 i export LANGUAGE=en_GB.UTF-8' ~/private/subsonic/subsonic.sh
            # Add some locale settings in case they are not set already to work with UTF characters
            #
            echo
            echo -e "\033[31m""Start-up script successfully configured.""\e[0m"
            #
            #
            echo "Executing the start-up script now."
            #
            #
            bash ~/private/subsonic/subsonic.sh
            # starts subsonic using the pre configured subsonic.sh
            #
            echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
            #
            echo -e "\033[32m""Subsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
            sleep 1
            # Job done echo
            #
            echo
            echo -e "\033[31m""HTTP""\e[0m" "is accessible at" "\033[31m""http://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
            echo -e "HTTPS uses a custom but invalid subsonic.org cert and not one from Feral. It is safe to accept."
            echo -e "\033[32m""HTTPS""\e[0m" "is accessible at" "\033[32m""https://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/SUBSONIC_HTTPS_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
            echo
            echo -e "Subsonic started at PID:" "\033[31m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m"
            echo
            # urls are printed for the user to select.
            bash
            exit 1
        elif [[ $whichversion =~ ^[Mm]$ ]]
        then 
            echo -e "Congratulations," "\033[31m""Java is installed""\e[0m"". Continuing with the installation."
            sleep 1
            echo
            # An echo telling the user that Java is already installed.
            echo -e "Path" "\033[36m""~/private/madsonic/""\e[0m" "created. Moving to next step."
            mkdir -p ~/sonictmp
            mkdir -p ~/private/madsonic/transcode
            mkdir -p ~/private/madsonic/playlists
            mkdir -p ~/private/madsonic/Incoming
            mkdir -p ~/private/madsonic/Podcast
            mkdir -p ~/private/madsonic/playlist-import
            mkdir -p ~/private/madsonic/playlist-export
            echo -n "$madsonicfvs" > ~/private/madsonic/.version
            echo
            # Creates some directories we need for configuring the start-up script
            echo -e "\033[32m""$madsonicfvs""\e[0m" "Is downloading now."
            wget -qO ~/sonictmp/madsonic.zip $madsonicfv
            echo -e "\033[36m""$madsonicfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""madsonic.zip\e[0m"
            # Gets the latest version of madsonic from sourceforge. Currently at 4.8
            #
            echo -e "\033[36m""madsonic.zip""\e[0m" "Is unpacking now."
            unzip -qo ~/sonictmp/madsonic.zip -d ~/private/madsonic
            echo -e "\033[36m""madsonic.zip""\e[0m" "Has been unpacked to" "\033[36m""~/private/madsonic/\e[0m"
            # Unpack this this version from its tar.gz archive to the ~/private/madsonic/ directory
            sleep 1
            echo
            # tidy up
            #
            echo -e "\033[32m""$mffmpegfvcs""\e[0m" "Is downloading now."
            wget -qO ~/sonictmp/ffmpeg.zip $mffmpegfvc
            echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Has been downloaded and renamed to" "\033[36m""ffmpeg.tar.gz\e[0m"
            # Downloads a perma hosted version of ffmpeg static and renames it to ffmpeg.tar.gz. Dated at 04/24/2013
            #
            echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Is being unpacked now."
            unzip -qo ~/sonictmp/ffmpeg.zip -d ~/private/madsonic/transcode/
            chmod -f 700 ~/private/madsonic/transcode/Audioffmpeg ~/private/madsonic/transcode/ffmpeg
            # cp -f ~/private/madsonic/transcode/ffmpeg ~/private/madsonic/transcode/Audioffmpeg 2> /dev/null
            echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Has been unpacked to" "\033[36m~/private/madsonic/transcode/\e[0m"
            # Unpacks this static ffmpeg binary from its tar.gz archive to ~/private/madsonic/transcode/
            rm -rf ~/sonictmp
            sleep 1
            echo
            # tidy up
            #
            echo -e "\033[32m""Copying over a local version of lame.""\e[0m"
            # cp -f /usr/local/bin/lame ~/private/madsonic/transcode/ 2> /dev/null
            chmod -f 700 ~/private/madsonic/transcode/lame
            echo -e "Lame copied to" "\033[36m""~/private/madsonic/transcode/\e[0m"
            sleep 1
            echo
            # copies over the local version of lame to ~/private/madsonic/transcode/
            #
            echo -e "\033[32m""Copying over a local version of Flac.""\e[0m"
            cp -f /usr/bin/flac ~/private/madsonic/transcode/ 2> /dev/null
            chmod -f 700 ~/private/madsonic/transcode/flac
            echo -e "Flac copied to" "\033[36m""~/private/madsonic/transcode/""\e[0m"
            sleep 1
            echo
            # copies over the local version of Flac to ~/private/madsonic/transcode/
            #
            echo -e "\033[31m""Configuring the start-up script.""\e[0m"
            echo -e "\033[35m""User input is required for this next step:""\e[0m"
            echo -e "\033[33m""Note on user input:""\e[0m" "It is OK to use a relative path like:" "\033[33m""~/private/rtorrent/data""\e[0m"
            #
            sed -i 's|MADSONIC_HOME=/var/madsonic|MADSONIC_HOME=~/private/madsonic|g' ~/private/madsonic/madsonic.sh
            sed -i "s/MADSONIC_PORT=4040/MADSONIC_PORT=$http/g" ~/private/madsonic/madsonic.sh
            sed -i "s/MADSONIC_HTTPS_PORT=0/MADSONIC_HTTPS_PORT=$https/g" ~/private/madsonic/madsonic.sh
            sed -i "s/MADSONIC_INIT_MEMORY=256/MADSONIC_INIT_MEMORY=$initmemory/g" ~/private/madsonic/madsonic.sh
            sed -i "s/MADSONIC_MAX_MEMORY=350/MADSONIC_MAX_MEMORY=$submemory/g" ~/private/madsonic/madsonic.sh
            sed -i '0,/MADSONIC_PIDFILE=/s|MADSONIC_PIDFILE=|MADSONIC_PIDFILE=~/private/madsonic/madsonic.sh.PID|g' ~/private/madsonic/madsonic.sh
            # Edit the mains settings.
            #
            read -ep "Enter the path to your media or leave blank and press enter to skip: " path
            sed -i "s|MADSONIC_DEFAULT_MUSIC_FOLDER=/var/media|MADSONIC_DEFAULT_MUSIC_FOLDER=$path|g" ~/private/madsonic/madsonic.sh
            sed -i 's|MADSONIC_DEFAULT_UPLOAD_FOLDER=/var/media/Incoming|MADSONIC_DEFAULT_UPLOAD_FOLDER=~/private/madsonic/Incoming|g' ~/private/madsonic/madsonic.sh
            sed -i 's|MADSONIC_DEFAULT_PODCAST_FOLDER=/var/media/Podcast|MADSONIC_DEFAULT_PODCAST_FOLDER=~/private/madsonic/Podcast|g' ~/private/madsonic/madsonic.sh
            sed -i 's|MADSONIC_DEFAULT_PLAYLIST_IMPORT_FOLDER=/var/media/playlist-import|MADSONIC_DEFAULT_PLAYLIST_IMPORT_FOLDER=~/private/madsonic/playlist-import|g' ~/private/madsonic/madsonic.sh
            sed -i 's|MADSONIC_DEFAULT_PLAYLIST_EXPORT_FOLDER=/var/media/playlist-export|MADSONIC_DEFAULT_PLAYLIST_EXPORT_FOLDER=~/private/madsonic/playlist-export|g' ~/private/madsonic/madsonic.sh
            # Edit the paths
            #
            sed -i 's/quiet=0/quiet=1/g' ~/private/madsonic/madsonic.sh
            # Set the process to be quiet
            #
            sed -i "22 i export LC_ALL=en_GB.UTF-8\n" ~/private/madsonic/madsonic.sh
            sed -i '22 i export LANG=en_GB.UTF-8' ~/private/madsonic/madsonic.sh
            sed -i '22 i export LANGUAGE=en_GB.UTF-8' ~/private/madsonic/madsonic.sh
            # Add some locale settings in case they are not set already to work with UTF characters
            #
            echo
            echo -e "\033[31m""Start-up script successfully configured.""\e[0m"
            #
            #
            echo "Executing the start-up script now."
            #
            #
            bash ~/private/madsonic/madsonic.sh
            # starts madsonic using the pre configured madsonic.sh
            #
            echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
            #
            echo -e "\033[32m""Madsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
            sleep 1
            # Job done echo
            #
            echo
            echo -e "\033[31m""HTTP""\e[0m" "is accessible at" "\033[31m""http://$(hostname)""\e[0m"":""\033[33m""$(sed -n 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)""\e[0m"
            echo -e "HTTPS uses a custom but invalid subsonic.org cert and not one from Feral. It is safe to accept."
            echo -e "\033[32m""HTTPS""\e[0m" "is accessible at" "\033[32m""https://$(hostname)""\e[0m"":""\033[33m""$(sed -n 's/MADSONIC_HTTPS_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)""\e[0m"
            echo
            echo -e "Madsonic started at PID:" "\033[31m""$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)""\e[0m"
            echo
            # urls and warnings are printed for the user to select and read.
            bash
            exit 1
        else
            echo -e "No such option, exiting"
            echo
            bash
            exit 1
        fi
    else
        echo -e "\033[31m""Subsonic appears to already be installed.""\e[0m" "Please kill the PID:" "\033[33m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m" "if it is running and delete the" "\033[36m""~/private/subsonic directory""\e[0m"
        echo
        read -ep "Would you like me to kill Java (all Java processes) and remove the directories for you? [y] or update your installation [u] quit now [q]: "  confirm
        if [[ $confirm =~ ^[Yy]$ ]]
        then
            echo
            echo "Killing all Java processes."
            killall -9 -u $(whoami) java 2> /dev/null
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Removing ~/private/subsonic"
            rm -rf ~/private/subsonic
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Removing RSK scripts if present."
            rm -f ~/subsonicstart.sh
            rm -f ~/subsonicrestart.sh
            rm -f ~/subsonickill.sh
            rm -f ~/subsonicrsk.sh
            rm -f ~/bin/subsonicrsk
            rm -f ~/bin/subsonicron
            # legacy removals
            echo -e "\033[31m" "Done""\e[0m"
            sleep 1
            echo "Finalising removal."
            rm -rf ~/private/subsonic
            echo -e "\033[31m" "Done and Done""\e[0m"
            echo
            sleep 1
            read -ep "Would you like you relaunch the installer [y] or quit [q]: "  confirm
            if [[ $confirm =~ ^[Yy]$ ]]
            then
                echo
                echo -e "\033[32m" "Relaunching the installer.""\e[0m"
                if [[ -f ~/subsonic.4.8.sh ]]
                then
                    bash ~/subsonic.4.8.sh
                else
                    wget -qO ~/subsonic.4.8.sh https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%204.8/scripts/4.8/install.subsonic.4.8.sh
                    bash ~/subsonic.4.8.sh
                fi
            else
                exit 1
            fi
        elif [[ $confirm =~ ^[Uu]$ ]]
        then
            read -ep "Would you like to update Subsonic [s] or Madsonic [m]: "  confirmupdate
            echo
            if [[ $confirmupdate =~ ^[Ss]$ ]]
            then
                echo -e "Subsonic is being updated. This will only take a moment."
                echo
                killall -9 -u $(whoami) java 2> /dev/null
                mkdir -p ~/sonictmp
                wget -qO ~/subsonic.tar.gz $subsonicfv
                tar -xzf ~/subsonic.tar.gz -C ~/sonictmp
                rm -f ~/sonictmp/subsonic.sh
                cp -rf ~/sonictmp/. ~/private/subsonic/
                wget -qO ~/subffmpeg.tar.gz $sffmpegfv
                tar -xzf ~/subffmpeg.tar.gz -C ~/private/subsonic/transcode
                chmod -f 700 ~/private/subsonic/transcode/ffmpeg
                echo -n "$subsonicfvs" > ~/private/subsonic/.version
                rm -rf ~/subsonic.tar.gz ~/subffmpeg.tar.gz ~/sonictmp
                bash ~/private/subsonic/subsonic.sh
                echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
                echo -e "\033[32m""Subsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
                sleep 1
                echo
                echo -e "\033[31m""HTTP""\e[0m" "is accessible at" "\033[31m""http://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/SUBSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
                echo -e "HTTPS uses a custom but invalid subsonic.org cert and not one from Feral. It is safe to accept."
                echo -e "\033[32m""HTTPS""\e[0m" "is accessible at" "\033[32m""https://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/SUBSONIC_HTTPS_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
                echo
                echo -e "Subsonic started at PID:" "\033[31m""$(cat ~/private/subsonic/subsonic.sh.PID 2> /dev/null)""\e[0m"
                echo
                bash
                exit 1
            elif [[ $confirmupdate =~ ^[Mm]$ ]]
            then
                echo -e "Madsonic is being updated. This will only take a moment."
                echo
                killall -9 -u $(whoami) java 2> /dev/null
                mkdir -p ~/sonictmp
                wget -qO ~/madsonic.zip $madsonicfv
                unzip -qo ~/madsonic.zip -d ~/sonictmp
                rm -f ~/sonictmp/madsonic.sh
                cp -rf ~/sonictmp/. ~/private/madsonic/
                wget -qO ~/madffmpeg.zip $mffmpegfvc
                unzip -qo ~/madffmpeg.zip -d ~/private/madsonic/transcode
                chmod -f 700 ~/private/madsonic/transcode/Audioffmpeg ~/private/madsonic/transcode/ffmpeg
                echo -n "$madsonicfvs" > ~/private/madsonic/.version
                rm -rf ~/madsonic.zip ~/madffmpeg.zip ~/sonictmp
                bash ~/private/madsonic/madsonic.sh
                echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/subsonicrsk""\e[0m"
                echo -e "\033[32m""Madsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
                sleep 1
                echo
                echo -e "\033[31m""HTTP""\e[0m" "is accessible at" "\033[31m""http://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
                echo -e "HTTPS uses a custom but invalid subsonic.org cert and not one from Feral. It is safe to accept."
                echo -e "\033[32m""HTTPS""\e[0m" "is accessible at" "\033[32m""https://$(hostname)""\e[0m"":""\033[33m""$(sed -n -e 's/MADSONIC_HTTPS_PORT=\([0-9]\+\)/\1/p' ~/private/subsonic/subsonic.sh 2> /dev/null)""\e[0m"
                echo
                echo -e "Madsonic started at PID:" "\033[31m""$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)""\e[0m"
                echo
                bash
                exit 1
            else
                echo "You did not select a valid option. The script will exit."
                echo
                exit 1
            fi
        else
            echo
            exit 1
        fi
    fi
else
    echo -e "You chose to exit after updating the scripts."
    echo
    bash
    exit 1
fi
############################
####### Script Ends  #######
############################