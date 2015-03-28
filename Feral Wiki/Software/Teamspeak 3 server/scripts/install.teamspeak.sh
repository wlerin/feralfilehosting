#!/bin/bash
#
# Install Teamspeak 3
scriptversion="1.1.9"
teamspeakversion="3.0.11.2"
scriptname="install.teamspeak"
# randomessence 27/04/2013
#
# wget -qO ~/install.teamspeak http://git.io/aOACkQ && bash ~/install.teamspeak
#
############################
#### Script Notes Start ####
############################
#
# bash ~/private/teamspeak/ts3server_startscript.sh start
# bash ~/private/teamspeak/ts3server_startscript.sh stop
# bash ~/private/teamspeak/ts3server_startscript.sh restart
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
# 
# v 1.0.0 Intial release
# v 1.0.1 Script
# v 1.0.2 symlink and code tweaks
# v 1.0.3 Proper shutdown of any running instances of the server if the ~/private/teamspeak/ does not exists. licensing issues.
# v 1.0.4 
# v 1.0.5
# v 1.0.6
# v 1.0.7
# v 1.0.8 used random ports in a range using shuf
# v 1.1.1 updated to be inline with script formatting guidelines and general tweaks.
# v 1.1.2 3.0.10.2
# v 1.1.3 3.0.10.3
# v 1.1.4 updater tweaked
# v 1.1.5 template updated
# v 1.1.7 template updated
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Disables the built in script updater permanently.
updaterenabled="1"
#
vport=$(shuf -i 10001-20000 -n 1)
# vport the voice port: random port between 6000-50000 used in the sed commands
fport=$(shuf -i 20001-35000 -n 1)
# fport is file transfer port: vport + 1 used in the sed commands
qport=$(shuf -i 35001-49999 -n 1)
# qport is the query port: vport + 2 used in the sed commands
teamspeakfv="http://dl.4players.de/ts/releases/$teamspeakversion/teamspeak3-server_linux-amd64-$teamspeakversion.tar.gz"
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Teamspeak%203%20server/scripts/install.teamspeak.sh"
#
############################
####### Variable End #######
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
    mkdir -p ~/private
    wget -qO ~/teamspeak.tar.gz "$teamspeakfv"
    tar xf ~/teamspeak.tar.gz
    rm -f ~/teamspeak.tar.gz 2> /dev/null
    # checks if the ~/private/teamspeak already exists : If does NOT exist then :
    if [[ ! -d ~/private/teamspeak ]]
    then
        # killall ts3server_linux_amd64 incase they deleted the folder but left the process running.
        killall -qe ts3server_linux_amd64 2> /dev/null
        # ts3 licensing states for free use only one instance can be run and this is checked in shared memory. Need to give the application time to close fully.
        sleep 2
        # renames the extracted folder to teamspeak
        mv -f ~/teamspeak3-server_linux-amd64 ~/private/teamspeak
        # edits the startup parameters of the ts3server_startscript.sh to load the ini file.
        sed -i 's|COMMANDLINE_PARAMETERS="${2}"|COMMANDLINE_PARAMETERS="${2} inifile=ts3server.ini"|g' ~/private/teamspeak/ts3server_startscript.sh
    else
        echo -e "\033[32m1: The folder\e[0m \033[31m~/private/teamspeak\e[0m \033[32malready exists.\e[0m"
        echo
        if [[ -f ~/private/teamspeak/ts3server.pid ]]
        then
            # Gets the PID from the ts3server.pid and shows it to the user and the last run process
            echo -e "2: This is the PID:\033[31m$(cat ~/private/teamspeak/ts3server.pid 2> /dev/null)\e[0m generated when teamspeak was last started"
            echo
            echo -e "\033[33m3: Let's see if teamspeak is running?\e[0m"
            echo
            # check for any running instances of this previous PID. BAsed on the last run instance in the ts3server.pid
            ps p $(cat ~/private/teamspeak/ts3server.pid 2> /dev/null) --no-heading
            echo
        else
            echo -e "2: It seems you stopped teamspeak using \033[31mts3server_startscript.sh stop\e[0m (\033[36mts3server stop\e[0m) already which deletes the ts3server.pid when executed."
            echo -e "\033[33m3: The\e[0m \033[31m~/private/teamspeak/\e[0m \033[33mexists but there is no ts3server.pid to read from.\e[0m"
            echo -e "4:\033[35m I recommend you try the command\e[0m \033[36mts3server start\e[0m \033[35mor use the \033[36mUpdate [u]\e[0m option of this script.\e[0m"
        fi
        #
        echo -e "\033[31mPlease pick from one of the following options\e[0m"
        echo
        read -ep "Kill "$(cat ~/private/teamspeak/ts3server.pid 2> /dev/null)" & remove ~/private/teamspeak? A clean, new install. [y] Update the files. ts3server.ini is unchanged? [u] Press [q] to quit: "  confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
        # This is the Removal section.Kills the last known running instance then deletes ~/private/teamspeak. Extracts then renames the folder to teamspeak. Edits the startup script to load the ini file
            echo -e "\033[31mYou chose:\e[0m \033[36mRemove it\e[0m"
            echo
            # kills last known PID
            kill $(cat ~/private/teamspeak/ts3server.pid 2> /dev/null) 2> /dev/null
            sleep 2
            # removes the ~/private/teamspeak/ directory
            rm -rf ~/private/teamspeak/
            # renames the unpacked tar file to teamspeak
            mv -f ~/teamspeak3-server_linux-amd64 ~/private/teamspeak
            # Edits the startup script to load the ini file
            sed 's|COMMANDLINE_PARAMETERS="${2}"|COMMANDLINE_PARAMETERS="${2} inifile=ts3server.ini"|g' ~/private/teamspeak/ts3server_startscript.sh -i
            sleep 2
        #
        elif [[ "$confirm" =~ ^[Uu]$ ]]
        then
        # This is the Upgrade section of the script. Unpacks then copies to ~/private/teamspeak, overwriting the old files. Edits the startup script to load the ini file
            echo -e "\033[31mYou chose:\e[0m \033[36mUpgrade/Overwrite\e[0m"
            echo
            # kills last known PID
            kill $(cat ~/private/teamspeak/ts3server.pid 2> /dev/null) 2> /dev/null
            sleep 2
            # Copies the contents of the unpacked tar and overwrites the destination.
            cp -rf ~/teamspeak3-server_linux-amd64/. ~/private/teamspeak/
            # Removes the unpacked tar directory
            rm -rf ~/teamspeak3-server_linux-amd64/
            # Edits the startup script to load the ini file
            sed 's|COMMANDLINE_PARAMETERS="${2}"|COMMANDLINE_PARAMETERS="${2} inifile=ts3server.ini"|g' ~/private/teamspeak/ts3server_startscript.sh -i
            sleep 2
            bash ~/private/teamspeak/ts3server_startscript.sh start
            echo
            # These show the user the IP and the Port from the ts3server.ini
            echo -e "\033[32mCurrent\e[0m \033[31mHOST\e[0m:\033[36mPORT\e[0m =\e[0m \033[31m"$(hostname -f)"\e[0m:\033[36m"$(sed -n -e 's/default_voice_port=\(.*\)/\1/p' ~/private/teamspeak/ts3server.ini)"\e[0m"
            echo
            echo -e "\033[33mThis script updated the teamspeak files and will now exit\e[0m"
            echo
            exit
        else
            rm -rf ~/teamspeak3-server_linux-amd64/
            echo -e "\033[31mYou must delete or upgrade this directory to continue then restart the script.\e[0m \033[32mYou might want to backup your ts3server.ini file first.\e[0m"
            echo
            exit
        fi
    fi
    echo -e "machine_id=\ndefault_voice_port=9987\nvoice_ip=0.0.0.0\nlicensepath=\nfiletransfer_port=30033\nfiletransfer_ip=0.0.0.0\nquery_port=10011\nquery_ip=0.0.0.0\nquery_ip_whitelist=query_ip_whitelist.txt\nquery_ip_blacklist=query_ip_blacklist.txt\ndbplugin=ts3db_sqlite3\ndbpluginparameter=\ndbsqlpath=sql/\ndbsqlcreatepath=create_sqlite/\ndbconnections=10\nlogpath=logs\nlogquerycommands=0\ndbclientkeepdays=30\nlogappend=0\nquery_skipbruteforcecheck=0" > ~/private/teamspeak/ts3server.ini
    #
    sed -i "s|default_voice_port=9987|default_voice_port=$vport|g" ~/private/teamspeak/ts3server.ini
    sed -i "s|filetransfer_port=30033|filetransfer_port=$fport|g" ~/private/teamspeak/ts3server.ini
    sed -i "s|query_port=10011|query_port=$qport|g" ~/private/teamspeak/ts3server.ini
    #
    ln -fs ~/private/teamspeak/ts3server_startscript.sh ~/bin/ts3server
    chmod 700 ~/bin/ts3server
    sleep 2
    bash ~/private/teamspeak/ts3server_startscript.sh start
    #
    echo -e "\033[32mHere is the connection info:\e[0m \033[31m$(hostname -f)\e[0m:\033[33m$vport\e[0m"
    echo -e "\033[32mPress \033[36mCTRL + C\e[0m \033[32mto get your prompt back in the next section\e[0m"
    echo -e "\033[31mThis script has done its job and will now exit\e[0m"
    echo
    exit
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    exit
fi
#
############################
##### Core Script Ends #####
############################
#