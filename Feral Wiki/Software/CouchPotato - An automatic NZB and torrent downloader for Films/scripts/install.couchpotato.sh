#!/bin/bash
# install.couchpotato
scriptversion="1.0.6"
scriptname="install.couchpotato"
# randomessence
#
# wget -qO ~/couchpotato http://git.io/NWQA2Q && bash ~/couchpotato
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
# This updater deals with updating a single file, the "~/bin/somescript", by updating and switching to this script.
#
# http://grover.open2space.com/content/bash-script-menus-and-functions
#
############################
### Version History Ends ###
############################
option1="Install Program"
option2="Update Program"
option3="Quit the Script"
############################
###### Variable Start ######
############################
#
mainport=$(shuf -i 10001-49000 -n 1)
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/CouchPotato%20-%20An%20automatic%20NZB%20and%20torrent%20downloader%20for%20Films/scripts/couchpotato.sh"
giturl="https://github.com/RuudBurger/CouchPotatoServer.git"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
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
            echo "1) $option1"
            echo "2) $option2"
            echo "3) $option3"
            echo
    }

    while [ 1 ]
    do
            showMenu
            read -e CHOICE
            echo
            case "$CHOICE" in
                    "1")
                            if [[ ! -d ~/.couchpotato ]]
                            then
                                mkdir -p ~/.blackhole
                                echo "Downloading and configuring some files..."
                                echo
                                git clone "$giturl" ~/.couchpotato
                                echo -e "[core]\nhost = 0.0.0.0\nport = $mainport\nlaunch_browser = 0\nurl_base = /$(whoami)/couchpotato\nusername = $(whoami)\n\n[blackhole]\ndirectory = $HOME/.blackhole\n\n[rtorrent]\nusername = rutorrent\nenabled = 1\nhost = https://$(hostname -f)/$(whoami)/rtorrent/rpc\ndirectory = $HOME/private/rtorrent/data/" > ~/.couchpotato/settings.conf
                                # proxypass start
                                mkdir -p ~/.apache2/conf.d
                                echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /couchpotato http://10.0.0.1:'"$mainport"'/${USER}/couchpotato\nProxyPassReverse /couchpotato http://10.0.0.1:'"$mainport"'/${USER}/couchpotato' > ~/.apache2/conf.d/couchpototo.conf
                                /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    echo -en 'location ^~ /couchpotato {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/couchpotato.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                                # proxypass end
                                python ~/.couchpotato/CouchPotato.py --daemon
                                echo "Visit this URL to finish the set up wizard"
                                echo
                                echo "https://$(hostname -f)/$(whoami)/couchpotato/"
                                echo
                                echo -e "\033[31m""It may take a few minutes for the program to load properly in the URL." "\033[32m""Pressing F5 in your browser can help.""\e[0m"
                                echo
                            else
                                echo 'The folder ~/.couchpotato already exists. User Option 2 or remove it first'
                            fi
                            ;;
                    "2")    
                            if [[ -d ~/.couchpotato ]]
                            then
                                if [[ -f ~/.couchpotato/couchpotato.pid ]]
                                then
                                    kill $(cat ~/.couchpotato/couchpotato.pid)
                                    sleep 10
                                    echo "I need to wait 10 seconds for Couchpotato to shut down."                                                                  
                                fi
                                cd ~/.couchpotato
                                git pull origin
                                echo
                            else
                                echo 'Couchpotato is not installed to ~/.couchpotato'
                            fi
                            ;;
                    "3")
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#