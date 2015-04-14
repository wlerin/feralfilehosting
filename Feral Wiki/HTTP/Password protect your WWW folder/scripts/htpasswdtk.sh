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
# wget -qO ~/htpasswdtk http://git.io/eJySww && bash ~/htpasswdtk
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
    # put your version changes in the single quotes and then uncomment the line.
    #
    echo 'v1.1.4 template updated'
    echo 'v1.1.2 template updated'
    echo '1.1.1 nginx rcp specific options for default and multple instances. tweaked the way option 18 works.'
    echo '1.1.0 Changes to Authname generation to avoid conflict or allow single login'
    echo '1.0.5 multi rtorrent/rutorrent options'
    echo '1.0.4 nginx /links and apache /links options added'
    echo '1.0.3 Updater included.'
    echo '1.0.2 Better checks for option 1 with explanations on htaccess'
    echo '1.0.1 wgets itself and puts it in the ~/bin with 700. Added files exist checks for all htpasswd calls. Cosmetics'
    echo '1.0.0 A working and functional script.'
    echo 'v0.5.0 Main options created and refined producing a usable script'
    echo 'v0.0.1 - 0.0.1 Initial Version'
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
scriptversion="1.1.4"
#
# Script name goes here. Please prefix with install.
scriptname="htpasswdtk"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/eJySww"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Password%20protect%20your%20WWW%20folder/scripts/htpasswdtk.sh"
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
##
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
    echo -e "Put your instructions or script information here using echoes"
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
    echo -e "\033[32m""Hello $(whoami).""\e[0m" "This is the htpasswd user and password toolkit." "\e[0m"
    echo -e "\033[33m""This toolkit is designed to complement the FAQ and it is not a replacement for the FAQ""\e[0m"
    echo
    #
    showMenu () 
    {
        echo -e "\033[32m"".htpasswd options section""\e[0m"
        #
        echo -e "\033[31m""1""\e[0m" "Create a new" "\033[36m""~/private/.htpasswd""\e[0m" "and user only""\e[0m"
        #
        echo -e "\033[31m""2""\e[0m" "Create a new" "\033[36m""~/private/.htpasswd""\e[0m" "and user, and/or a .htaccess"
        #
        echo -e "\033[31m""3""\e[0m" "Add a new user or update an existing user in your" "\033[36m""~/private/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""4""\e[0m" "Delete a user from your" "\033[36m""~/private/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""5""\e[0m" "Protect the" "\033[36m""/links""\e[0m" "directory using" "\033[36m""~/private/.htpasswd""\e[0m"
        #   
        echo -e "\033[31m""6""\e[0m" "List" "\033[36m""~/private/.htpasswd""\e[0m" "users and their order"
        #
        echo -e "\033[32m""Rutorrent specific options section""\e[0m"
        #
        echo -e "\033[31m""7""\e[0m" "\033[1;30m""RuTorrent:""\e[0m" "Change the existing Rutorrent .htaccess to use" "\033[36m""~/private/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""8""\e[0m" "\033[1;30m""RuTorrent:""\e[0m" "Add or edit a user in the existing Rutorrent .htpasswd"
        #
        echo -e "\033[31m""9""\e[0m" "\033[1;30m""RuTorrent:""\e[0m" "Delete a user in the existing Rutorrent .htpasswd"
        #
        echo -e "\033[31m""10""\e[0m" "\033[1;30m""RuTorrent:""\e[0m" "Protect the" "\033[36m""/links""\e[0m" "directory using" "\033[36m""/rutorrent/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""11""\e[0m" "\033[1;30m""RuTorrent:""\e[0m" "List" "\033[36m""/rutorrent/.htpasswd""\e[0m" "users and their order"
        #
        echo -e "\033[32m""Other tools section""\e[0m"
        #
        echo -e "\033[31m""12""\e[0m" "Change all" "\033[36m""public_html""\e[0m" ".htaccess to use the" "\033[36m""~/private/.htpasswd""\e[0m" "AuthFile path" "\033[33m""(if present)""\e[0m"
        #
        echo -e "\033[31m""13""\e[0m" "Change all" "\033[36m""public_html""\e[0m" ".htaccess to use the" "\033[36m""/rutorrent/.htpasswd""\e[0m" "AuthFile path" "\033[33m""(if present)""\e[0m"
        #
        echo -e "\033[31m""14""\e[0m" "Change all" "\033[36m""public_html""\e[0m" ".htaccess to use a custom AuthFile path" "\033[33m""(if present)""\e[0m"
        #
        echo -e "\033[32m""Nginx specific options section""\e[0m"
        #
        echo -e "\033[31m""15""\e[0m" "Protect the" "\033[36m""/links""\e[0m" "directory using the" "\033[36m""~/private/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""16""\e[0m" "Protect the" "\033[36m""/links""\e[0m" "directory using the" "\033[36m""/rutorrent/.htpasswd""\e[0m"
        #
        echo -e "\033[31m""17""\e[0m" "Change the rpc password only for the user \"rutorrent\" linked to your default rutorrent installation"
        #
        echo -e "\033[32m""Multi Rtorrent/Rutorrent specific options section""\e[0m"
        #
        echo -e "\033[31m""18""\e[0m" "\033[1;30m""Multi Rtorrent/Rutorrent:""\e[0m" "Add or edit a user in the existing Rutorrent-suffix .htpasswd/nginx rpc"
        #
        echo -e "\033[31m""19""\e[0m" "\033[1;30m""Multi Rtorrent/Rutorrent:""\e[0m" "Delete a user in the existing Rutorrent .htpasswd"
        #
        echo -e "\033[31m""20""\e[0m" "\033[1;30m""Multi Rtorrent/Rutorrent:""\e[0m" "List" "\033[36m""/rutorrent/.htpasswd""\e[0m" "users and their order"
        #
        echo -e "\033[31m""21""\e[0m" "Change the rpc password only for the user \"rutorrent\" on the specified instance"
        #
        echo -e "\033[31m""22""\e[0m" "\033[32m""Quit""\e[0m"
    }
    ###
    #
    ###### Start of functions attached to menu items
    while [ 1 ]
        do
            showMenu
            echo
            read -ep "Enter the number of the action you wish to complete: " CHOICE
            echo
            case "$CHOICE" in
    ##########
            "1") # Create a new ~/private/.htpasswd and user only
            if [[ ! -f $HOME/private/.htpasswd ]]
            then
                    echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage secure passwords." "\e[0m"
                    read -ep "What is the username you wish to create?: " username
                    htpasswd -cm $HOME/private/.htpasswd $username
                    chmod 600 $HOME/private/.htpasswd
                    echo "The .htpasswd file was created and the user: $username added"
                    sleep 2
            else
                echo -e "\033[31m""The ~/private/.htpasswd exists.""\e[0m"
                read -ep "Do you wish overwrite it? [y] yes or [n] no: " confirm
                if [[ $confirm =~ ^[Yy]$ ]]
                then
                    echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage secure passwords." "\e[0m"
                    read -ep "What is the username you wish to create?: " username
                    htpasswd -cm $HOME/private/.htpasswd $username
                    chmod 600 $HOME/private/.htpasswd
                    echo "The .htpasswd file was created and the user: $username added"
                    sleep 2
                fi
            fi
            ;;
    ##########
            "2") # Create a new ~/private/.htpasswd,user and .htaccess.
            if [[ ! -f $HOME/private/.htpasswd ]]
            then
                echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage secure passwords." "\e[0m"
                echo -e "\033[33m""Note: This will append/add the settings if a .htaccess already exists in the web server root""\e[0m"
                read -ep "What is the username you wish to create?: " username
                htpasswd -cm $HOME/private/.htpasswd $username
                chmod 644 $HOME/private/.htpasswd
                echo
                echo -e "The" "\033[36m"".htpasswd""\e[0m" "file was created and the user" "\033[32m""$username""\e[0m" "added"
                echo
                # htaccess generation
                echo -e "\033[31m""If no custom location is given then it will be created in the WWW root""\e[0m"
                read -ep "Would you like to create the .htaccess in a specific location? [y] yes or [n] no: " specificloc
                echo
                if [[ $specificloc =~ ^[Yy]$ ]]
                then
                    echo -e "\033[32m""This path is relative to your WWW root. For links you would enter this path:""\e[0m" "\033[36m""/links""\e[0m"
                    read -ep "Give the name of the folder you with to create the .htaccess in: /" specificlocpath
                    echo
                    if [[ -d $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath ]]
                    then
                        if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess ]]
                        then
                            if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess)" ]]
                            then
                                echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                                find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                                echo
                                echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                echo
                                sleep 2
                            else
                                echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                                sleep 2
                                echo
                            fi
                        else
                            echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                            find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                            echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                            echo
                                echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                echo
                            sleep 2
                        fi
                    else
                        echo -e "\033[31m""This location does not exist.""\e[0m" "Please create the directory first"
                        echo
                        sleep 2
                    fi
                else
                    if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess ]]
                    then
                        if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess)" ]]
                        then
                            echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                            find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                            echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                            echo
                            echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                            echo
                            sleep 2
                        else
                            echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                            sleep 2
                            echo
                        fi
                    else
                        echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                        echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                        echo
                        echo -e "\033[32m""To make a directory user specific: Copy the .htaccess there, change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                        echo
                        sleep 2
                    fi
                fi
                # htaccess generation end
            else
                echo -e "\033[31m""The ~/private/.htpasswd exists.""\e[0m" 
                read -ep "Do you wish overwrite it? [y] yes or [n] no: " confirm
                if [[ $confirm =~ ^[Yy]$ ]]
                then
                    echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage secure passwords." "\e[0m"
                    echo -e "\033[33m""Note: This will append/add the settings if a .htaccess already exists in the web server root""\e[0m"
                    read -ep "What is the username you wish to create?: " username
                    htpasswd -cm $HOME/private/.htpasswd $username
                    chmod 644 $HOME/private/.htpasswd
                    echo
                    echo -e "The" "\033[36m"".htpasswd""\e[0m" "file was created and the user" "\033[32m""$username""\e[0m" "added"
                    echo
                # htaccess generation
                echo -e "\033[31m""If no custom location is given then it will be created in the WWW root""\e[0m"
                read -ep "Would you like to create the .htaccess in a specific location? [y] yes or [n] no: " specificloc
                echo
                if [[ $specificloc =~ ^[Yy]$ ]]
                then
                    echo -e "\033[32m""This path is relative to your WWW root. For links you would enter this path:""\e[0m" "\033[36m""/links""\e[0m"
                    read -ep "Give the name of the folder you with to create the .htaccess in: /" specificlocpath
                    echo
                    if [[ -d $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath ]]
                    then
                        if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess ]]
                        then
                            if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess)" ]]
                            then
                                echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                                find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                                echo
                                echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                echo
                                sleep 2
                            else
                                echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                                sleep 2
                                echo
                            fi
                        else
                            echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                            find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                            echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                            echo
                                echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                echo
                            sleep 2
                        fi
                    else
                        echo -e "\033[31m""This location does not exist.""\e[0m" "Please create the directory first"
                        echo
                        sleep 2
                    fi
                else
                    if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess ]]
                    then
                        if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess)" ]]
                        then
                            echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                            find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                            echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                            echo
                            echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                            echo
                            sleep 2
                        else
                            echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                            sleep 2
                            echo
                        fi
                    else
                        echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                        echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                        echo
                        echo -e "\033[32m""To make a directory user specific: Copy the .htaccess there, change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                        echo
                        sleep 2
                    fi
                fi
                # htaccess generation end
                else
                    read -ep "Would you like to just generate the .htaccess? [y] yes or [n] no: " justdoit
                    if [[ $justdoit =~ ^[Yy]$ ]]
                    then
                        # htaccess generation
                        echo -e "\033[31m""If no custom location is given then it will be created in the WWW root""\e[0m"
                        read -ep "Would you like to create the .htaccess in a specific location? [y] yes or [n] no: " specificloc
                        echo
                        if [[ $specificloc =~ ^[Yy]$ ]]
                        then
                            echo -e "\033[32m""This path is relative to your WWW root. For links you would enter this path:""\e[0m" "\033[36m""/links""\e[0m"
                            read -ep "Give the name of the folder you with to create the .htaccess in: /" specificlocpath
                            echo
                            if [[ -d $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath ]]
                            then
                                if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess ]]
                                then
                                    if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess)" ]]
                                    then
                                        echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                        echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                                        echo
                                        echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                        echo
                                        sleep 2
                                    else
                                        echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                                        sleep 2
                                        echo
                                    fi
                                else
                                    echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/$specificlocpath/.htaccess
                                    find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                    echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in" "\033[36m""/$specificlocpath""\e[0m"
                                    echo
                                        echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                        echo
                                    sleep 2
                                fi
                            else
                                echo -e "\033[31m""This location does not exist.""\e[0m" "Please create the directory first"
                                echo
                                sleep 2
                            fi
                        else
                            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess ]]
                            then
                                if [[ -z "$(sed -n '/AuthName "Please Login"/p' $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess)" ]]
                                then
                                    echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                                    find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                    echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                                    echo
                                    echo -e "\033[32m""To make a directory user specific: Change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                    echo
                                    sleep 2
                                else
                                    echo -e "This" "\033[36m"".htaccess""\e[0m" "already has a Authfile entry."
                                    sleep 2
                                    echo
                                fi
                            else
                                echo -e "\n######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" >> $HOME/www/$(whoami).$(hostname -f)/public_html/.htaccess
                                find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec chmod 644 {} \;
                                echo -e "The" "\033[36m"".htaccess""\e[0m" "file was created or updated in the" "\033[36m""WWW""\e[0m" "root"
                                echo
                                echo -e "\033[32m""To make a directory user specific: Copy the .htaccess there, change:""\e[0m" "\033[33m""Require valid-user""\e[0m" "\033[32m""to""\e[0m" "\033[33m""Require user $username""\e[0m"
                                echo
                                sleep 2
                            fi
                        fi
                        # htaccess generation end
                    fi
                fi
            fi
            ;;
    ##########
            "3") # Add a new user or update an existing user, in your ~/private/.htpasswd
            if [[ -f $HOME/private/.htpasswd ]]
            then
                echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage good passwords.""\e[0m"
                echo -e "\033[31m""Enter an existing username to update, or a new username to create an entry.""\e[0m"
                echo
                echo -e "Here is a list of the usernames and their order in your" "\033[36m""$HOME/private/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/private/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                read -ep "What is the username you wish to create, if they are not listed above, or edit if they exist?: " username
                htpasswd -m $HOME/private/.htpasswd $username
                sleep 3
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Use option 1 first""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "4") # Delete a user from your ~/private/.htpasswd
            if [[ -f $HOME/private/.htpasswd ]]
            then
                echo -e "Here is a list of the usernames and their order in your" "\033[36m""$HOME/private/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/private/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                echo -e "Enter username from the list to delete them."
                read -ep "What is the username you wish to remove?: " username
                htpasswd -D $HOME/private/.htpasswd $username
                find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "/user $username/d" {} \; -exec chmod 644 {} \;
                echo
                echo -e "The user:""\033[31m""$username""\e[0m" "was deleted from all .htaccess files, if present"
                sleep 3
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Use option 1 first""\e[0m"
                sleep 2
            fi
                
            ;;
    ##########
            "5") # Protect the /links directory using ~/private/.htpasswd
            if [[ -d $HOME/www/$(whoami).$(hostname -f)/public_html/links ]]
            then
                echo -e "######\nAuthUserFile \"$HOME/private/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"Please Login\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" > $HOME/www/$(whoami).$(hostname -f)/public_html/links/.htaccess
                echo -e "The" "\033[36m""/links""\e[0m" "directory has been protected using the" "\033[36m""~/private/.htpasswd""\e[0m"
            else
                echo -e "The" "\033[36m""$HOME/www/$(whoami).$(hostname -f)/public_html/links""\e[0m" "does not exist"
            fi
            sleep 2
            ;;
    ##########
            "6") # List ~/private/.htpasswd users and their order
            if [ -f $HOME/private/.htpasswd ]
            then
                echo -e "Here is a list of the usernames and their order in your" "\033[36m""$HOME/private/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/private/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                sleep 4
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Use option 1 first""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "7") # RuTorrent: Change the existing Rutorrent .htaccess to use ~/private/.htpasswd
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htaccess ]]
            then
                echo -e "\033[32m""This will change where the rutorrent htaccess looks for the htpasswd file""\e[0m"
                read -ep "Are you sure you want to change this [y] or quit back to the menu [q] : " confirm
                if [[ $confirm =~ ^[Yy]$ ]]; then
                    sed -i "s|AuthUserFile .*|AuthUserFile \"$HOME/private/.htpasswd\"|g" $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htaccess
                    sed -i "s|AuthName .*|AuthName \"Please Login\"|g" $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htaccess
                    echo -e "The path has been changed to:" "\033[36m""$HOME/private/.htpasswd""\e[0m"
                    sleep 2
                fi
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "8") # RuTorrent: Add or edit a user in the existing Rutorrent .htpasswd
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd ]]
            then
                echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage good passwords.""\e[0m"
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rutorrent/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                echo -e "\033[33m""Enter an existing username to update or a new one to create an entry.""\e[0m"
                read -ep "What is the username you wish to create, if they are not listed above, or edit if they exist?: " username
                htpasswd -m $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd $username
                sleep 2
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "9") # RuTorrent: Delete a user in the existing Rutorrent .htpasswd
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd ]]
            then
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rutorrent/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                echo -e "\033[33m""Enter username from the list to delete them.""\e[0m"
                read -ep "What is the username you wish to remove?: " username
                htpasswd -D $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd $username
                sleep 2
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "10") #RuTorrent: Protect the /links directory using /rutorrent/.htpasswd
            if [[ -d $HOME/www/$(whoami).$(hostname -f)/public_html/links ]]
            then
                echo -e "######\nAuthUserFile \"$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd\"\nAuthGroupFile /dev/null\nAuthName \"$(whoami)\"\nAuthType Basic\n#####\nRequire valid-user\n####\nSatisfy All\n###" > $HOME/www/$(whoami).$(hostname -f)/public_html/links/.htaccess
                echo -e "The" "\033[36m""/links""\e[0m" "directory has been protected using the" "\033[36m""/rutorrent/.htpasswd""\e[0m"
            else
                echo -e "The" "\033[36m""$HOME/www/$(whoami).$(hostname -f)/public_html/links""\e[0m" "does not exist"
            fi
            sleep 2
            ;;
    ##########
            "11") # RuTorrent: List .htpasswd users and their order
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd ]]
            then
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rutorrent/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                sleep 4
            else
                echo -e "\033[31m" "The file does not exist." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "12") # Change all public_html .htaccess to use the ~/private/.htpasswd AuthFile path (if present)
                echo -e "\033[31m""Warning: This will edit EVERY" "\033[36m"".htaccess""\e[0m" "\033[31m""in your WWW""\e[0m"
                echo -e "This will change all" "\033[31m"".htaccess""\e[0m" "files AuthFile line if it is present"
                read -ep "Do you wish to do this? [y] yes or [n] no: " confirm
                echo
                if [[ $confirm =~ ^[Yy]$ ]]
                then
                    if [[ -f $HOME/private/.htpasswd ]]
                    then
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthUserFile .*|AuthUserFile \"$HOME/private/.htpasswd\"|g" {} \; -exec chmod 644 {} \;
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthName .*|AuthName \"Please Login\"|g" {} \; -exec chmod 644 {} \;
                        echo "Job done."
                        sleep 2
                    else
                        echo "The file does not exist. Make sure the path is correct"
                        sleep 2
                    fi
                fi
            ;;
    ##########
            "13") # Change all public_html .htaccess to use the ~/rutorrent/.htpasswd AuthFile path (if present)
                echo -e "\033[31m""Warning: This will edit EVERY" "\033[36m"".htaccess""\e[0m" "\033[31m""in your WWW""\e[0m"
                echo -e "This will change all" "\033[31m"".htaccess""\e[0m" "files AuthFile line if it is present"
                read -ep "Do you wish to do this? [y] yes or [n] no: " confirm
                echo
                if [[ $confirm =~ ^[Yy]$ ]]
                then
                    if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd ]]
                    then
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthUserFile .*|AuthUserFile \"$HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd\"|g" {} \; -exec chmod 644 {} \;
                        find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthName .*|AuthName \"$(whoami)\"|g" {} \; -exec chmod 644 {} \;
                        echo "Job done."
                        sleep 2
                    else
                        echo "The file does not exist. Make sure the path is correct"
                        sleep 2
                    fi
                fi
            ;;
    ##########
            "14") # Change all public_html .htaccess to use a custom AuthFile path (if present)
                echo -e "\033[31m""Warning: This will edit EVERY" "\033[36m"".htaccess""\e[0m" "\033[31m""in your WWW""\e[0m"
                echo -e "Please include" "\033[31m"".htpasswd""\e[0m" "in your path"
                echo -e "For example" "\033[31m""private/.htpasswd""\e[0m" "will work"
                read -ep "Please enter the relative path to your .htpasswd: ~/" path
                echo
                if [[ -f $HOME/$path ]]
                then
                    find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthUserFile .*|AuthUserFile \"$HOME/$path\"|g" {} \; -exec chmod 644 {} \;
                    find $HOME/www/$(whoami).$(hostname -f)/public_html -type f -name ".htaccess" -exec sed -i "s|AuthName .*|AuthName \"Please Login\"|g" {} \; -exec chmod 644 {} \;
                    echo "Job done."
                    sleep 2
                else
                    echo "The file ~/$path does not exist. Make sure the path is correct"
                    sleep 2
                fi
            ;;
    ##########
            "15") # Protect the /links directory using the ~/private/.htpasswd
            if [[ -f ~/private/.htpasswd && -d ~/.nginx/conf.d  ]]
            then
            echo -e 'location /links {\n    auth_basic "Please log in";\n    auth_basic_user_file '$HOME'/private/.htpasswd;\n}' > ~/.nginx/conf.d/000-default-server.d/links.conf
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            echo "Done. You may need to clear your browser cache to see the changes"
            echo
            sleep 2
            else
                echo -e "\033[31m""required files and the folder" "\033[36m""~/.nginx/conf.d""\e[0m" "\033[31m""do not exist""\e[0m"
                echo
                sleep 2
            fi
            ;;
    ##########
            "16") # Protect the /links directory using the /rutorrent/.htpasswd
            if [[ -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/.htpasswd && -d ~/.nginx/conf.d ]]
            then
            echo -e 'location /links {\n    auth_basic "'$(whoami)'";\n    auth_basic_user_file '$HOME'/www/'$(whoami)'.'$(hostname -f)'/public_html/rutorrent/.htpasswd;\n}' > ~/.nginx/conf.d/000-default-server.d/links.conf
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            echo "Done. You may need to clear your browser cache to see the changes"
            echo
            sleep 2
            else
                echo -e "\033[31m""required files and the folder" "\033[36m""~/.nginx/conf.d""\e[0m" "\033[31m""do not exist""\e[0m"
                echo
                sleep 2
            fi
            ;;
    ##########
            "17") # change the rpc password for the user rutorrent
            if [[ -f ~/.nginx/conf.d/000-default-server.d/scgi-htpasswd ]]
            then
                htpasswd -m $HOME/.nginx/conf.d/000-default-server.d/scgi-htpasswd rutorrent
                sed -ri '/^rutorrent:(.*)/! s/(.*)//g' ~/.nginx/conf.d/000-default-server.d/scgi-htpasswd
                sed -ri '/^$/d' ~/.nginx/conf.d/000-default-server.d/scgi-htpasswd
                echo
                sleep 2
            else
                echo -e "\033[31m""required file " "\033[36m""~/.nginx/conf.d/000-default-server.d/scgi-htpasswd""\e[0m" "\033[31m""does not exist""\e[0m"
                echo -e "Make sure rutorrent is installed and you have then updated to nginx"
                echo
                sleep 2
            fi
            ;;
    ##########
            "18") # Multi Rtorrent/RuTorrent: Add or edit a user in the existing Rutorrent .htpasswd
            echo -e "Where you have" "\033[32m""rutorrent-4""\e[0m" "then" "\033[31m""4""\e[0m" "is the suffix."
            read -ep "Please state the suffix of the instance you wish to modify: " suffix
            echo
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd ]]
            then
                echo -e "\033[1;32m""Note: Use a good password manager like keepass so you can easily manage good passwords.""\e[0m"
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rutorrent-$suffix/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                echo -e "\033[33m""Enter an existing username to update or a new one to create an entry.""\e[0m"
                read -ep "What is the username you wish to create, if they are not listed above, or edit if they exist?: " username
                htpasswd -m $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd $username
                echo
                read -ep "Do you want to use this user's password for the rpc: [y]es or [n]o ?" rpcchoice
                if [[ $rpcchoice =~ ^[Yy]$ ]]
                then
                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                    then
                        if [[ -s $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd ]]
                        then
                            cp -f ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                            sed -ri "s/$username:(.*)/rutorrent:\1/g" ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                            sed -ri '/^rutorrent:(.*)/! s/(.*)//g' ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                            sed -ri '/^$/d' ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                            echo -e "This user's password has been used for the" "\033[36m""/rutorrent-$suffix/rpc""\e[0m"
                            echo
                            sleep 2
                        else
                            echo "The rutorrent-$suffix htpasswd is empty. Re run option 18 to create a user first."
                            echo
                            sleep 2
                        fi
                    else
                        echo "nginx is not installed. You will have to update to nginx first."
                    fi
                fi
                sleep 2
            else
                echo -e "\033[31m" "The file does not exist at rutorrent-$suffix." "\033[32m""Check the suffix was correct""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "19") # Multi Rtorrent/RuTorrent: Delete a user in the existing Rutorrent .htpasswd
            echo -e "Where you have" "\033[32m""rutorrent-4""\e[0m" "then" "\033[31m""4""\e[0m" "is the suffix."
            read -ep "Please state the suffix of the instance you wish to modify: " suffix
            echo
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd ]]
            then
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rutorrent-$suffix/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                echo -e "\033[33m""Enter username from the list to delete them.""\e[0m"
                read -ep "What is the username you wish to remove?: " username
                htpasswd -D $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd $username
                sleep 2
            else
                echo -e "\033[31m" "The file does not exist at rutorrent-$suffix." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "20") # Multi Rtorrent/RuTorrent: List .htpasswd users and their order
            echo -e "Where you have" "\033[32m""rutorrent-4""\e[0m" "then" "\033[31m""4""\e[0m" "is the suffix."
            read -ep "Please state the suffix of the instance you wish to modify: " suffix
            echo
            if [[ -f $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd ]]
            then
                echo -e "\033[32m""Here is a list of the usernames and their order in your" "\033[36m""/rtorrent-$suffix/.htpasswd""\e[0m"
                echo -e "\033[1;31m"
                cat $HOME/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix/.htpasswd | cut -d: -f1
                echo -e "\e[0m"
                sleep 4
            else
                echo -e "\033[31m" "The file does not exist at rutorrent-$suffix." "\033[32m""Is RuTorrent installed?""\e[0m"
                sleep 2
            fi
            ;;
    ##########
            "21") # change the rpc password for the user rutorrent-suffix of choice
            read -ep "Please state the suffix of the instance you wish to modify: " suffix
            echo
            if [[ -f ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd ]]
            then
                htpasswd -m $HOME/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd rutorrent
                sed -ri '/^rutorrent:(.*)/! s/(.*)//g' ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                sed -ri '/^$/d' ~/.nginx/conf.d/000-default-server.d/scgi-$suffix-htpasswd
                echo
                sleep 2
            else
                echo -e "\033[31m""required file " "\033[36m""~/.nginx/conf.d/000-default-server.d/scgi-htpasswd-$suffix""\e[0m" "\033[31m""does not exist""\e[0m"
                echo -e "Does this custom instance exist? Was it installed after you had updated to nginx (a requirement)?"
                echo
                sleep 2
            fi
            ;;
    ##########
            "22") # Quit
            exit 1
            ;;
    ##########
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