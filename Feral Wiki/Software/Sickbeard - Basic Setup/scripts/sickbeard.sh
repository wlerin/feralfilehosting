#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomessence
#
# Script Contributors: 
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/install.sickbeard http://git.io/bPrsUg && bash ~/install.sickbeard
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
# This updater deals with updating a single file, the "~/bin/somescript", by updating and switching to this script.
#
# So how do I use and customise this updater template with my script?
#
### Basic Info section:
#
# 1: Optional - fill in the basic info section at the start for those reading the script code.
# 2: Most of the important information and usage directions are meant to be set in the script info section and used with the script option info. So set them there if required.
#
### Version History Section:
#
# 3: Modify the version history templates in the Version History section and uncomment on a per line basis to use with the script option "changelog", for example, "somescript changelog"
#
### Variables Section:
#
# 4: scriptversion="0.0.0" - replace "0.0.0" with your script version. This will be shown to the user at the current version check.
# 5: scriptname="somescript" - replace "somescript" with your script name. Make it unique to this script. Do not include the file extension.
# 6: scriptauthor="None credited" - change this to the script author's name.
# 7: contributors=="None credited" - add the names of any contributors you wish to credit here.
# 8: gitiourl="http://git.io/vvf9K" - change this to the shortened URL provided by http://git.io once you have committed the script to github or from a gist.
# 9: gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname" - Leave this as it is. Do not modify it. This variable depends on the correct setting of the $gitiourl variable.
# 10: scripturl="https://raw.github.com/feralhosting" - Set the scripturl variable in the variable section to the RAW github URL of the script for use with the updater features.
# 11: appport=$(shuf -i 10001-49999 -n 1) - works in tandem with a while loop just below it. Will generate and test a port to make sure it is not in use. Use this when configuring an application's port.
# 12: updaterenabled="1" - Set this to 0 to permanently disable the built in updater and associated features.
#
### Script Info Section:
#
# Important note: The info section contains basic information about the features of this updater and the script. Don't modify these. You have a section dedicated to your unique information.
#
# 13: Place your unique information and usage instructions inside the section labelled "Custom Script Notes" using echoes.
#
### Self Updater Section:
#
# 14: This section is self contained you don't need to modify this section. This feature will compare itself vs the raw script linked at the github URL provided and update itself
#
### User Scripts:
#
# Important Note: This template is a wrapper around your script. You will need to make use of the script option below like qr to call your own options.
#
# 15: Insert your script in the "User Script" labelled section - Indented by one tab (4 spaces) to be in line with the overall script. You can copy and paste a working script into this section.
#
### Script Options explained:
#
# 16: changelog - use the argument qr when calling the script, for example - "somescript changelog".
# 17: info - use the argument qr when calling the script, for example - "somescript info".
# 18: qr - use this option to quick run the script suppressing all update prompts and jumping directly to the user script, for example - "somescript qr". Note - This does not disable or bypass the updater.
# 19: nu - use the option to disable the update features of the script, for example - "somescript nu". Note - This will run the script from where it is called and append -DEV to the version number output.
# 20: To pass your own variables to the script in the user script section please start from $2 onwards.
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z $1 && $1 == 'changelog' ]]; then echo
    #
    # put your version changes in the single quotes and then uncomment the line.
    #
    #echo 'v0.1.0 - My changes go here'
    #echo 'v0.0.9 - My changes go here'
    #echo 'v0.0.8 - My changes go here'
    #echo 'v0.0.7 - My changes go here'
    #echo 'v0.0.6 - My changes go here'
    #echo 'v0.0.5 - My changes go here'
    #echo 'v0.0.4 - My changes go here'
    #echo 'v0.0.3 - My changes go here'
    #echo 'v0.0.2 - My changes go here'
    echo 'v1.1.1 - Template updated'
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
scriptversion="1.1.1"
#
# Script name goes here. Please prefix with install.
scriptname="install.sickbeard"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/bPrsUg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Sickbeard%20-%20Basic%20Setup/scripts/sickbeard.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport=$(shuf -i 10001-49999 -n 1); done
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
[[ -d ~/www/$(whoami).$(hostname -f)/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
############################
## Custom Variables Start ##
############################
#
unrarv="5.2.6"
unrarfv="http://www.rarlab.com/rar/unrarsrc-5.2.6.tar.gz"
#
giturlsickbeard="https://github.com/midgetspy/Sick-Beard.git"
giturlsickrage="https://github.com/SiCKRAGETV/SickRage.git"
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
#### Script Info Starts ####
############################
#
# Use this to show a user script information when they use the info option with the script.
if [[ ! -z $1 && $1 == 'info' ]]
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
    echo -e "\033[32m""Script Information and usage instructions:""\e[0m"
    echo
    #
    ###################################
    #### Custom Script Notes Start ####
    ###################################
    #
    echo -e "Put your instructions or script information here using echoes"
    #
    ###################################
    ##### Custom Script Notes End #####
    ###################################
    #
    echo
    echo -e "\033[32m""Script options:""\e[0m"
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
    echo -e "$gitiocommand"
    echo
    echo -e "~/bin/$scriptname"
    echo
    echo -e "$scriptname"
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
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, whihc woudl reset the option, it will then find this file and set it back.
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq 1 ]]
    then
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
        echo
    else
        echo
        echo "The Updater has been disabled"
        echo
        scriptversion="$scriptversion-DEV"
    fi
fi
#
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
if [[ -f ~/.quickrun ]];then updatestatus="y"; rm -f ~/.quickrun; fi
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" == "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
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
                                                        echo
                                                    fi
                                                    if [[ ! -f ~/.sickbeard/config.ini ]]
                                                    then
                                                        echo -e "[General]\nweb_port = $appport\nweb_root = \"/$(whoami)/sickbeard\"\nlaunch_browser = 0" > ~/.sickbeard/config.ini
                                                    else
                                                        kill $(ps x | grep "python $HOME/.sickbeard/SickBeard.py" | grep -v grep | head -n 1 | awk '{print $1}') > /dev/null 2>&1
                                                        echo "I need to wait 10 seconds for SickBeard to shutdown."
                                                        sleep 10
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickbeard/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickbeard"|g' ~/.sickbeard/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickbeard/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickbeard/config.ini
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
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard\nProxyPassReverse /sickbeard http://10.0.0.1:'"$appport"'/${USER}/sickbeard' > ~/.apache2/conf.d/sickbeard.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickbeard {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
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
                                                            echo
                                                        fi
                                                        cd ~/.sickrage
                                                        git pull origin
                                                        cd
                                                        echo
                                                    else
                                                        git clone "$giturlsickrage" ~/.sickrage
                                                        echo
                                                    fi
                                                    #
                                                    if [[ ! -f ~/.sickrage/config.ini ]]
                                                    then
                                                        mkdir -p ~/.sickrage.tv.shows
                                                        echo -e "[General]\nweb_port = $appport\nweb_root = \"/$(whoami)/sickrage\"\nlaunch_browser = 0\nroot_dirs = 0|$HOME/.sickrage.tv.shows\n\n[TORRENT]\ntorrent_username = rutorrent\ntorrent_host = https://$(hostname -f)/$(whoami)/rtorrent/rpc/\ntorrent_path = $HOME/private/rtorrent/data\ntorrent_auth_type = basic" > ~/.sickrage/config.ini
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickrage/config.ini
                                                        sed -ri 's|web_root = "(.*)"|web_root = "'$(whoami)'/sickrage"|g' ~/.sickrage/config.ini
                                                        sed -i 's|launch_browser = 1|launch_browser = 0|g' ~/.sickrage/config.ini
                                                        sed -i 's#root_dirs = ""#root_dirs = 0|'$HOME'/.sickrage.tv.shows#g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_username = ""|torrent_username = rutorrent|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_host = ""|torrent_host = https://'$(hostname -f)'/'$(whoami)'/rtorrent/rpc/|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_path = ""|torrent_path = '"$HOME"'/private/rtorrent/data|g' ~/.sickrage/config.ini
                                                        sed -i 's|torrent_auth_type = ""|torrent_auth_type = basic|g' ~/.sickrage/config.ini
                                                    fi
                                                    # Apache proxypass
                                                    if [[ -d ~/.apache2/conf.d ]]
                                                    then
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else 
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
                                                        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                                    else 
                                                        echo "Nginx is not installed. The nginx proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Installing Unrar locally.
                                                    echo "Installing Unrar $unrarv locally for use with post processing"
                                                    echo
                                                    wget -qO ~/unrar.tar.gz "$unrarfv"
                                                    tar xf ~/unrar.tar.gz && cd ~/unrar
                                                    make > ~/.sickrage/.unrar.make.log 2>&1
                                                    make install DESTDIR=~ >> ~/.sickrage/.unrar.make.log 2>&1
                                                    cd && rm -rf unrar{,.tar.gz}
                                                    echo "Done"
                                                    echo
                                                    echo "Starting SickRage"
                                                    echo
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
                                                        sed -ri 's|web_port = (.*)|web_port = '"$appport"'|g' ~/.sickrage/config.ini
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
                                                        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage\nProxyPassReverse /sickrage http://10.0.0.1:'"$appport"'/${USER}/sickrage' > ~/.apache2/conf.d/sickrage.conf
                                                        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                                    else
                                                        echo "Apache is not installed. The Apache proxypass was not installed."
                                                        echo
                                                    fi
                                                    # Nginx Proxypass
                                                    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                                    then
                                                        echo -en 'location ^~ /sickrage {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/sickrage.conf
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
    exit
fi
#
############################
##### Core Script Ends #####
############################
#