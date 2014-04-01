#!/bin/bash
# Install multiple instances of rtorrent and rutorrent
scriptversion="1.1.3"
scriptname="install.multirtru"
# randomessence
#
# wget -qO ~/install.multirtru.sh http://git.io/_zVu0A && bash ~/install.multirtru.sh
#
############################
## Version History Starts ##
############################
#
# v1.1.3 small tweaks to instalaltion script
# v1.1.2 template updated
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
feralstats="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Feralstats%20plugin%20for%20ruTorrent/files/feralstats.zip"
ratiocolor="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Rutorrent%20-%20Colored%20Ratio%20Column%20Plugin/ratiocolor-1/ratiocolor.zip"
confurl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Multiple%20instances%20-%20rtorrent%20and%20rutorrent/conf/.rtorrent.rc"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Multiple%20instances%20-%20rtorrent%20and%20rutorrent/script/install.multirtru.sh"
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" > /dev/null 2>&1
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
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" > /dev/null 2>&1
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
cd && rm -f {000,111,222}"$scriptname.sh"
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
############################
#### User Script Starts ####
############################
#
    # Removal options start
    read -ep "Would you like to delete an existing custom instance and all related files and folders? [y]es or choose [n]o to skip: " removal
    echo
    if [[ "$removal" =~ ^[Yy]$ ]]
    then
        read -ep "Please tell me the suffix to use for removal of the rtorrent and rutorrent instances: " suffix
        echo
        #
        screen -S rtorrent-"$suffix" -X quit > /dev/null 2>&1
        echo -e "\033[32m""Custom instance has been shutdown: if it was running""\e[0m"
        echo
        if [[ -f ~/.rtorrent-"$suffix".rc ]]
        then
            rm -f ~/.rtorrent-"$suffix".rc
            echo "~/.rtorrent-$suffix.rc has been removed"
            echo
        else
            echo "~/.rtorrent-$suffix.rc file not found, skipping"
            echo
        fi
        #
        if [[ -d ~/private/rtorrent-"$suffix" ]]
        then
            rm -rf ~/private/rtorrent-"$suffix"
            echo "~/private/rtorrent-$suffix has been removed"
            echo
        else
            echo "~/private/rtorrent-$suffix not found, skipping"
            echo
        fi
        #
        if [[ -d ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix" ]]
        then
            rm -rf ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"
            echo "~/www/$(whoami).$(hostname)/public_html/rutorrent-$suffix has been removed"
            echo
        else
            echo "~/www/$(whoami).$(hostname)/public_html/rutorrent-$suffix not found, skipping"
            echo
        fi
        #
        if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
        then
            rm -f ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
            rm -f ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix".conf
            rm -f ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix"-rpc.conf
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            echo "Nginx related files have been removed and nginx has been reloaded"
            echo
        fi
        if [[ -f ~/multirtru.restart.txt ]]
        then
            sed -i '/screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~\/.rtorrent-'"$suffix"'.rc/d' ~/multirtru.restart.txt
            sed -i '/^$/d' ~/multirtru.restart.txt
        fi
        echo -e "\033[31m""Done""\e[0m"
        echo
        sleep 2
        # reload script to use removal options again or skip to installation
        bash ~/"$scriptname.sh"
    fi
    # Removal options ends
    # Installtation start
    echo -e "This script will create a new rutorrent and rtorrent instance using a suffix, for example:"
    echo
    echo -e "\033[32m""/public_html/rutorrent-1""\e[0m""," "\033[33m""~/.rtorrent-1.rc""\e[0m" "and" "\033[36m""~/private/rtorrent-1""\e[0m"
    echo
    echo -e "\033[31m""The first thing we need to do is pick a suffix to use:""\e[0m"
    echo
    read -ep "Please chose a suffix to use for our new rtorrent and rutorrent instances: " suffix
    echo
    if [[ -z "$suffix" ]]
    then
        echo -e "\033[31m""You did not give a suffix to use. Please enter one. The script will restart""\e[0m"
        bash ~/"$scriptname.sh"
        exit 1
    else
        if [[ ! -f ~/.rtorrent-"$suffix".rc && ! -d ~/private/rtorrent-"$suffix" && ! -d ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix" ]]
        then
            # clone the installation
            echo -e "\033[31m""1:""\e[0m" "Creating the installation"
            echo
            # Create some folders we need
            mkdir -p ~/private/rtorrent-"$suffix"/data ~/private/rtorrent-"$suffix"/watch ~/private/rtorrent-"$suffix"/work
            # Copy the Feral rutorrent template
            cp -rf /opt/rutorrent/current/. ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"
            # Make sure rtorrent adder will work with nginx by creating this folder.
            mkdir -p ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/share/torrents
            # Download and install the Feral stats plugin
            wget -qO ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip "$feralstats"
            unzip -qo ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/feralstats.zip -d ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/
            rm -f ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/feralstats.zip
            # Download and install the ratio colour plugin
            wget -qO ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip "$ratiocolor"
            unzip -qo ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/ratiocolor.zip -d ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/plugins/
            rm -f ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/ratiocolor.zip
            # Download and configure the custom .rtorrent.rc
            wget -qO ~/.rtorrent-"$suffix".rc "$confurl"
            #
            # sed custom ~/.rtorrent.rc
            echo -e "\033[31m""2:""\e[0m" "\033[32m""Part 1""\e[0m" "Editing the files: rtorrent"
            echo
            sed -i 's|/media/DiskID/home/username/private/rtorrent/|'"$HOME"'/private/rtorrent-'"$suffix"'/|g' ~/.rtorrent-"$suffix".rc
            sed -i 's|/media/DiskID/home/username/www/username.server.feralhosting.com/public_html/rutorrent/php/initplugins.php username|'"$HOME"'/www/'$(whoami)'.'$(hostname)'/public_html/rutorrent-'"$suffix"'/php/initplugins.php '$(whoami)'|g' ~/.rtorrent-"$suffix".rc
            # sed /rutorrent/
            echo -e "\033[31m""2:""\e[0m" "\033[33m""Part 2""\e[0m" "Editing the files: rutorrent"
            echo
            sed -i 's|/private/rtorrent/.socket|/private/rtorrent-'"$suffix"'/.socket|g' ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/conf/config.php
            # Password protect the setup
            echo -e "\033[31m""3:""\e[0m" "Password Protect the Installation"
            echo
            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
            then
                echo -e 'location /rutorrent-'"$suffix"' {\n    auth_basic "rutorrent-'"$suffix"'";\n    auth_basic_user_file '"$HOME"'/www/'$(whoami)'.'$(hostname)'/public_html/rutorrent-'"$suffix"'/.htpasswd;\n}\n\nlocation /rutorrent-'"$suffix"'/conf { deny all; }\nlocation /rutorrent-'"$suffix"'/share { deny all; }' > ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix".conf
                echo -e 'location /rtorrent-'"$suffix"'/rpc {\n    include   /etc/nginx/scgi_params;\n    scgi_pass unix://'"$HOME"'/private/rtorrent-'"$suffix"'/.socket;\n\n    auth_basic '\''rtorrent SCGI for rutorrent-'"$suffix"''\'';\n    auth_basic_user_file conf.d/000-default-server.d/scgi-'"$suffix"'-htpasswd;\n}' > ~/.nginx/conf.d/000-default-server.d/rtorrent-"$suffix"-rpc.conf
                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            fi
            echo -e 'AuthType Basic\nAuthName "rtorrent-'"$suffix"'"\nAuthUserFile "'"$HOME"'/www/'$(whoami)'.'$(hostname)'/public_html/rutorrent-'"$suffix"'/.htpasswd"\nRequire valid-user' > ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htaccess
            read -ep "Please give me a username for the user we are creating: " username
            echo
            if [[ -n "$username" ]]
            then
                echo -e "You entered" "\033[32m""$username""\e[0m" "as the choice of username"
                echo
                htpasswd -cm ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd "$username"
                echo
            else
                echo -e "No username was give so i am using a generic username which is:" "\033[32m""rutorrent-$suffix""\e[0m"
                echo
                htpasswd -cm ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd rutorrent-"$suffix"
                echo
            fi
            # nginx copy rutorrent-suffix htpassd to create the rpc htpassd file.
            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
            then
                if [[ -s "$HOME"/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd ]]
                then
                    cp -f ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                    sed -i 's/\(.*\):\(.*\)/rutorrent:\2/g' ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                fi
            fi
            #
            echo -e "\033[31m""You can use the htpasswdtk script to manage these installations.""\e[0m"
            chmod 644 ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htaccess ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd
            echo
            # create the screen
            echo -e "\033[32m""4:""\e[0m" "Creating the screen process"
            screen -fa -dmS rtorrent-"$suffix" rtorrent -n -o import=~/.rtorrent-"$suffix".rc
            echo 'screen -fa -dmS rtorrent-'"$suffix"' rtorrent -n -o import=~/.rtorrent-'"$suffix"'.rc' >> ~/multirtru.restart.txt
            echo
            echo -e "\033[32m""This command was added to""\e[0m" "\033[36m""~/multirtru.restart.txt""\e[0m" "\033[32m""so you can easily restart this instance""\e[0m"
            echo "To reattach to this screen type:"
            echo
            echo -e "\033[33m""screen -r rtorrent-$suffix""\e[0m"
            echo
            echo "Is it running?"
            echo
            screen -ls | grep rtorrent-"$suffix"
            echo
            if [[ -n "$username" ]]
            then
                echo -e "The username for this instance is:" "\033[32m""$username""\e[0m"
                echo
            else
                echo -e "The username for this instance is:" "\033[32m""rutorrent-$suffix""\e[0m"
                echo
            fi
            echo -e "Visit this URL to see your new instance:" "\033[32m""https://$(hostname)/$(whoami)/rutorrent-$suffix/""\e[0m"
            echo
            if [[ -s ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd ]]
            then
                echo -e "\033[33m""Don't forget, you can manage your passwords with this FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=22""\e[0m"
                echo
            else
                echo -e "\033[31m""There was a problem. The rutorrent-$suffix .htpasswd is empty.""\e[0m"
                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                then
                    echo -e "\033[32m""This means this custom instance has no password and the rpc will not work.""\e[0m"
                else
                    echo -e "\033[32m""This means this custom instance has no password""\e[0m"
                fi
                #
                echo "Lets try again, Make sure your passwords match this time:"
                echo
                #
                if [[ -n "$username" ]]
                then
                    echo -e "You entered" "\033[32m""$username""\e[0m" "as the choice of username"
                    echo
                    htpasswd -cm ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd "$username"
                    echo
                else
                    echo -e "No username was give so i am using a generic username which is:" "\033[32m""rutorrent-$suffix""\e[0m"
                    echo
                    htpasswd -cm ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd rutorrent-"$suffix"
                    echo
                fi
                #
                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                then
                    if [[ -s "$HOME"/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd ]]
                    then
                        cp -f ~/www/$(whoami).$(hostname)/public_html/rutorrent-"$suffix"/.htpasswd ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                        sed -i 's/\(.*\):\(.*\)/rutorrent:\2/g' ~/.nginx/conf.d/000-default-server.d/scgi-"$suffix"-htpasswd
                    else
                        echo -e "\033[31m""There was a problem. The rutorrent-$suffix .htpasswd is empty.""\e[0m"
                        echo -e "\033[32m""This means your passwords did not match in the previous step, again.""\e[0m"
                        echo -e "\033[33m""You will need to use the script in this FAQ:""\e[0m" "\033[36m""https://www.feralhosting.com/faq/view?question=22""\e[0m"
                        echo
                    fi
                fi
                #
            fi
            exit 1
        else
            echo -e "\033[31m""This particular suffix already exists, try another. The script will restart.""\e[0m"
            bash ~/"$scriptname.sh"
            exit 1
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#