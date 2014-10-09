#!/bin/bash
# Script name
scriptversion="1.0.4"
scriptname="install.sickbeard"
# Author name
#
# wget -qO ~/install.sickbeard.sh http://git.io/bPrsUg && bash ~/install.sickbeard.sh
#
############################
## Version History Starts ##
############################
#
# How do I customise this updater? 
# 1: scriptversion="0.0.0" replace "0.0.0" with your script version. This will be shown to the user at the current version.
# 2: scriptname="somescript" replace "somescript" with your script name. Make it unique to this script.
# 3: Set the scripturl variable in the variable section to the RAW github URl of the script for updating.
# 4: Insert your script in the "Script goes here" labelled section
#
# This updater deals with updating a single file, the "~/somescript.sh".
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
mainport=$(shuf -i 10001-49000 -n 1)
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Sickbeard%20-%20Basic%20Setup/scripts/sickbeard.sh"
giturlsickbeard="https://github.com/midgetspy/Sick-Beard.git"
giturlsickrage="https://github.com/echel0n/SickRage.git"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p ~/bin
wget -qO "$HOME/000$scriptname" "$scripturl"
#
if ! diff -q "$HOME/000$scriptname" "$HOME/bin/$scriptname" >/dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/bin/$scriptname"
    exit 1' > "$HOME/111$scriptname"
    bash "$HOME/111$scriptname"
    exit 1
fi
cd && rm -f {000,111}"$scriptname"
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
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " -i "y" updatestatus
echo
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
                                                    fi
                                                    if [[ ! -f ~/.sickbeard/config.ini ]]
                                                    then
                                                        echo -e "[General]\nweb_port = $mainport\nweb_root = \"/$(whoami)/sickbeard\"\nlaunch_browser = 0" > ~/.sickbeard/config.ini
                                                    else
                                                        kill $(ps x | grep "python $HOME/.sickbeard/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                        echo "I need to wait 10 seconds for SickBeard to shutdown."
                                                        sleep 10
                                                        sed -ri 's|web_port = (.*)|web_port = '"$mainport"'|g' ~/.sickbeard/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickbeard"|g' ~/.sickbeard/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickbeard/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$mainport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$mainport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$mainport"'|g' ~/.sickbeard/config.ini
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
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$mainport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$mainport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
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
                                                        fi
                                                        cd ~/.sickrage
                                                        git pull origin
                                                        echo
                                                    else
                                                        git clone "$giturlsickrage" ~/.sickrage
                                                    fi
                                                    #
                                                    if [[ ! -f ~/.sickrage/config.ini ]]
                                                    then
                                                        mkdir -p ~/.sickrage.tv.shows
                                                        echo -e "[General]\nweb_port = $mainport\nweb_root = \"/$(whoami)/sickrage\"\nlaunch_browser = 0\nroot_dirs = 0|$HOME/.sickrage.tv.shows\n\n[TORRENT]\ntorrent_username = rutorrent\ntorrent_host = https://$(hostname -f)/$(whoami)/rtorrent/rpc/\ntorrent_path = $HOME/private/rtorrent/data" > ~/.sickrage/config.ini
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$mainport"'|g' ~/.sickrage/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickrage"|g' ~/.sickrage/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickrage/config.ini
                                                        sed -i 's#root_dirs = ""#root_dirs = 0|'$HOME'/.sickrage.tv.shows#g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_username = ""|torrent_username = rutorrent|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_host = ""|torrent_host = https://'$(hostname -f)'/'$(whoami)'/rtorrent/rpc/|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_path = ""|torrent_path = '"$HOME"'/private/rtorrent/data|g' ~/.sickrage/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$mainport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$mainport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$mainport"'|g' ~/.sickrage/config.ini
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
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$mainport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$mainport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#