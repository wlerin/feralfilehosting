#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomessence 
#
# Script Contributors: none
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/rsynctk http://git.io/ikae7Q && bash ~/rsynctk
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
if [[ ! -z $1 && $1 == 'changelog' ]]; then echo
    #
    echo 'v1.1.8 updated template and removed whatbox section. Feral internal only.' 
    echo 'v1.1.7 commands echoed to text file.' 
    echo 'v1.1.6 Feral interanal connection tweaks'
    echo 'v1.1.5 scriptname typo fixed. Removal of ~/bin/rysnc if it is matches certain tests. Credits: Thanks to ozymandias for pointing this out.' 
    echo 'v1.1.4 allows the use of paths with spaces in the custom and screen command' 
    echo 'v1.1.3 custom destination is created incase it is a nested location and other small tweaks' 
    echo 'v1.1.2 Option to select custom destination. Default is ~/rsync' 
    echo 'v1.1.1 some visual tweaks and clearer echoes'            
    echo 'v1.0.8 users can run a feral or whatbox version of the script.'
    echo 'v1.0.7 screen .... -p 0 was the secret sauce. Otherwise you need to be attached to the screen for the command to work'
    echo 'v1.0.6 removed partials'
    echo 'v1.0.5 screen exec'
    echo 'v1.0.3 echoes with custom commands'
    echo 'v1.0.2 various bug fixes, typos and general visual layout'
    echo 'v1.0.0 Should be a working, functional script'
    echo 'v0.0.9 script renamed to rsynctk to avoid conflict with rsync itself.'
    echo 'v0.0.8 beta'
    echo 'v0.0.1 Initial Version'
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
scriptversion="1.1.8"
#
# Script name goes here. Please prefix with install for an installation script. For a utility script just give it a useful name.
scriptname="rsynctk"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="none"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/ikae7Q"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Linux%20Command-Line%20-%20Advanced/rsync%20-%20Transferring%20data%20from%20slot%20to%20slot/scripts/rsynctk.sh"
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
############################
## Custom Variables Start ##
############################
#
mish="$(shuf -i 1-100 -n 1)"
defaultpath="rsync"
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
    echo -e "\033[32m""Script Information and usage instructions:""\e[0m"
    echo
    #
    ###################################
    #### Custom Script Notes Start ####
    ###################################
    #
    echo "1: Guide you through the process of forming your Feral internal transfer command."
    echo "2: Present your with a fully formed command that you can use when you are ready."
    echo "3: Offer to start the transfer in a screen session. Certain prerequisite steps must be completed via the script."
    #
    ###################################
    ##### Custom Script Notes End #####
    ###################################
    #
    echo
    echo -e "\033[32m""Script options:""\e[0m"
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
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, whihc woudl reset the option, it will then find this file and set it back.
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
    mkdir -p "$HOME/rsync"
    echo -e "\033[32m""Give the username of the feral account that controls the slot""\e[0m"
    read -ep " What is your username on the old slot? : " username
    echo
    echo -e "\033[32m""Example, if your server is" "\033[31m""hypnos.feralhosting.com" "\033[32m""then" "\033[33m""hypnos" "\033[32m""is the server name""\e[0m"
    read -ep " What is the server name of the slot with your files? : " servername
    echo
    echo -e "\033[31m""IMPORTANT INFO : Please read these comments.""\e[0m"
    echo
    echo -e "\033[32m""Path ends with" "\033[36m""/""\e[0m" "\033[32m""= will copy the all contents of this folder to into" "\033[36m""~/rsync""\e[0m"
    echo -e "\033[33m""Path does not end with" "\033[36m""/""\e[0m" "\033[33m""= the folder you link to and its contents will be copied into" "\033[36m""~/rsync""\e[0m"
    echo
    echo -e "So" "\033[36m""private/rtorrent/""\e[0m" "will copy all the content of the" "\033[36m""rtorrent""\e[0m" "to" "\033[36m""~/rsync/<contents of directory>""\e[0m"
    echo -e "So" "\033[36m""private/rtorrent""\e[0m" "will copy the" "\033[36m""rtorrent""\e[0m" "directory itself to" "\033[36m""~/rsync/rtorrent/<contents of directory>""\e[0m"
    echo -e "\033[33m""Here is a good webpage with examples:""\e[0m" "http://tinyurl.com/nejatwy"
    echo
    read -ep "Are you sure you have understood [y] or do you want to double check [n] : " confirm
    echo
    if [[ "$confirm" =~ ^[Yy]$ ]]
    then
        read -ep "Please enter the relative path to the folder you wish to copy: \$HOME/" remotepath
        echo
        read -ep "Would you like to select a custom destination for your files? [y]es or [n]o: " customdest
        echo
        if [[ "$customdest" =~ ^[Yy]$ ]]
        then
            read -ep "Please enter the relative path to the custom destination folder: \$HOME/" defaultpath
            mkdir -p "$HOME/$defaultpath"
            echo
        fi
    else
        exit 1
    fi
    echo -e "\033[33m""Here is the command you have just created:""\e[0m"
    echo
    echo -e "\033[31m""rsync" "\033[32m"'-avhPSe "ssh -T -c arcfour -o Compression=no"' "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""'\"\$HOME/$remotepath\"'"  "\"\$HOME/$defaultpath\"""\e[0m"
    echo
    read -ep "Would you like to try and run this command in a screen [y] or exit now [e]: " confirmscreen1
    echo
    if [[ "$confirmscreen1" =~ ^[Yy]$ ]]
    then
        if [[ ! -f "$HOME/.ssh/rsynctk_rsa" ]]
        then
            ssh-keygen -q -t rsa -b 2048 -f "$HOME/.ssh/rsynctk_rsa" -N ''
        fi
        echo -e "Make sure you have copied the contents of the file:" "\033[36m""~/.ssh/rsynctk_rsa.pub""\e[0m" "we just generated, to your OLD slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "file."
        echo -e "\033[31m""We can do this while the script is loaded using SSH and the ssh-copy-id command if you have not already done it.""\e[0m"
        echo -e "\033[32m""If you say""\e[0m" "[Y]" "\033[32m""below , please then type" "\033[33m""yes""\e[0m" "\033[32m""in the next step to accept the other slots host key""\e[0m"
        echo
        read -ep "Would you like to do this now via SSH, your OLD slot's SSH password is required [y] or skip [n] : " sshcopy
        echo
        if [[ "$sshcopy" =~ ^[Yy]$ ]]
        then
            ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub "$username@$servername.feralhosting.com"
        fi
        read -ep "Have you copied the ~/.ssh/rsynctk_rsa.pub contents to your old slot's ~/.ssh/authorized_keys file [y] or [n] " confirmscreen2
        echo
        if [[ "$confirmscreen2" =~ ^[Yy]$ ]]
        then
            echo -e "\033[32m""I will now attempt to create a screen and start the proccess." "\033[31m""If you have not copied you public key it won't work.""\e[0m"
            #
            screen -dmS "rsynctk$mish"
            sleep 2
            screen -S "rsynctk$mish" -p 0 -X exec rsync -avhPSe "ssh -T -c arcfour -o Compression=no -i $HOME/.ssh/rsynctk_rsa" "$username"@"$servername".feralhosting.com:'"\$HOME/'"$remotepath"'"' "$HOME/$defaultpath"
            echo
            echo "Here is the screen process"
            echo
            screen -ls | grep "rsynctk$mish"
            echo
            echo -e "\033[31m""Useful Notes:""\e[0m"
            echo
            echo -e "The normal command, requires you create a screen an enter your old slot's SSH password"
            echo -e "\033[31m""rsync" "\033[32m"'-avhPSe "ssh -T -c arcfour -o Compression=no"' "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""'\"\$HOME/$remotepath\"'" "\"\$HOME/$defaultpath\"""\e[0m"
            echo -e 'rsync -avhPSe "ssh -T -c arcfour -o Compression=no" '"$username"'@'"$servername"'.feralhosting.com:'\''"$HOME/'"$remotepath"'"'\'' "$HOME/'"$defaultpath"'"' >> rysnc"$mish".txt
            echo
            echo -e "The command that uses our public/private key file pair."
            echo -e "\033[31m""rsync" "\033[32m"'-avhPSe "ssh -T -c arcfour -o Compression=no -i $HOME/.ssh/rsynctk_rsa"' "\033[35m""$username""\e[0m""@""\033[35m""$servername""\e[0m""\033[37m"".feralhosting.com:""\033[36m""'\"\$HOME/$remotepath\"'" "\"\$HOME/$defaultpath\"""\e[0m"
            echo -e 'rsync -avhPSe "ssh -T -c arcfour -o Compression=no -i $HOME/.ssh/rsynctk_rsa" '"$username"'@'"$servername"'.feralhosting.com:'\''"$HOME/'"$remotepath"'"'\'' "$HOME/'"$defaultpath"'"' >> rysnc"$mish".txt
            echo
            echo -e "\033[33m""The command to copy our public key to the old slot's" "\033[36m""~/.ssh/authorized_keys""\e[0m" "\033[33m""file.""\e[0m"
            echo -e "ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.feralhosting.com"
            echo -e "ssh-copy-id -i ~/.ssh/rsynctk_rsa.pub $username@$servername.feralhosting.com" >> rysnc"$mish".txt
            echo
            echo -e "Type:" "\033[33m""screen -r rsynctk$mish""\e[0m" "To attach to the screen"
            echo "screen -r rsynctk$mish" >> rysnc"$mish".txt
            echo
            echo -e 'Please see \033[33m~/rysnc-'"$mish"'.txt\e[0m for list of these custom commands.'
            echo
        fi
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
    exit
fi
#
############################
##### Core Script Ends #####
############################
#