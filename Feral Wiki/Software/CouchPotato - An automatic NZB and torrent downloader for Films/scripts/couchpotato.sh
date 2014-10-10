#!/bin/bash
# couchpotato
scriptversion="1.0.3"
scriptname="couchpotato"
# randomessence
#
# wget -qO ~/couchpotato.sh http://git.io/NWQA2Q && bash ~/couchpotato.sh
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
# This updater deals with updating two files at the same time, the  "~/somescript.sh" and the "~/bin/somescript".
# This updater deals with updating two files at the same time, the  "~/somescript.sh" and the "~/bin/somescript".
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
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    mkdir -p ~/blackhole
    echo "Downloading and configuring some files..."
    echo
    if [[ -f ~/.couchpotato/couchpotato.pid ]]
    then
        kill $(cat ~/.couchpotato/couchpotato.pid)
    fi
    rm -rf ~/CouchPotatoServer
    git clone -q "$giturl"
    cp -rf ~/CouchPotatoServer/. ~/.couchpotato
    rm -rf ~/CouchPotatoServer
    echo -e "[core]\nhost = 0.0.0.0\nport = $mainport\nlaunch_browser = 0\nurl_base = /$(whoami)/couchpotato" > ~/.couchpotato/settings.conf
    echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /couchpotato http://10.0.0.1:'"$mainport"'/${USER}/couchpotato\nProxyPassReverse /couchpotato http://10.0.0.1:'"$mainport"'/${USER}/couchpotato' > ~/.apache2/conf.d/couchpototo.conf
    /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
    then
        echo -en 'location ^~ /couchpotato {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$mainport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/couchpotato.conf
        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    fi
    python ~/.couchpotato/CouchPotato.py --daemon
    echo "Visit this URL to finish the set up wizard"
    echo
    echo "https://$(hostname -f)/$(whoami)/couchpotato/"
    echo
    echo -e "\033[31m""It may take a few minutes for the program to load properly in the URL." "\033[32m""Pressing F5 in your browser can help.""\e[0m"
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#