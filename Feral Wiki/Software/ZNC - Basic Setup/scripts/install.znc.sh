#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: adamaze
#
# Script Contributors: randomessence
#
# Bash Command for easy reference:
#
# wget -qO ~/install.znc http://git.io/vfKaT && bash ~/install.znc
#
# The MIT License (MIT)
#
# Copyright (c) 2016 randomessence
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
## See readme.md
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z "$1" && "$1" = 'changelog' ]]
then
    echo
    #
    echo '1.0.8 username and password are stored in plain text in ~/.script-credentials/. cat ~/.script-credentials/znc-credentials.txt '
    echo '1.0.7 layout tweaks'
    echo '1.0.6 apache proxy pass updated for jessie'
    echo '1.0.5 obsolete sed line removed'
    echo '1.0.4 bug fixes and tweaks.'
    echo '1.0.3 proxypass for apache or nginx'
    echo '1.0.2 template tweaks'
    echo '1.0.1 push module with curl if required dependency is present otherwise skipped. Template updated'
    echo '1.0.0 automation'
    echo 'v0.8.0 Template update'
    echo 'v0.7.0 - visual and functional tweaks'
    echo 'v0.5.0 - initial commit'
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
scriptversion="1.0.8"
#
# Script name goes here. Please prefix with install.
scriptname="install.znc"
#
# Author name goes here.
scriptauthor="adamaze"
#
# Contributor's names go here.
contributors="randomessence"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/vvfyN"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/ZNC%20-%20Basic%20Setup/scripts/install.znc.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass="$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)"
# This will generate a random port for the script between the range 10001 to 32001 to use with applications. You can ignore this unless needed.
appport="$(shuf -i 10001-32001 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport="$(shuf -i 10001-32001 -n 1)"; done
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
[[ -d ~/www/"$(whoami)"."$(hostname -f)"/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
# Bug reporting varaibles.
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
zncdownload="http://znc.in/releases/znc-latest.tar.gz"
znctemplate="http://git.io/vvTzB"
zncpassgen="$(wget -qO - http://git.io/vvTgf | sed 's/SETAPASS/'"$apppass"'/g' | python)"
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
###### Function Start ######
############################
#
zncproxy () {
    if [[ -f ~/.znc/configs/znc.conf ]]
    then
        appport="$(sed -rn 's/(.*)Port = (.*)/\2/p' ~/.znc/configs/znc.conf)"
    fi
    # Apache proxypass
    if [[ -d ~/.apache2/conf.d ]]
    then
        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\nSSLProxyVerify none\nSSLProxyCheckPeerCN off\nSSLProxyCheckPeerName off\nSSLProxyCheckPeerExpire off\n\nProxyPass /znc https://10.0.0.1:'"$appport"'/${USER}/znc retry=0 timeout=5\nProxyPassReverse /znc https://10.0.0.1:'"$appport"'/${USER}/znc' > ~/.apache2/conf.d/znc.conf
        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
    fi
    # Nginx Proxypass
    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
    then
        echo -en 'location /znc {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'"$(whoami)"'/$1 break;\nproxy_pass https://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/znc.conf
        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    fi
}
#
credentials () {
    mkdir -p ~/.script-credentials
    [[ ! -f ~/.script-credentials/znc-credentials.txt ]] && echo '' > ~/.script-credentials/znc-credentials.txt
    echo -e "Your znc WebUi username: $(whoami)\nYour znc WebUi password: $apppass" | tee ~/.script-credentials/znc-credentials.txt
}
#
#
############################
####### Function End #######
############################
#
############################
#### Script Help Starts ####
############################
#
if [[ ! -z "$1" && "$1" = 'help' ]]
then
    echo
    echo -e "\033[32m""Script help and usage instructions:""\e[0m"
    echo
    #
    ###################################
    ##### Custom Help Info Starts #####
    ###################################
    #
    echo -e "This script will get you set up basic access to the znc WebUi."
    echo
    echo -e "Use the WebUi to further configure znc for netowrks and users."
    echo
    echo -e "To see login your info use this command:"
    echo
    echo -e "cat ~/.script-credentials/znc-credentials.txt"
    echo
    echo -e "Once installed via the script you can update znc manually from then on."
    echo
    echo -e "Shutdown ZNC first via the admin account using /znc shutdown"
    echo
    echo -e "Use the commands in the wiki to make and make install znc then it will be updated"
    echo
    echo "See here for instructions: http://git.io/vE1hm"
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
if [[ ! -z "$1" && "$1" = 'info' ]]
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
    echo -e "You should create an issue directly on github using your github account."
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
# Checks for the positional parameters $1 and $2 to be reset if the script is updated.
[[ ! -z "$1" && "$1" != 'qr' ]] || [[ ! -z "$2" && "$2" != 'qr' ]] && echo -en "$1\n$2" > ~/.passparams
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
[[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]] && echo -n '' > ~/.quickrun
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z "$1" && "$1" = 'nu' ]] || [[ ! -z "$2" && "$2" = 'nu' ]]; then
    scriptversion="$scriptversion-nu"
    echo -e "\nThe Updater has been temporarily disabled\n"
else
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq "1" ]]; then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        wget -qO ~/.000"$scriptname" "$scripturl"
        if [[ "$(sha256sum ~/.000"$scriptname" | awk '{print $1}')" != "$(sha256sum ~/bin/"$scriptname" | awk '{print $1}')" ]]; then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname" && bash ~/.111"$scriptname"; exit
        else
            if [[ -z "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" && "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" -ne "$$" ]]; then
                echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname" && bash ~/.222"$scriptname"; exit
            fi
        fi
        cd && rm -f .{000,111,222}"$scriptname" && chmod -f 700 ~/bin/"$scriptname"
        echo
    else
        scriptversion="$scriptversion-DEV"
        echo -e "\nThe Updater has been disabled\n"
    fi
fi
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
[[ -f ~/.quickrun ]] && updatestatus="y"; rm -f ~/.quickrun
# resets the positional parameters $1 and $2 post update.
[[ -f ~/.passparams ]] && set "$1" "$(sed -n '1p' ~/.passparams)" && set "$2" "$(sed -n '2p' ~/.passparams)"; rm -f ~/.passparams
#
############################
##### Self Updater End #####
############################
#
############################
## Positional Param Start ##
############################
#
if [[ ! -z "$1" && "$1" = "example" ]]
then
    echo
    #
    # Edit below this line
    #
    echo "Add your custom positional parameters in this section."
    #
    if [[ -n "$2" ]]
    then
        echo "You used $scriptname $1 $2 when calling this example"
    fi
    #
    # Edit above this line
    #
    echo
    exit
fi
#
############################
### Positional Param End ###
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" = "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    zncproxy
    echo "The proxypass was updated and the webserver was reloaded."
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
    read -ep "Do you need the extra charset available in ZNC? (This is for non-english characters) [y/n]: " -n 1 REPLY
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]
    then
        if [ "$(dpkg-query -s libicu-dev 2>&1 | grep -c 'ok installed')" -eq 0 ]; then
            echo -e "\033[31m""It looks like libicu-dev is not installed on your server.""\e[0m"
            echo -e "Please open a ticket: ""\033[32m""https://www.feralhosting.com/manager/tickets/new""\e[0m"
            echo
            echo "Paste the following into the ticket:"
            echo
            echo -e "\033[33m""Please can you install the ZNC 1.6 dependency for charset\n\nhttps://packages.debian.org/wheezy/libicu-dev\n\napt-get install libicu-dev\n\nThank you.""\e[0m"
            echo
            echo -e "Once you are notified that the dependency has been installed, you can re-run this script"
            echo
            exit
        fi
    fi
    #
    echo -e "\033[33m""This script will download and install znc on your slot. It may take a few minutes...""\e[0m"
    echo
    mkdir -p ~/bin ~/.logs
    wget -qO ~/znc.tar.gz "$zncdownload"
    tar xf ~/znc.tar.gz
    cd ~/znc-1.*
    echo "1: Configuring"
    echo
    ./configure --prefix="$HOME" > ~/.logs/znc-configure.log 2>&1
    echo "2: Compiling"
    echo
    make > ~/.logs/znc-make.log 2>&1
    echo "3: Installing"
    echo
    make install > ~/.logs/znc-make-install.log 2>&1
    cd && rm -rf znc{-1.*,.tar.gz}
    echo -e "\033[33m""Setting up ZNC using the template files.""\e[0m"
    echo
    killall -u "$(whoami)" znc > /dev/null 2>&1
    #
    if [ "$(dpkg-query -s libcurl4-openssl-dev 2>&1 | grep -c 'ok installed')" -eq 1 ]
    then
        echo "libcurl4-openssl-dev is installed. Installing znc push module."
        echo
        git clone https://github.com/jreese/znc-push.git > ~/.logs/znc-push.log 2>&1
        cd ~/znc-push
        make curl=yes >> ~/.logs/znc-push.log 2>&1
        make install >> ~/.logs/znc-push.log 2>&1
        cd && rm -rf znc-push
    else
        echo -e "\033[31m""libcurl4-openssl-dev is not installed. Skipping push module installation.""\e[0m"
        echo
        echo "Please refer to the ZNC FAQ for how to get the dependency installed."
        echo "Once you have libcurl4-openssl-dev installed then install the push module manually."
        echo
    fi
    #
    mkdir -p ~/.znc/configs/
    [[ -f ~/.znc/configs/znc.conf ]] && cp ~/.znc/configs/znc.conf ~/.znc/configs/znc.conf.bak-$(date +"%d.%m.%y@%H:%M:%S")
    wget -qO ~/.znc/configs/znc.conf "$znctemplate"
    #
    sed -ri 's|URIPrefix = /SETAUSER/znc|URIPrefix = /'"$(whoami)"'/znc|g' ~/.znc/configs/znc.conf
    #
    sed -ri 's/<User SETAUSER>/<User '"$(whoami)"'>/g' ~/.znc/configs/znc.conf
    sed -ri 's/	Nick       = SETAUSER/	Nick       = '"$(whoami)"'/g' ~/.znc/configs/znc.conf
    sed -ri 's/	AltNick    = SETAUSER_/	AltNick    = '"$(whoami)"_'/g' ~/.znc/configs/znc.conf
    sed -ri 's/	Ident      = SETAUSER/	Ident      = '"$(whoami)"'/g' ~/.znc/configs/znc.conf
    sed -ri 's/	Port = SETAPORT/	Port = '"$appport"'/g' ~/.znc/configs/znc.conf
    sed -ri 's/	Pass       = SETAPASS/	Pass       = '"$zncpassgen"'/g' ~/.znc/configs/znc.conf
    #
    ~/bin/znc --makepem > /dev/null 2>&1
    ~/bin/znc
    #
    echo -e "\033[33m""\nNow that ZNC has been installed, configured, and started, we will make sure it starts if/when your server reboots.""\e[0m"
    echo
    #
    # adding to cron
    tmpcron="$(mktemp)"
    if [ "$(crontab -l 2> /dev/null | grep -c '^@reboot ~/bin/znc$')" == "0" ]
    then
        echo "appending znc to crontab."
        crontab -l 2> /dev/null > "$tmpcron"
        echo "@reboot ~/bin/znc" >> "$tmpcron"
        crontab "$tmpcron"
        rm "$tmpcron"
    else
        echo "znc @reboot is already in your crontab."
    fi
    # function
    zncproxy
    # give user the full URL
    echo -e "\nClick on or copy the URL below to do additional configuration if needed\n"
    echo -e "\033[33m""${host2https}znc/""\e[0m"
    echo
    credentials
    echo
    echo -e "Your IRC client connection information is:"
    echo
    echo -e "\033[32m""$(hostname -f)""\e[0m"" or ""\033[32m""$(hostname -i)""\e[0m"" and the port is: ""\033[32m""$appport""\e[0m"
    echo
    echo -e "Search the ZNC wiki for help connecting with different clients. http://wiki.znc.in/"
    echo
    exit
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