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
# wget -qO ~/install.proftpd http://git.io/nQJBxw && bash ~/install.proftpd
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
# Don't forget to change the conf file variable size if the configurations are modified.
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
    #echo 'v0.1.0 - My changes go here'
    #echo 'v0.0.9 - My changes go here'
    echo 'v1.3.4 - proftpd-1.3.6'
    echo 'v1.3.3 - proftpd-1.3.5a'
    echo 'v1.3.2 - deleteuser option added'
    echo 'v1.3.1 - adduser custom filezilla profiles'
    echo 'v1.3.0 - even easier filezilla template.'
    echo 'v1.2.9 - filezilla importable templates generated during installation.'
    echo 'v1.2.7 - fixed broken if in adduser section.'
    echo 'v1.2.6 - merged adduser script into main script as a script option and tweaked script.'
    echo 'v1.2.5 - Automatic password generation. USer experience simplified. More useful information is shown.'
    echo 'v1.2.4 - Template updated'
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
scriptversion="1.3.4"
#
# Script name goes here. Please prefix with install.
scriptname="install.proftpd"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/nQJBxw"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/scripts/install.proftpd.sh"
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
makeissue=".makeissue $scriptname A description of the issue"
ticketurl="https://www.feralhosting.com/manager/tickets/new"
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
filezilla="http://git.io/vfAZ9"
#
proftpdversion="proftpd-1.3.6"
installedproftpdversion="$(cat $HOME/proftpd/.proftpdversion 2> /dev/null)"
#
proftpdconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/proftpd.conf"
proftpdconfsize="3796"
sftpconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/sftp.conf"
sftpconfsize="832"
ftpsconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/ftps.conf"
ftpsconfsize="940"
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/scripts/install.proftpd.sh"
#
proftpdurl="ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.6.tar.gz"
#
sftpport="$(shuf -i 10001-32001 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$sftpport"'' | grep -c 'LISTEN')" -eq "1" ]]; do sftpport="$(shuf -i 10001-32001 -n 1)"; done
#
ftpsport="$(shuf -i 10001-32001 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$ftpsport"'' | grep -c 'LISTEN')" -eq "1" ]]; do ftpsport="$(shuf -i 10001-32001 -n 1)"; done
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
remotepath () {
    path1="media"
    path2="$(echo $HOME | cut -d '/' -f3)"
    path3="$(echo $HOME | cut -d '/' -f4)"
    if [[ "$path3" = "home" ]]; then
        path3="home"
        path4="$(whoami)"
        echo "1 0 $(echo ${#path1}) $path1 $(echo ${#path2}) $path2 $(echo ${#path3}) $path3 $(echo ${#path4}) $path4"
    else
        path3="$(whoami)"
        echo "1 0 $(echo ${#path1}) $path1 $(echo ${#path2}) $path2 $(echo ${#path3}) $path3"
    fi
}
jailpath () {

    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f5)" ]] && path1="$(echo $HOME/$jailpath | cut -d '/' -f5)" || path1="nullanvoid"
    #
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f6)" ]] && path2="$(echo $HOME/$jailpath | cut -d '/' -f6)" || path2="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f7)" ]] && path3="$(echo $HOME/$jailpath | cut -d '/' -f7)" || path3="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f8)" ]] && path4="$(echo $HOME/$jailpath | cut -d '/' -f8)" || path4="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f9)" ]] && path5="$(echo $HOME/$jailpath | cut -d '/' -f9)" || path5="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f10)" ]] && path6="$(echo $HOME/$jailpath | cut -d '/' -f10)" || path6="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f11)" ]] && path7="$(echo $HOME/$jailpath | cut -d '/' -f11)" || path7="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f12)" ]] && path8="$(echo $HOME/$jailpath | cut -d '/' -f12)" || path8="nullanvoid"
    [[ -n "$(echo $HOME/$jailpath | cut -d '/' -f13)" ]] && path9="$(echo $HOME/$jailpath | cut -d '/' -f13)" || path9="nullanvoid"
    #
    echo "$(echo ${#path1}) $path1 $(echo ${#path2}) $path2 $(echo ${#path3}) $path3 $(echo ${#path4}) $path4 $(echo ${#path5}) $path6 $(echo ${#path6}) $path6 $(echo ${#path7}) $path7 $(echo ${#path8}) $path8 $(echo ${#path9}) $path9" | sed -r "s/ 10 nullanvoid//g"
}
#
filezillaxml () {
    mkdir -p ~/.proftpd-filezilla
    #
    filezillauser="$(whoami)"
    #
    wget -qO ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml "$filezilla"
    #
    sed -ri 's|HOSTNAME|'"$(hostname -f)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|DAEMONPORTSFTP|'"$sftpport"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|DAEMONPORTFTPS|'"$ftpsport"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|DAEMONPROTOCOLSFTP|1|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|DAEMONPROTOCOLFTPS|4|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|USERNAME|'"$filezillauser"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|PASSWORD|'"$(echo -n $apppass | base64)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|SERVERNAMESFTP|'"$filezillauser $(hostname) sftp"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|SERVERNAMEFTPS|'"$filezillauser $(hostname) ftps"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|REMOTEDIR|'"$(remotepath)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
}
#
filezillaxmladduser () {
    mkdir -p ~/.proftpd-filezilla
    #
    filezillauser="$name"
    #
    wget -qO ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml "$filezilla"
    #
    sed -ri 's|HOSTNAME|'"$(hostname -f)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|DAEMONPORTSFTP|'"$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/sftp.conf)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|DAEMONPORTFTPS|'"$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/ftps.conf)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|DAEMONPROTOCOLSFTP|1|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|DAEMONPROTOCOLFTPS|4|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|USERNAME|'"$filezillauser"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|PASSWORD|'"$(echo -n $apppass | base64)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|SERVERNAMESFTP|'"$filezillauser $(hostname) sftp"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    sed -ri 's|SERVERNAMEFTPS|'"$filezillauser $(hostname) ftps"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
    #
    sed -ri 's|REMOTEDIR|'"$(remotepath) $(jailpath)"'|g' ~/.proftpd-filezilla/"$filezillauser"."$(hostname -f)".xml
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
    echo -e "This script will complete Steps 1 to 6 from the proftpd FAQ. Continue the FAQ from Step 1."
    echo
    echo -e "\033[33m""proftpd is not started by this script so that you may configure your users and jails first""\e[0m"
    echo
    echo -e "Three read only jails that any valid user can access are configured by default, they are:"
    echo
    echo -e "1:""\033[36m"" ~/private/rtorrent/data""\e[0m" "2:""\033[36m"" ~/private/deluge/data""\e[0m" "3:""\033[36m"" ~/private/transmission/data""\e[0m"
    echo
    echo -e "\033[31m""Start Commands:""\e[0m"
    echo
    echo -e "Start SFTP: ""\033[36m""~/proftpd/sbin/proftpd -c ~/proftpd/etc/sftp.conf""\e[0m"
    echo
    echo -e "Start FTPS: ""\033[36m""~/proftpd/sbin/proftpd -c ~/proftpd/etc/ftps.conf""\e[0m"
    echo
    echo -e "\033[31m""Debugging Proftpd:""\e[0m"
    echo
    echo "If proftpd won't start use these commands to see the debugging inforamtion"
    echo
    echo -e "Debug SFTP: ""\033[36m""~/proftpd/sbin/proftpd -nd10 -c ~/proftpd/etc/sftp.conf""\e[0m"
    echo
    echo -e "Debug FTPS: ""\033[36m""~/proftpd/sbin/proftpd -nd10 -c ~/proftpd/etc/ftps.conf""\e[0m"
    echo
    echo -e "\033[33m""The proftpd deamon ports configured are:""\e[0m"
    echo
    echo -e "SFTP port = ""\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/sftp.conf)""\e[0m"
    echo
    echo -e "FTPS port = ""\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/ftps.conf)""\e[0m"
    echo
    echo -e "\033[31m""adduser script:""\e[0m"
    echo
    echo -e "\033[36madduser\e[0m = Uses the built in add user script to easily create and add a new user."
    echo
    echo -e "Example usage: \033[36m$scriptname adduser\e[0m or it will accept a username: \033[36m$scriptname adduser username\e[0m"
    echo
    echo -e "\033[31m""deleteuser script:""\e[0m"
    echo
    echo -e "\033[36mdeleteuser\e[0m = Uses the built in add user script to easily create and add a new user."
    echo
    echo -e "Example usage: \033[36m$scriptname deleteuser\e[0m or it will accept a username: \033[36m$scriptname deleteuser username\e[0m"
    echo
    echo -e "\033[31m""Filezilla Importable Templates:""\e[0m"
    echo
    echo "Filezilla site templates that you can import into Filezilla were generated in:"
    echo
    echo -e "\033[36m""~/.proftpd-filezilla/username.$(hostname -f).xml""\e[0m"
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
# Checks for the positional parameters $1 and $2 to be reset if the script is updated.
[[ ! -z "$1" && "$1" != 'qr' ]] || [[ ! -z "$2" && "$2" != 'qr' ]] && echo -en "$1\n$2" > ~/.passparams
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
[[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]] && echo -n '' > ~/.quickrun
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
[[ -f ~/.quickrun ]] && updatestatus="y"; rm -f ~/.quickrun
#
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
if [[ ! -z "$1" && "$1" = 'deleteuser' ]]
then
    if [[ -d ~/proftpd && -f ~/proftpd/bin/ftpasswd ]]
    then
    echo -e "\033[32m""Available users before:""\e[0m"
    echo
    echo -e "\033[33m""$(cat ~/proftpd/etc/ftpd.passwd | cut -d ':' -f1)""\e[0m"
    echo
    passwdfile="$HOME/proftpd/etc/ftpd.passwd"
    groupdfile="$HOME/proftpd/etc/ftpd.group"
    binarycmd="$HOME/proftpd/bin/ftpasswd"
    #
    if [ -n "$2" ]
    then
        echo -e "Using ""\033[32m""$2""\e[0m"" for name."
        name="$2"
        echo
    else
        read -ep "Please input username: " name
        echo
    fi
    "$binarycmd" --passwd --name="$name" --delete-user --file="$passwdfile"
    "$binarycmd" --group --name="$name" --delete-group --file="$groupdfile"
    #
    rm -f ~/.proftpd-filezilla/"$name"."$(hostname -f)".xml
    #
    echo
    echo -e "\033[32m""Available users after:""\e[0m"
    echo
    echo -e "\033[33m""$(cat ~/proftpd/etc/ftpd.passwd | cut -d ':' -f1)""\e[0m"
    echo
    echo "User deleted."
    echo
    exit
    fi
fi
#
if [[ ! -z "$1" && "$1" = 'adduser' ]]
then
    if [[ -d ~/proftpd && -f ~/proftpd/bin/ftpasswd ]]
    then
        #
        # Edit below this line
        #
        # made by finesse for feral hosting FAQ
        # use as you like
        # no warranties
        passwdfile="$HOME/proftpd/etc/ftpd.passwd"
        groupdfile="$HOME/proftpd/etc/ftpd.group"
        binarycmd="$HOME/proftpd/bin/ftpasswd"
        idcount=5001
        exec 6<&0
        exec 0<"$passwdfile"
        while read line1
        do
            foundid="$(echo $line1 |grep -o $idcount)"
            if [ -n "$foundid" ]
                then
                    idcount="$(expr $idcount + 1)"
            fi
        done
        exec 0<&6
        echo -e "Using" "\033[32m""$idcount""\e[0m" "for id's."
        echo
        if [ -n "$2" ]
        then
            echo -e "Using ""\033[32m""$2""\e[0m"" for name."
            name="$2"
            echo
        else
            read -ep "Please input username: " name
            echo
        fi
        echo -e "\033[32m""Do not include the""\e[0m" "\033[36m""~/""\e[0m" "\033[32m""in the path. Use paths that match existing Jails, relative to your Root directory, for example:""\e[0m"
        echo
        echo -e "\033[36m""private/rtorrent/data""\e[0m"
        echo
        echo -e "\033[33m""Use TAB to auto complete the path.""\e[0m"
        echo
        read -ep "Please specify a relative path to the users home/jail directory: ~/" -i "private/rtorrent/data" jailpath
        echo
        echo "$apppass" | "$binarycmd" --passwd --name="$name" --file="$passwdfile" --uid="$idcount" --gid="$idcount" --home="$HOME/$jailpath" --shell="/bin/false" --stdin >/dev/null 2>&1
        "$binarycmd" --group --name="$name" --file="$groupdfile" --gid="$idcount" --member="$name" >/dev/null 2>&1
        echo -e "The username is: ""\033[32m""$name""\e[0m"
        echo
        echo -e "The password is: ""\033[32m""$apppass""\e[0m"
        echo
        echo -e "The jail PATH is: ""\033[36m""$HOME/$jailpath""\e[0m"
        echo
        #
        # Edit above this line
        filezillaxmladduser
        echo "Filezilla site templates that you can import into Filezilla were generated in:"
        echo
        echo -e "\033[36m""~/.proftpd-filezilla/$name.$(hostname -f).xml""\e[0m"
        #
        echo
        exit
    else
        echo -e "\033[36m""~/proftpd/bin/ftpasswd""\e[0m"" not found. Is proftpd actually installed?"
        echo
        exit
    fi
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
    if [[ -d "$HOME/proftpd" ]]
    then
        if [[ -f "$HOME"/proftpd/.proftpdversion ]]
        then
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version $installedproftpdversion of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        else
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        fi
        if [[ "$agree2update" =~ ^[Yy]$ ]]
        then
            killall -9 -u "$(whoami)" proftpd >/dev/null 2>&1
            mkdir -p "$HOME"/proftpd/install_logs
            rm -rf ~/"$proftpdversion"{,.tar.gz}
            wget -qO ~/proftpd-1.3.6.tar.gz "$proftpdurl"
            tar xf ~/proftpd-1.3.6.tar.gz
            #
            [[ -z "$(grep -o '^ProcessTitles terse$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a ProcessTitles terse' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^IdentLookups off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a IdentLookups off' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^UseReverseDNS off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a UseReverseDNS off' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^AllowOverride off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a AllowOverride off' "$HOME"/proftpd/etc/proftpd.conf || :
            #
            echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
            cd "$HOME/$proftpdversion"
            echo "Starting to 1: configure, 2: make, 3 make install"
            echo
            install_user="$(whoami)" install_group="$(whoami)" ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
            echo "1: configure complete, moving to 2 of 3"
            make > "$HOME"/proftpd/install_logs/make.log 2>&1
            echo "2: make complete, moving to 3 of 3"
            make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
            echo "3: make install complete, moving to post installation configuration"
            echo
            "$HOME"/proftpd/bin/ftpasswd --group --name="$(whoami)" --file="$HOME/proftpd/etc/ftpd.group" --gid="$(id -g "$(whoami)")" --member="$(whoami)" >/dev/null 2>&1
            # Some tidy up
            rm -rf ~/"$proftpdversion"{,.tar.gz}
            chmod 440 ~/proftpd/etc/ftpd{.passwd,.group}
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/sftp.conf >/dev/null 2>&1
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/ftps.conf >/dev/null 2>&1
            echo -e "proftpd sftp and ftps servers were started."
            echo
            exit
        elif [[ "$agree2update" =~ ^[Rr]$ ]]
        then
            read -ep "Are you sure you want to do a full reinstall, all settings, jails and users will be lost? [y]es i am sure or [e]xit: " areyousure
            echo
            if [[ "$areyousure" =~ ^[Yy]$ ]]
            then
                killall -9 -u "$(whoami)" proftpd >/dev/null 2>&1
                rm -rf "$HOME"/proftpd >/dev/null 2>&1
            else
                echo "You chose to exit"
                echo
                exit
            fi
        else
            echo "You chose to exit"
            echo
            exit
        fi
    fi
    #
    mkdir -p "$HOME"/proftpd/etc/sftp/authorized_keys
    mkdir -p "$HOME"/proftpd/etc/keys
    mkdir -p "$HOME"/proftpd/{ssl,install_logs}
    wget -qO ~/proftpd-1.3.6.tar.gz "$proftpdurl"
    tar xf ~/proftpd-1.3.6.tar.gz
    #git clone -q "$proftpdurl"
    #chmod -R 700 "$HOME/$proftpdversion"
    echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
    cd "$HOME/$proftpdversion"
    echo -e "\033[33m""About to configure, make and install proftpd. This could take some time to complete. Be patient.""\e[0m"
    echo
    # configure and install
    echo "Starting to 1: configure, 2: make, 3 make install"
    echo
    install_user="$(whoami)" install_group="$(whoami)" ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
    echo "1: configure complete, moving to 2 of 3"
    make > "$HOME"/proftpd/install_logs/make.log 2>&1
    echo "2: make complete, moving to 3 of 3"
    make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
    echo "3: make install complete, moving to post installation configuration"
    echo
    # Some tidy up
    rm -rf ~/"$proftpdversion"{,.tar.gz}
    # Generate our keyfiles
    ssh-keygen -q -t rsa -f "$HOME"/proftpd/etc/keys/sftp_rsa -N '' && ssh-keygen -q -t dsa -f "$HOME"/proftpd/etc/keys/sftp_dsa -N ''
    openssl req -new -x509 -nodes -days 365 -subj '/C=GB/ST=none/L=none/CN=none' -newkey rsa:3072 -sha256 -keyout "$HOME"/proftpd/ssl/proftpd.key.pem -out "$HOME"/proftpd/ssl/proftpd.cert.pem >/dev/null 2>&1
    # Get the conf files from github and configure them for this user
    until [[ "$(stat -c %s ~/proftpd/etc/proftpd.conf 2> /dev/null)" -eq "$proftpdconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/proftpd.conf "$proftpdconf"
    done
    until [[ "$(stat -c %s ~/proftpd/etc/sftp.conf 2> /dev/null)" -eq "$sftpconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/sftp.conf "$sftpconf"
    done
    until [[ "$(stat -c %s ~/proftpd/etc/ftps.conf 2> /dev/null)" -eq "$ftpsconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/ftps.conf "$ftpsconf"
    done
    # proftpd.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|User my_username|User '"$(whoami)"'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|Group my_username|Group '"$(whoami)"'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|AllowUser my_username|AllowUser '"$(whoami)"'|g' "$HOME/proftpd/etc/proftpd.conf"
    # sftp.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/sftp.conf"
    sed -i 's|Port 23001|Port '"$sftpport"'|g' "$HOME/proftpd/etc/sftp.conf"
    # ftps.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/ftps.conf"
    sed -i 's|Port 23002|Port '"$ftpsport"'|g' "$HOME/proftpd/etc/ftps.conf"
    echo "$apppass" | "$HOME"/proftpd/bin/ftpasswd --passwd --name="$(whoami)" --file="$HOME/proftpd/etc/ftpd.passwd" --uid="$(id -u "$(whoami)")" --gid="$(id -g "$(whoami)")" --home="$HOME/" --shell="/bin/false" --stdin >/dev/null 2>&1
    "$HOME"/proftpd/bin/ftpasswd --group --name="$(whoami)" --file="$HOME/proftpd/etc/ftpd.group" --gid="$(id -g "$(whoami)")" --member="$(whoami)" >/dev/null 2>&1
    echo -e "\033[33m""You have completed the installtion. Please continue with the FAQ from Step 1 onwards.""\e[0m"
    echo
    echo -e "\033[31m""proftpd was NOT started to allow you to edit the jails in Step 2 of the FAQ as required.""\e[0m"
    echo
    echo -e "\033[33m""See Step 3 of the FAQ for how to start proftpd.""\e[0m"
    echo
    echo -e "\033[31m""FTPS/SFTP Connection Settings:""\e[0m"
    echo
    echo -e "This is your hostname: ""\033[32m""$(hostname -f)""\e[0m"
    echo
    echo -e "This is your" "\033[32m""SFTP""\e[0m" "port:" "\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/sftp.conf)""\e[0m"
    echo
    echo -e "This is your" "\033[32m""FTPS""\e[0m" "port:" "\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/ftps.conf)""\e[0m"
    echo
    echo -e "This is your main username: ""\033[32m""$(whoami)""\e[0m"" and this is your password: ""\033[32m""$apppass""\e[0m"
    #function
    filezillaxml
    echo
    echo "Filezilla site templates that you can import into Filezilla were generated in:"
    echo
    echo -e "\033[36m""~/.proftpd-filezilla/$(whoami).$(hostname -f).xml""\e[0m"
    echo
    echo -e "Use this command to see important information:" "\033[36m""$scriptname help""\e[0m"
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
    exit
fi
#
############################
##### Core Script Ends #####
############################
#
