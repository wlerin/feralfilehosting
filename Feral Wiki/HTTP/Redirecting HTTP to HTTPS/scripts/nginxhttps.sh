#!/bin/bash
# nginx force https on Dual URL
scriptversion="1.0.2"
scriptname="nginxhttps"
#
# wget -qO ~/nginxhttps.sh http://git.io/A34SpA && bash ~/nginxhttps.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.2 template updated
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Redirecting%20HTTP%20to%20HTTPS/scripts/nginxhttps.sh"
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
#
############################
#### User Script Starts ####
############################
#
    echo "1: Creating the conf file"
    echo
    #
    echo -n "# Set the variable so we can also redirect to server.feralhosting.com/username/
    set \$feraluser  \"$(whoami)\";

    # Checks if https is NOT on and then SETs part one of our custom variable.
    if (\$http_x_forwarded_proto != https ) {
        set \$forceh  A;
    }

    # Check for the URL format username.server.feralhosting.com and SETs part 2 of our custom variable.
    if (\$http_x_host = \$http_host) {
        set \$forceh  \"\${forceh}1\"; 
    }

    # Check for the URL format server.feralhosting.com/username and SETs part 2 of our custom variable.
    if (\$http_x_host != \$http_host) {
        set \$forceh  \"\${forceh}2\";
    }

    # Check x_host when it does match host that it is also specific to feral, so as not to apply to a users's VHost domains.
    if (\$http_x_host ~* ^([0-9a-zA-Z-]+)\.([0-9a-zA-Z-]+)\.feralhosting\.com\$) {
        set \$forceh  \"\${forceh}3\";
    }

    # Check x_host when it does not match host that it is also specific to feral, so as not to apply to a users's VHost domains.
    if (\$http_x_host ~* ^([0-9a-zA-Z-]+)\.feralhosting\.com\$) {
        set \$forceh  \"\${forceh}4\";
    }

    # Combines the SET options to rewrite this URL format: username.server.feralhosting.com
    if (\$forceh = A13) {
        rewrite ^ https://\$http_x_host\$request_uri? permanent;
    }

    # Combines the SET options to rewrite this URL format: server.feralhosting.com/username
    if (\$forceh = A24) {
        rewrite ^ https://\$http_x_host/\$feraluser\$request_uri? permanent;
    }" > ~/.nginx/conf.d/000-default-server.d/https.conf
    #
    echo "2: Reloading the nginx configuration"
    echo
    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    echo "3: Done. You may need to clear your browser cache to see the changes."
    echo
    exit 1
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