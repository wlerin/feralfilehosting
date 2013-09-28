#!/bin/bash
# weechat installation
scriptversion="1.0.0"
scriptname="weechat"
# randomessence
#
############################
## Version History Starts ##
############################
#
# How do I customise this updater? 
# 1: scriptversion="0.0.0" replace "0.0.0" with your script version. This will be shown to the user at the current version.
# 2: scriptname="weechat" replace "weechat" with your script name. this will be shown to the user when they first run the script.
# 3: Search and replace all instances of "weechat", 29 including this one, with the name of your script, do not include the .sh aside from doing step 2.
# 4: Then replace ALL "https://raw.github.com/feralhosting" with the URL to the RAW script URL.
# 5: Insert you script in the "Script goes here" labelled section 
#
# This updater deals with updating two files at the same time, the  "~/weechat.sh" and the "~/bin/weechat" . You can remove one part of the updater, if you wish, to focus on a single file instance.
#
############################
### Version History Ends ###
############################
#
#
############################
###### Variable Start ######
############################
#
weechat="http://www.weechat.org/files/src/weechat-0.4.1.tar.gz"
weechatfv="0.4.1"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p $HOME/bin
#
if [ ! -f $HOME/weechat.sh ]
then
    wget -qO $HOME/weechat.sh https://raw.github.com/feralhosting
fi
if [ ! -f $HOME/bin/weechat ]
then
    wget -qO $HOME/bin/weechat https://raw.github.com/feralhosting
fi
#
wget -qO $HOME/000weechat.sh https://raw.github.com/feralhosting
#
if ! diff -q $HOME/000weechat.sh $HOME/weechat.sh > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/weechat.sh https://raw.github.com/feralhosting
    wget -qO $HOME/bin/weechat https://raw.github.com/feralhosting
    bash $HOME/weechat.sh
    exit 1' > $HOME/111weechat.sh
    bash $HOME/111weechat.sh
    exit 1
fi
if ! diff -q $HOME/000weechat.sh $HOME/bin/weechat > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/weechat.sh https://raw.github.com/feralhosting
    wget -qO $HOME/bin/weechat https://raw.github.com/feralhosting
    bash $HOME/weechat.sh
    exit 1' > $HOME/222weechat.sh
    bash $HOME/222weechat.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000weechat.sh $HOME/111weechat.sh $HOME/222weechat.sh
chmod -f 700 $HOME/bin/weechat
#
############################
##### Self Updater End #####
############################
#
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ $updatestatus =~ ^[Yy]$ ]]
then
#
############################
####### Script Start #######
############################
#
# 1
#
mkdir -p ~/programs
[ -z "$(grep '~/programs/bin' ~/.bashrc)" ] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
#
# 2
#
wget -qO ~/weechat.tar.gz $weechat
tar -xzf ~/weechat.tar.gz
cd ~/weechat-$weechatfv
sed -i 's/SET(CMAKE_SKIP_RPATH ON)//g' ~/weechat-$weechatfv/CMakeLists.txt
cmake -DCMAKE_INSTALL_RPATH=/opt/curl/current/lib -DPREFIX=$HOME/programs -DCURL_LIBRARY=/opt/curl/current/lib/libcurl.so -DCURL_INCLUDE_DIR=/opt/curl/current/include
make && make install && cd
rm -rf ~/weechat.tar.gz ~/weechat-$weechatfv
echo
echo "Done. To start weechat use this command:"
echo
echo "weechat-curses"
#
############################
####### Script Ends  #######
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    exit 1
    cd && bash
fi