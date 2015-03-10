#!/bin/bash
# weechat installation
scriptversion="1.1.3"
scriptname="install.weechat"
# randomessence
#
# wget -qO ~/install.weechat.sh http://git.io/L6oalA && bash ~/install.weechat.sh
#
############################
#### Script Notes Start ####
############################
#
# Add notes or warnings here for anyone modifying the scripts
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
weechat="http://weechat.org/files/src/weechat-1.1.1.tar.gz"
weechatfv="1.1.1"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Weechat%20-%20IRC%20client%20basic%20setup/scripts/weechat.sh"
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
read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    wget -O ~/cmake.tar.gz http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz
    tar xf ~/cmake.tar.gz && cd cmake-2.8.12.2
    ./configure --prefix="$HOME"
    make && make install
    cd && rm -rf cmake{-2.8.12.2,.tar.gz}
	if [[ -f "$HOME/bin/cmake" ]]
	then
		wget -qO ~/weechat.tar.gz "$weechat"
		tar xf ~/weechat.tar.gz
		cd ~/weechat-"$weechatfv"
		sed -i 's/set(CMAKE_SKIP_RPATH ON)//g' ~/weechat-"$weechatfv"/CMakeLists.txt
		"$HOME"/bin/cmake -DCMAKE_INSTALL_RPATH=/opt/curl/current/lib -DPREFIX="$HOME" -DCURL_LIBRARY=/opt/curl/current/lib/libcurl.so -DCURL_INCLUDE_DIR=/opt/curl/current/include
		make
		make install
		cd
		rm -rf ~/weechat.tar.gz ~/weechat-"$weechatfv"
		echo
		echo "Done. Continue with the rest of the FAQ to configure weechat"
		echo
	else
		echo "Cmake is not installed. Please Complete Step 1 of the FAQ before running this script"
		echo
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