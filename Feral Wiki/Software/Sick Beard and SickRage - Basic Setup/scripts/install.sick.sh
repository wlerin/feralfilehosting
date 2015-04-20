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
# wget -qO ~/install.sick http://git.io/vffpn && bash ~/install.sick
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
    #echo 'v0.0.2 - My changes go here'
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
scriptversion="1.1.1"
#
# Script name goes here. Please prefix with install.
scriptname="install.sick"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/vffpn"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Sickbeard%20-%20Basic%20Setup/scripts/sickbeard.sh"
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
# Bug reporting varaibles.
makeissue=".makeissue $scriptname A description of the issue"
ticketurl="https://www.feralhosting.com/manager/tickets/new"
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
unrarv="5.2.6"
unrarfv="http://www.rarlab.com/rar/unrarsrc-5.2.6.tar.gz"
#
giturlsickbeard="https://github.com/midgetspy/Sick-Beard.git"
giturlsickrage="https://github.com/SiCKRAGETV/SickRage.git"
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
    showMenu () 
    {
            echo "1) Install Sickbeard"
            echo "2) Install SickRage"
            echo "3) Quit the script"
            echo
    }

    while [ 1 ]
    do
            showMenu
            read -e CHOICE
            echo
            case "$CHOICE" in
                    "1")
                            showMenu () 
                            {
                                    echo "1) Install or update Sickbeard"
                                    echo "2) Install just the proxypass for Apache or Nginx"
                                    echo "3) Quit the script"
                                    echo
                            }

                            while [ 1 ]
                            do
                                    showMenu
                                    read -e CHOICE
                                    case "$CHOICE" in
                                            "1")
                                                    echo
                                                    if [[ -d ~/.sickbeard ]]
                                                    then
                                                        kill $(ps x | grep "python $HOME/.sickbeard/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                        echo "I need to wait 10 seconds for SickBeard to shutdown."
                                                        echo
                                                        sleep 10
                                                        cd ~/.sickbeard
                                                        git pull origin
                                                        python ~/.sickbeard/SickBeard.py -d
                                                        echo "Sickbeard has been updated and restarted"
                                                        echo
                                                        exit
                                                        cd
                                                    else
                                                        git clone "$giturlsickbeard" ~/.sickbeard
                                                        echo
                                                    fi
                                                    if [[ ! -f ~/.sickbeard/config.ini ]]
                                                    then
                                                        echo -e "[General]\nweb_port = $appport\nweb_root = \"/$(whoami)/sickbeard\"\nlaunch_browser = 0" > ~/.sickbeard/config.ini
                                                    else
                                                        kill $(ps x | grep "python $HOME/.sickbeard/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                        echo "I need to wait 10 seconds for SickBeard to shutdown."
                                                        sleep 10
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickbeard/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickbeard"|g' ~/.sickbeard/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickbeard/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
                                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                                    else 
                                                        echo "Nginx is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    python ~/.sickbeard/SickBeard.py -d
                                                    echo
                                                    echo "Done"
                                                    echo
                                                    echo "Visit: https://$(hostname -f)/$(whoami)/sickbeard/home/"
                                                    echo
                                                    exit
                                                    ;;
                                            "2")
                                                    echo
                                                    if [[ -f "$HOME"/.sickbeard/config.ini ]]
                                                    then
                                                        kill $(ps x | grep "python $HOME/.sickbeard/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                        echo "I need to wait 10 seconds for SickBeard to shutdown."
                                                        sleep 10
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickbeard/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickbeard"|g' ~/.sickbeard/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickbeard/config.ini
                                                    else
                                                        echo "Sickbeard is not Installed to ~/.sickbeard."
                                                        echo
                                                        exit
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
                                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                                    else
                                                        echo "Nginx is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    python "$HOME"/.sickbeard/SickBeard.py -d
                                                    echo
                                                    echo "Done"
                                                    echo
                                                    echo "Visit: https://$(hostname -f)/$(whoami)/sickbeard/home/"
                                                    echo
                                                    exit
                                                    ;;
                                            "3")
                                                    echo
                                                    exit
                                                    ;;
                                    esac
                            done
                            ;;
                    "2")
                            showMenu () 
                            {
                                    echo "1) Install or update SickRage"
                                    echo "2) Install just the proxypass for Apache or Nginx"
                                    echo "3) Quit the script"
                                    echo
                            }

                            while [ 1 ]
                            do
                                    showMenu
                                    read -e CHOICE
                                    case "$CHOICE" in
                                            "1")
                                                    echo
                                                    #
                                                    if [[ -d ~/.sickrage ]]
                                                    then
                                                        if [[ -z $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') ]]
                                                        then
                                                            :
                                                        else
                                                            kill $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                            echo "I need to wait 10 seconds for SickRage to shutdown."
                                                            sleep 10
                                                            echo
                                                        fi
                                                        cd ~/.sickrage
                                                        git pull origin
                                                        cd
                                                        echo
                                                    else
                                                        git clone "$giturlsickrage" ~/.sickrage
                                                        echo
                                                    fi
                                                    #
                                                    if [[ ! -f ~/.sickrage/config.ini ]]
                                                    then
                                                        mkdir -p ~/.sickrage.tv.shows
                                                        echo -e "[General]\nweb_port = $appport\nweb_root = \"/$(whoami)/sickrage\"\nlaunch_browser = 0\nroot_dirs = 0|$HOME/.sickrage.tv.shows\n\n[TORRENT]\ntorrent_username = rutorrent\ntorrent_host = https://$(hostname -f)/$(whoami)/rtorrent/rpc/\ntorrent_path = $HOME/private/rtorrent/data\ntorrent_auth_type = basic" > ~/.sickrage/config.ini
                                                    else
                                                        #
                                                        if [[ -z $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') ]]
                                                        then
                                                            :
                                                        else
                                                            kill $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                            echo "I need to wait 10 seconds for SickRage to shutdown."
                                                            sleep 10
                                                        fi
                                                        #
                                                        mkdir -p ~/.sickrage.tv.shows
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickrage/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickrage"|g' ~/.sickrage/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickrage/config.ini
                                                        sed -i 's#root_dirs = ""#root_dirs = 0|'$HOME'/.sickrage.tv.shows#g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_username = ""|torrent_username = rutorrent|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_host = ""|torrent_host = https://'$(hostname -f)'/'$(whoami)'/rtorrent/rpc/|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_path = ""|torrent_path = '"$HOME"'/private/rtorrent/data|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_auth_type = ""|torrent_auth_type = basic|g' ~/.sickrage/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
                                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                                    else 
                                                        echo "Nginx is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Installing Unrar locally.
                                                    echo "Installing Unrar $unrarv locally for use with post processing"
                                                    echo
                                                    wget -qO ~/unrar.tar.gz "$unrarfv"
                                                    tar xf ~/unrar.tar.gz && cd ~/unrar
                                                    make > ~/.sickrage/.unrar.make.log 2>&1
                                                    make install DESTDIR=~ >> ~/.sickrage/.unrar.make.log 2>&1
                                                    cd && rm -rf unrar{,.tar.gz}
                                                    echo "Done"
                                                    echo
                                                    echo "Starting SickRage"
                                                    echo
                                                    python "$HOME"/.sickrage/SickBeard.py -d
                                                    echo "Done"
                                                    echo
                                                    echo "Visit https://$(hostname -f)/$(whoami)/sickrage/home/"
                                                    echo
                                                    exit
                                                    ;;
                                            "2")
                                                    echo
                                                    if [[ -f ~/.sickrage/config.ini ]]
                                                    then
                                                         if [[ -z $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') ]]
                                                        then
                                                            :
                                                        else
                                                            kill $(ps x | grep "python $HOME/.sickrage/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                            echo "I need to wait 10 seconds for SickRage to shutdown."
                                                            sleep 10
                                                        fi
                                                        mkdir -p ~/.sickrage.tv.shows
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickrage/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickrage"|g' ~/.sickrage/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickrage/config.ini
                                                    else
                                                        echo "SickRage is not Installed to ~/.sickrage."
                                                        echo
                                                        exit
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
                                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                                    else
                                                        echo "Nginx is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    python "$HOME"/.sickrage/SickBeard.py -d
                                                    echo "Done"
                                                    echo
                                                    echo "Visit https://$(hostname -f)/$(whoami)/sickrage/home/"
                                                    echo
                                                    exit
                                                    ;;
                                            "3")
                                                    echo
                                                    exit
                                                    ;;
                                    esac
                            done
                            ;;
                    "3")
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