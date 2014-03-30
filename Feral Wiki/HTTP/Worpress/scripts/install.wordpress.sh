#!/bin/bash
# Install Wordpress
scriptversion="1.0.0"
scriptname="install.wordpress"
# randomessence
#
# wget -qO ~/install.wordpress.sh http://git.io/2JBQlg && bash ~/install.wordpress.sh
#
############################
## Version History Starts ##
############################
#
# v1.0.0 template updated and basic script tweaked.
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
wordpressurl="http://wordpress.org/latest.tar.gz"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Worpress/scripts/install.wordpress.sh"
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
    if [ ! -d "$HOME/www/$(whoami).$(hostname)/public_html/wordpress" ]
    then
        echo -e "Downloading and extracting latest version to:"
        echo
        echo -e "\033[32m""$(whoami).$(hostname)/wordpress""\e[0m"
        echo
        echo "and (they are the same physical location)"
        echo
        wget -qO "$HOME"/latest.tar.gz "$wordpressurl"
        tar xf "$HOME"/latest.tar.gz -C "$HOME"/www/$(whoami).$(hostname)/public_html
        rm -f "$HOME"/latest.tar.gz
        echo -e "Done: Visit your WWW/wordpress to complete the installaion."
        echo
    else
        echo -e "The wordpress directory already exists."
        read -ep "Do you want to overwrite it anyway? [y] yes or [n] no : " confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
            echo -e "Downloading and extracting latest version to:"
            echo
            echo -e "\033[32m""$(whoami).$(hostname)/wordpress""\e[0m"
            echo
            echo "and (they are the same physical location)"
            echo
            echo -e "\033[33m""https://$(hostname)/$(whoami)/wordpress/""\e[0m"
            wget -qO "$HOME"/latest.tar.gz "$wordpressurl"
            tar xf "$HOME"/latest.tar.gz -C "$HOME"/www/$(whoami).$(hostname)/public_html
            rm -f "$HOME"/latest.tar.gz
            echo -e "Done: Visit your WWW/wordpress to complete the installaion."
            echo
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