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
# wget -qO ~/install.teamspeak https://git.io/vzWZi && bash ~/install.teamspeak
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
if [[ ! -z "$1" && "$1" = 'changelog' ]]
then
    echo
    #
    # put your version changes in the single quotes and then uncomment the line.
    #
    #echo 'v1.2.0 template updated'
    #echo 'v1.1.4 updater tweaked'
    #echo 'v1.1.3 3.0.10.3'
    #echo 'v1.1.2 3.0.10.2'
    #echo 'v1.1.1 updated to be inline with script formatting guidelines and general tweaks.'
    #echo 'v1.0.8 used random ports in a range using shuf'
    #echo 'v1.0.3 Proper shutdown of any running instances of the server if the ~/private/teamspeak/ does not exists. licensing issues.'
    #echo 'v1.0.2 symlink and code tweaks'
    #echo 'v1.0.1 Script'
    echo 'v1.0.0 Intial release'
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
scriptversion="1.2.0"
#
# Script name goes here. Please prefix with install.
scriptname="install.teamspeak"
#
# Author name goes here.
scriptauthor="None credited"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="https://git.io/vzWZi "
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Archived/Teamspeak%203%20server/scripts/install.teamspeak.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass="$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)"
# This will generate a random port for the script between the range 10001 to 32001 to use with applications. You can ignore this unless needed.
appport="$(shuf -i 10001-15000 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport="$(shuf -i 10001-15000 -n 1)"; done
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
teamspeakversion="3.0.11.4"
#
# vport the voice port: random port between 10001-20000 used in the sed commands
vport=$(shuf -i 15001-20000 -n 1)
while [[ "$(netstat -ln | grep ':'"$vport"'' | grep -c 'LISTEN')" -eq "1" ]]; do vport=$(shuf -i 15001-20000 -n 1); done
# fport is file transfer port: vport + 1 used in the sed commands
fport=$(shuf -i 20001-25000 -n 1)
while [[ "$(netstat -ln | grep ':'"$fport"'' | grep -c 'LISTEN')" -eq "1" ]]; do fport=$(shuf -i 20001-25000 -n 1); done
# qport is the query port: vport + 2 used in the sed commands
qport=$(shuf -i 25001-32001 -n 1)
while [[ "$(netstat -ln | grep ':'"$qport"'' | grep -c 'LISTEN')" -eq "1" ]]; do qport=$(shuf -i 25001-32001 -n 1); done
#
teamspeakfv="http://dl.4players.de/ts/releases/$teamspeakversion/teamspeak3-server_linux-amd64-$teamspeakversion.tar.gz"
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

cronjob () {
    # adding jobs to cron: Set the variable tmpcron to a randomly generated temporary file.
    tmpcron="$(mktemp)"
    # Check if the job exists already by grepping whatever is between ^$
    if [[ "$(crontab -l 2> /dev/null | grep -oc '^#This is an example crontab entry from an install.script$')" == "0" ]]
    then
        # sometimes the cronjob will be to run a custom script generated by the installer, located in the directory ~/.cronjobs
        mkdir -p ~/.cronjobs/logs
        echo "Appending application to crontab."
        crontab -l 2> /dev/null > "$tmpcron"
        echo "#This is an example crontab entry from a install.script" >> "$tmpcron"
        crontab "$tmpcron"
        rm "$tmpcron"
    else
        echo "Some Job is already in crontab"
    fi
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
    echo -e "You should create an issue directly on github using your github account."
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
# Checks for the positional parameters $1 and $2 to be reset if the script is updated.
[[ ! -z "$1" && "$1" != 'qr' ]] || [[ ! -z "$2" && "$2" != 'qr' ]] && echo -en "$1\n$2" > ~/.passparams
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
[[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]] && echo -n '' > ~/.quickrun
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z "$1" && "$1" = 'nu' ]] || [[ ! -z "$2" && "$2" = 'nu' ]]; then
    scriptversion="$scriptversion-nu"
    echo -e "\nThe Updater has been temporarily disabled\n"
else
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq "1" ]]; then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        wget -qO ~/.000"$scriptname" "$scripturl"
        if [[ "$(sha256sum ~/.000"$scriptname" | awk '{print $1}')" != "$(sha256sum ~/bin/"$scriptname" | awk '{print $1}')" ]]; then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname" && bash ~/.111"$scriptname"; exit
        else
            if [[ -z "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" && "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" -ne "$$" ]]; then
                echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname" && bash ~/.222"$scriptname"; exit
            fi
        fi
        cd && rm -f .{000,111,222}"$scriptname" && chmod -f 700 ~/bin/"$scriptname"
        echo
    else
        scriptversion="$scriptversion-DEV"
        echo -e "\nThe Updater has been disabled\n"
    fi
fi
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
[[ -f ~/.quickrun ]] && updatestatus="y"; rm -f ~/.quickrun
# resets the positional parameters $1 and $2 post update.
[[ -f ~/.passparams ]] && set "$1" "$(sed -n '1p' ~/.passparams)" && set "$2" "$(sed -n '2p' ~/.passparams)"; rm -f ~/.passparams
#
############################
##### Self Updater End #####
############################
#
############################
## Positional Param Start ##
############################
#
if [[ ! -z "$1" && "$1" = "example" ]]
then
    echo
    #
    # Edit below this line
    #
    echo "Add your custom positional parameters in this section."
    #
    if [[ -n "$2" ]]
    then
        echo "You used $scriptname $1 $2 when calling this example"
    fi
    #
    # Edit above this line
    #
    echo
    exit
fi
#
############################
### Positional Param End ###
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
    cd && bash
    exit
fi
#
############################
##### Core Script Ends #####
############################
#