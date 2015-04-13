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
# wget -qO ~/phpsettings http://git.io/hGdl && bash ~/phpsettings
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
    echo 'v1.0.7 - Template updated. nginx countdown timer'
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
scriptversion="1.0.6"
#
# Script name goes here. Please prefix with install.
scriptname="phpsettings"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/hGdl"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/PHP%20-%20modify%20settings/scripts/phpsettings.sh"
#
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]
do
    appport=$(shuf -i 10001-49999 -n 1)
done
#
############################
## Custom Variables Start ##
############################
#
# Menu options
option1="Install Apache php.ini"
option2="Install nginx php.ini"
option3="Reload Apache"
option4="Reload Nginx"
option5="Quit the Script"
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
    echo "This script will allow you to do these things:"
    echo "1: edit your php.ini an saves the changes in either Apache or nginx."
    echo "2: Apply some default mysql options for use with applications"
    echo "3: Reload your new changes after your have saved your modifications."
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
    showMenu () 
    {
            echo "1) $option1"
            echo "2) $option2"
            echo "3) $option3"
            echo "4) $option4"
            echo "5) $option5"
            echo
    }

    while [ 1 ]
    do
            showMenu
            read -e CHOICE
            echo
            case "$CHOICE" in
                    "1")
                            cp -f /etc/php5/apache2/php.ini ~/.apache2/php.ini
                            echo -n 'PHPINIDir "${HOME}/.apache2/php.ini"' > ~/.apache2/conf.d/php.conf
                            #
                            sed -i "s|mysql.default_socket =|mysql.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            sed -i "s|mysqli.default_socket =|mysqli.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            sed -i "s|pdo_mysql.default_socket=|pdo_mysql.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            #
                            /usr/sbin/apache2ctl -k graceful >/dev/null 2>&1
                            echo -e "\033[32m""Done""\e[0m"
                            echo
                            echo "The mysql, mysqli and pdo defaults sockets have also been set"
                            echo
                            sleep 2
                            ;;
                    "2")
                            if [[ -d ~/.nginx ]]
                            then
                                mv -f ~/.nginx/php/php.ini  ~/.nginx/php/php.ini.bak
                                cp -f /etc/php5/fpm/php.ini ~/.nginx/php/php.ini
                                #
                                sed -i "s|mysql.default_socket =|mysql.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                sed -i "s|mysqli.default_socket =|mysqli.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                sed -i "s|pdo_mysql.default_socket=|pdo_mysql.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                #
                                killall -u $(whoami) nginx php5-fpm >/dev/null 2>&1
                                echo "Waiting for nginx to reload. It loads every 5 minutes starting from 00 of the hour"
                                echo
                                #
                                if [[ "$(date +%-M)" -le '4' ]] && [[ "$(date +%-M)" -ge '0' ]]; then time="$(( 5 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '9' ]] && [[ "$(date +%-M)" -ge '5' ]]; then time="$(( 10 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '14' ]] && [[ "$(date +%-M)" -ge '10' ]]; then time="$(( 15 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '19' ]] && [[ "$(date +%-M)" -ge '15' ]]; then time="$(( 20 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '24' ]] && [[ "$(date +%-M)" -ge '20' ]]; then time="$(( 25 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '29' ]] && [[ "$(date +%-M)" -ge '25' ]]; then time="$(( 30 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '34' ]] && [[ "$(date +%-M)" -ge '30' ]]; then time="$(( 35 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '39' ]] && [[ "$(date +%-M)" -ge '35' ]]; then time="$(( 40 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '44' ]] && [[ "$(date +%-M)" -ge '40' ]]; then time="$(( 45 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '49' ]] && [[ "$(date +%-M)" -ge '45' ]]; then time="$(( 50 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '54' ]] && [[ "$(date +%-M)" -ge '50' ]]; then time="$(( 55 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '59' ]] && [[ "$(date +%-M)" -ge '55' ]]; then time="$(( 60 * 60 ))"; fi
                                #
                                while [[ ! -f ~/.nginx/php/pid ]]
                                do
                                    countdown="$(( $time-$(($(date +%-M) * 60 + $(date +%-S))) ))"
                                    printf '\rnginx will restart in approximately: %dm:%ds ' $(($countdown%3600/60)) $(($countdown%60))
                                done
                                echo -e '\n'
                                #
                                echo -e "nginx and php5-fpm have been reloaded by the system"
                                echo
                                echo -e "\033[32m""Done""\e[0m"
                                echo
                                echo "The mysql, mysqli and pdo defaults sockets have also been set"
                                echo
                            else
                                echo "nginx is not installed. Please update to nginx first."
                                echo
                                echo "Updating Apache to nginx - https://www.feralhosting.com/faq/view?question=231"
                                echo
                                sleep 2
                            fi
                            ;;
                    "3")
                            if [[ ! -d ~/.nginx ]]
                            then
                                /usr/sbin/apache2ctl -k graceful >/dev/null 2>&1
                                echo -e "\033[32m""Done""\e[0m"
                                echo
                                sleep 2
                            else
                                echo "nginx is installed. Please use option 4 instead."
                                echo
                                sleep 2
                            fi
                            ;;
                    "4")
                            if [[ -d ~/.nginx ]]
                            then
                                killall -u $(whoami) nginx php5-fpm >/dev/null 2>&1
                                echo "Waiting for nginx to reload. It loads every 5 minutes starting from 00 of the hour"
                                echo
                                #
                                if [[ "$(date +%-M)" -le '4' ]] && [[ "$(date +%-M)" -ge '0' ]]; then time="$(( 5 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '9' ]] && [[ "$(date +%-M)" -ge '5' ]]; then time="$(( 10 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '14' ]] && [[ "$(date +%-M)" -ge '10' ]]; then time="$(( 15 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '19' ]] && [[ "$(date +%-M)" -ge '15' ]]; then time="$(( 20 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '24' ]] && [[ "$(date +%-M)" -ge '20' ]]; then time="$(( 25 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '29' ]] && [[ "$(date +%-M)" -ge '25' ]]; then time="$(( 30 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '34' ]] && [[ "$(date +%-M)" -ge '30' ]]; then time="$(( 35 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '39' ]] && [[ "$(date +%-M)" -ge '35' ]]; then time="$(( 40 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '44' ]] && [[ "$(date +%-M)" -ge '40' ]]; then time="$(( 45 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '49' ]] && [[ "$(date +%-M)" -ge '45' ]]; then time="$(( 50 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '54' ]] && [[ "$(date +%-M)" -ge '50' ]]; then time="$(( 55 * 60 ))"; fi
                                if [[ "$(date +%-M)" -le '59' ]] && [[ "$(date +%-M)" -ge '55' ]]; then time="$(( 60 * 60 ))"; fi
                                #
                                while [[ ! -f ~/.nginx/php/pid ]]
                                do
                                    countdown="$(( $time-$(($(date +%-M) * 60 + $(date +%-S))) ))"
                                    printf '\rnginx will restart in approximately: %dm:%ds ' $(($countdown%3600/60)) $(($countdown%60))
                                done
                                echo -e '\n'
                                #
                                echo -e "nginx and php5-fpm have been reloaded by the system"
                                echo
                                echo -e "\033[32m""Done""\e[0m"
                                echo
                            else
                                echo "nginx is not installed. Please update to nginx first."
                                echo
                                echo "Updating Apache to nginx - https://www.feralhosting.com/faq/view?question=231"
                                echo
                                sleep 2
                            fi
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