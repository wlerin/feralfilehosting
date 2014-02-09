#!/bin/bash
# couchpotato
scriptversion="1.0.1"
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
mainport=$(shuf -i 6001-49000 -n 1)
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/CouchPotato%20-%20An%20automatic%20NZB%20and%20torrent%20downloader%20for%20Films/scripts/couchpotato.sh"
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
#
############################
##### Self Updater End #####
############################
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
cd && rm -f {000,111,222}"$scriptname.sh"
chmod -f 700 "$HOME/bin/$scriptname"
#
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
####### Script Start #######
############################
#
echo "Downloading and configuring some files..."
if [[ -f ~/.couchpotato/couchpotato.pid ]]
then
    kill $(cat ~/.couchpotato/couchpotato.pid)
fi
rm -rf ~/CouchPotatoServer
git clone -q https://github.com/RuudBurger/CouchPotatoServer.git
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
echo "https://$(hostname)/$(whoami)/couchpotato"
echo
echo "It may take a few minutes for the program to load properly in the URL"
echo
#
############################
####### Script Ends  #######
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit 1
fi