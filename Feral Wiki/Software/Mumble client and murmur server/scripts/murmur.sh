#!/bin/bash
# murmur server installation
scriptversion="1.0.1"
scriptname="install.murmur"
# randomessence
#
# wget -qO ~/murmur.sh http://git.io/t3fmNQ && bash ~/murmur.sh
#
############################
## Version History Starts ##
############################
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
murmururl="http://downloads.sourceforge.net/project/mumble/Mumble/1.2.5/murmur-static_x86-1.2.5.tar.bz2"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Mumble%20client%20and%20murmur%20server/scripts/install.murmur.sh"
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
    echo -e "Downloading and configuring murmur"
    echo
    wget -qO ~/server.tar.bz2 "$murmururl"
    tar xf ~/server.tar.bz2
    cp -rf ~/murmur-static_x86-1.2.5/. ~/private/murmur
    cd && rm -rf {murmur-static_x86-1.2.5,server.tar.bz2}
    sed -i 's|port=64738|port='$(shuf -i 6000-50000 -n 1)'|g' ~/private/murmur/murmur.ini
    echo -e "Here is your murmur server:" "\033[33m""$(hostname)""\e[0m"":""\033[32m""$(sed -n -e 's/port=\(.*\)/\1/p' ~/private/murmur/murmur.ini)""\e[0m"
    echo
    read -ep "Would you like to set a password to connect to the server now? [y] or skip this step [s]: "  confirm
    echo
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        read -ep "please enter you password: " mumblepass
        echo
        sed -i 's|serverpassword=|serverpassword='"$mumblepass"'|g' ~/private/murmur/murmur.ini
    fi
    ~/private/murmur/./murmur.x86 -ini ~/private/murmur/murmur.ini
    echo -e "The server has been started."
    echo
    echo -e "Here is a list of the running servers:"
    echo
    ps x | grep murmur | grep -v grep
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