#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: adamaze (frankthetank7254)
#
# Script Contributors: randomessence
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/transdroid.setup http://git.io/lU_B9w && bash ~/transdroid.setup
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
    # put your version changes in the single quotes and then uncomment the line.
    #
    #echo 'v0.1.0 - My changes go here'
    #echo 'v0.0.9 - My changes go here'
    #echo 'v0.0.8 - My changes go here'
    #echo 'v0.0.7 - My changes go here'
    #echo 'v0.0.6 - My changes go here'
    #echo 'v0.0.5 - My changes go here'
    #echo 'v0.0.4 - My changes go here'
    #echo 'v0.0.3 - My changes go here'
    echo 'v1.1.2 - Forgot to update randompass variable to apppass when updating template whihc broke the script - credit to zycore for pointing it out'
    echo 'v1.1.1 - Template updated'
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
scriptversion="1.1.2"
#
# Script name goes here. Please prefix with install.
scriptname="transdroid.setup"
#
# Author name goes here.
scriptauthor="None credited"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/lU_B9w"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Transdroid%20-%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/scripts/transdroid-setup.sh"
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
rtorrentjson="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Transdroid%20-%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/json/rtorrent-settings.json"
delugejson="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Transdroid%20-%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/json/deluge-settings.json"
transmissionjson="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Transdroid%20-%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/json/transmission-settings.json"
#
option1="ruTorrent"
option2="Deluge"
option3="Transmission"
option4="Custom Rutorrent instance"
option5="Quit"
#
tmpdir1=".transdroid_import"
tmpdir2="transdroid_import"
#
URL="https://$(whoami):$apppass@$(hostname -f)/$(whoami)/$tmpdir2"
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
#### Script Help Starts ####
############################
#
if [[ ! -z $1 && $1 == 'help' ]]
then
    echo
    echo -e "\033[32m""Script help and usage instructions:""\e[0m"
    echo
    #
    ###################################
    ##### Custom Help Info Starts #####
    ###################################
    #
    echo -e "This script will take your application's WebUi password and generate Qrcode for you."
    echo -e "It will then create a special password protected WWW directory for you to access this file"
    echo -e "by providing you with a special URL to use to login to the protected directory in your browser."
    echo
    echo -e "You can import his Qrcode directly into Transdroid/Transdrone using the built in import feature."
    echo
    echo -e "When you press enter to exit the script at the prompt all files are cleaned up an removed."
    #
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
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
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
    echo This script will generate the "settings.json" file that Transdroid requires for importing settings. Please choose the client you are using.
    echo
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
                            if [[ -d ~/.nginx ]]
                            then
                                mkdir -p ~/$tmpdir1
                                #
                                wget -qO ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/qrencode_3.3.0-2_amd64.deb
                                wget -qO ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/libqrencode3_3.3.0-2_amd64.deb
                                #
                                dpkg-deb -x ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb ~/$tmpdir1
                                dpkg-deb -x ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb ~/$tmpdir1
                                #
                                wget -qO ~/$tmpdir1/settings.json "$rtorrentjson"
                                read -ep "Please enter the ruTorrent password from your Account overview page: " pass
                                echo
                                #
                                sed -i 's/rutorrent main/rutorrent '$(hostname -f | grep -oE "^([a-z]+)")' main/' ~/$tmpdir1/settings.json
                                sed -i 's/USERNAME-CHANGEME/'$(whoami)'/' ~/$tmpdir1/settings.json
                                sed -i 's/HOSTNAME_CHANGEME/'$(hostname -f)'/' ~/$tmpdir1/settings.json
                                sed -i 's/PASSWORD-CHANGEME/'$pass'/' ~/$tmpdir1/settings.json
                                #
                                mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                #
                                # cp -f ~/$tmpdir1/settings.json ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/settings.json
                                htpasswd -cbm ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/.htpasswd "$(whoami)" "$apppass" > /dev/null 2>&1
                                #
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    echo -e 'location /'"$tmpdir2"' {\n    auth_basic "'"$tmpdir2"'";\n    auth_basic_user_file "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd";\n}' > ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                                #
                                echo -e 'AuthType Basic\nAuthName "'"$tmpdir2"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname -f)/public_html/"$tmpdir2"/.htaccess
                                #
                                # LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 1 -t ANSI256 -o - "$URL"
                                LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 10 -t PNG "$(cat ~/.transdroid_import/settings.json)" -o ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/rtorrent.png
                                #
                                echo -e "1: Open Transdroid/Transdrone and go to:" "\033[36m""Settings > System > Import settings""\e[0m"
                                echo
                                echo -e "2: Click" "\033[36m""Use QR code""\e[0m"
                                echo
                                echo -e "3: Open this URL in a browser:"
                                echo
                                echo -e "\033[32m""$URL/rtorrent.png""\e[0m"
                                echo
                                echo -e "4: Now scan with Transdroid/Transdrone to import""\e[0m"
                                echo
                                echo -e "Note: Imported connections will be merged with existing ones. Nothing will be lost."
                                echo
                                read -ep "After you have scanned the qrcode, press ENTER to clean up." useless
                                echo
                                #
                                if [[ ! -z "$tmpdir1" && ! -z "$tmpdir2" ]]
                                then
                                    cd && rm -rf $tmpdir1 ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                    then
                                        rm -f ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                    fi
                                else
                                    echo "Nothing was removed. Please check manually."
                                fi
                            else
                                echo "Nginx is not installed and is a prerequisite for using Transdroid/Transdrone"
                                echo
                                echo "Please see this FAQ -- https://www.feralhosting.com/faq/view?question=231"
                                echo
                            fi
                            ;;
                    "2")
                            mkdir -p ~/$tmpdir1
                            #
                            wget -qO ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/qrencode_3.3.0-2_amd64.deb
                            wget -qO ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/libqrencode3_3.3.0-2_amd64.deb
                            #
                            dpkg-deb -x ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb ~/$tmpdir1
                            dpkg-deb -x ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb ~/$tmpdir1
                            #
                            wget -qO ~/$tmpdir1/settings.json "$delugejson"
                            read -ep "Please enter the Deluge password from your Account overview page: " pass
                            echo
                            #
                            sed -i 's/deluge main/deluge '$(hostname -f | grep -oE "^([a-z]+)")' main/' ~/$tmpdir1/settings.json
                            sed -i 's/USERNAME-CHANGEME/'$(whoami)'/g' ~/$tmpdir1/settings.json
                            sed -i 's/HOSTNAME_CHANGEME/'$(hostname -f)'/' ~/$tmpdir1/settings.json
                            sed -i 's/PASSWORD-CHANGEME/'$pass'/' ~/$tmpdir1/settings.json
                            #
                            mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                            #
                            # cp -f ~/$tmpdir1/settings.json ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/settings.json
                            htpasswd -cbm ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/.htpasswd "$(whoami)" "$apppass" > /dev/null 2>&1
                            #
                            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                            then
                                echo -e 'location /'"$tmpdir2"' {\n    auth_basic "'"$tmpdir2"'";\n    auth_basic_user_file "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd";\n}' > ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                            fi
                            #
                            echo -e 'AuthType Basic\nAuthName "'"$tmpdir2"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname -f)/public_html/"$tmpdir2"/.htaccess
                            #
                            # LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 1 -t ANSI256 -o - "$URL"
                            LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 10 -t PNG "$(cat ~/.transdroid_import/settings.json)" -o ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/deluge.png
                            #
                            echo -e "1: Open Transdroid/Transdrone and go to:" "\033[36m""Settings > System > Import settings""\e[0m"
                            echo
                            echo -e "2: Click" "\033[36m""Use QR code""\e[0m"
                            echo
                            echo -e "3: Open this URL in a browser:"
                            echo
                            echo -e "\033[32m""$URL/deluge.png""\e[0m"
                            echo
                            echo -e "4: Now scan with Transdroid/Transdrone to import""\e[0m"
                            echo
                            echo -e "Note: Imported connections will be merged with existing ones. Nothing will be lost."
                            echo
                            read -ep "After you have scanned the qrcode, press ENTER to clean up." useless
                            echo
                            #
                            if [[ ! -z "$tmpdir1" && ! -z "$tmpdir2" ]]
                            then
                                cd && rm -rf $tmpdir1 ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    rm -f ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                            else
                                echo "Nothing was removed. Please check manually."
                            fi
                        ;;
                    "3")
                            mkdir -p ~/$tmpdir1
                            #
                            wget -qO ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/qrencode_3.3.0-2_amd64.deb
                            wget -qO ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/libqrencode3_3.3.0-2_amd64.deb
                            #
                            dpkg-deb -x ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb ~/$tmpdir1
                            dpkg-deb -x ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb ~/$tmpdir1
                            #
                            wget -qO ~/$tmpdir1/settings.json "$transmissionjson"
                            read -ep "Please enter the Transmission password from your Account overview page: " pass
                            echo
                            #
                            sed -i 's/transmission main/transmission '$(hostname -f | grep -oE "^([a-z]+)")' main/' ~/$tmpdir1/settings.json
                            sed -i 's/USERNAME-CHANGEME/'$(whoami)'/' ~/$tmpdir1/settings.json
                            sed -i 's/HOSTNAME_CHANGEME/'$(hostname -f)'/' ~/$tmpdir1/settings.json
                            sed -i 's/PASSWORD-CHANGEME/'$pass'/' ~/$tmpdir1/settings.json
                            #
                            mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                            #
                            # cp -f ~/$tmpdir1/settings.json ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/settings.json
                            htpasswd -cbm ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/.htpasswd "$(whoami)" "$apppass" > /dev/null 2>&1
                            #
                            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                            then
                                echo -e 'location /'"$tmpdir2"' {\n    auth_basic "'"$tmpdir2"'";\n    auth_basic_user_file "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd";\n}' > ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                            fi
                            #
                            echo -e 'AuthType Basic\nAuthName "'"$tmpdir2"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname -f)/public_html/"$tmpdir2"/.htaccess
                            #
                            # LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 1 -t ANSI256 -o - "$URL"
                            LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 10 -t PNG "$(cat ~/.transdroid_import/settings.json)" -o ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/transmission.png
                            #
                            echo -e "1: Open Transdroid/Transdrone and go to:" "\033[36m""Settings > System > Import settings""\e[0m"
                            echo
                            echo -e "2: Click" "\033[36m""Use QR code""\e[0m"
                            echo
                            echo -e "3: Open this URL in a browser:"
                            echo
                            echo -e "\033[32m""$URL/transmission.png""\e[0m"
                            echo
                            echo -e "4: Now scan with Transdroid/Transdrone to import""\e[0m"
                            echo
                            echo -e "Note: Imported connections will be merged with existing ones. Nothing will be lost."
                            echo
                            read -ep "After you have scanned the qrcode, press ENTER to clean up." useless
                            echo
                            #
                            if [[ ! -z "$tmpdir1" && ! -z "$tmpdir2" ]]
                            then
                                cd && rm -rf $tmpdir1 ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    rm -f ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                            else
                                echo "Nothing was removed. Please check manually."
                            fi
                        ;;
                    "4")
                            if [[ -d ~/.nginx ]]
                            then
                                mkdir -p ~/$tmpdir1
                                #
                                wget -qO ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/qrencode_3.3.0-2_amd64.deb
                                wget -qO ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb http://ftp.uk.debian.org/debian/pool/main/q/qrencode/libqrencode3_3.3.0-2_amd64.deb
                                #
                                dpkg-deb -x ~/$tmpdir1/qrencode_3.3.0-2_amd64.deb ~/$tmpdir1
                                dpkg-deb -x ~/$tmpdir1/libqrencode3_3.3.0-2_amd64.deb ~/$tmpdir1
                                #
                                wget -qO ~/$tmpdir1/settings.json "$rtorrentjson"
                                until [[ -d ~/www/$(whoami).$(hostname -f)/public_html/rutorrent-$suffix ]]
                                do
                                    read -ep "What is the suffix of the instance you wish to connect to: rutorrent-" suffix
                                done
                                read -ep "Please enter the ruTorrent password from your Account overview page: " pass
                                echo
                                #
                                sed -i 's|\\\/rtorrent\\\/rpc|\\\/rtorrent-'$suffix'\\\/rpc|' ~/.transdroid_import/settings.json
                                sed -i 's/rutorrent main/rutorrent-'$suffix' '$(hostname -f | grep -oE "^([a-z]+)")'/' ~/$tmpdir1/settings.json
                                sed -i 's/USERNAME-CHANGEME/'$(whoami)'/' ~/$tmpdir1/settings.json
                                sed -i 's/HOSTNAME_CHANGEME/'$(hostname -f)'/' ~/$tmpdir1/settings.json
                                sed -i 's/PASSWORD-CHANGEME/'$pass'/' ~/$tmpdir1/settings.json
                                #
                                mkdir -p ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                #
                                # cp -f ~/$tmpdir1/settings.json ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/settings.json
                                htpasswd -cbm ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/.htpasswd "$(whoami)" "$apppass" > /dev/null 2>&1
                                #
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    echo -e 'location /'"$tmpdir2"' {\n    auth_basic "'"$tmpdir2"'";\n    auth_basic_user_file "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd";\n}' > ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                                #
                                echo -e 'AuthType Basic\nAuthName "'"$tmpdir2"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname -f)'/public_html/'"$tmpdir2"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname -f)/public_html/"$tmpdir2"/.htaccess
                                #
                                # LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 1 -t ANSI256 -o - "$URL"
                                LD_LIBRARY_PATH=~/.transdroid_import/usr/lib/x86_64-linux-gnu ~/.transdroid_import/usr/bin/qrencode -m 10 -t PNG "$(cat ~/.transdroid_import/settings.json)" -o ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2/rtorrent.png
                                #
                                echo -e "1: Open Transdroid/Transdrone and go to:" "\033[36m""Settings > System > Import settings""\e[0m"
                                echo
                                echo -e "2: Click" "\033[36m""Use QR code""\e[0m"
                                echo
                                echo -e "3: Open this URL in a browser:"
                                echo
                                echo -e "\033[32m""$URL/rtorrent.png""\e[0m"
                                echo
                                echo -e "4: Now scan with Transdroid/Transdrone to import""\e[0m"
                                echo
                                echo -e "Note: Imported connections will be merged with existing ones. Nothing will be lost."
                                echo
                                read -ep "After you have scanned the qrcode, press ENTER to clean up." useless
                                echo
                                #
                                if [[ ! -z "$tmpdir1" && ! -z "$tmpdir2" ]]
                                then
                                    cd && rm -rf $tmpdir1 ~/www/$(whoami).$(hostname -f)/public_html/$tmpdir2
                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                    then
                                        rm -f ~/.nginx/conf.d/000-default-server.d/transdroid_import.conf
                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                    fi
                                else
                                    echo "Nothing was removed. Please check manually."
                                fi
                            else
                                echo "Nginx is not installed and is a prerequisite for using Transdroid/Transdrone"
                                echo
                                echo "Please see this FAQ -- https://www.feralhosting.com/faq/view?question=231"
                                echo
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