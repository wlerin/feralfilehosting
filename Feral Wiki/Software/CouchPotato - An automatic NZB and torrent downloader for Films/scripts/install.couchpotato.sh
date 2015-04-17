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
# wget -qO ~/install.couchpotato http://git.io/3_iozg && bash ~/install.couchpotato
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
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
    echo 'v1.0.8 - bug fixes to option 3. Settings port and proxypass port were different. Visual tweaks.'
    echo 'v1.0.7 - Added option to just install the proxypass. Updated template and minor tweaks.'
    echo 'v1.0.6 - Updated templated'
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
scriptname="install.couchpotato"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/3_iozg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/CouchPotato%20-%20An%20automatic%20NZB%20and%20torrent%20downloader%20for%20Films/scripts/install.couchpotato.sh"
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
option1="Install Program"
option2="Update Program"
option3="Install the Apache or Nginx proxypass."
option4="Quit the Script"
#
giturl="https://github.com/RuudBurger/CouchPotatoServer.git"
#
proxyport="$(grep -oE -m 1 'port = [0-9]{4,5}' ~/.couchpotato/settings.conf | sed -rn 's/^port = (.*)/\1/p')"
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
#### Script Help Starts ####
############################
#
if [[ ! -z $1 && $1 == 'help' ]]
then
    echo
    echo -e "\033[32m""Script help and usage instructions:""\e[0m"
    echo
    #
    ###################################
    ##### Custom Help Info Starts #####
    ###################################
    #
    echo -e "Put your help instructions or script guidance here"
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
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
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
            echo "1) $option1"
            echo "2) $option2"
            echo "3) $option3"
            echo "4) $option4"

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
                                echo -e "[core]\nhost = 0.0.0.0\nport = $appport\nlaunch_browser = 0\nurl_base = /$(whoami)/couchpotato\nusername = $(whoami)\n\n[blackhole]\ndirectory = $HOME/.blackhole\n\n[rtorrent]\nusername = rutorrent\nenabled = 1\nhost = https://$(hostname -f)/$(whoami)/rtorrent/rpc\ndirectory = $HOME/private/rtorrent/data/" > ~/.couchpotato/settings.conf
                                # proxypass start
                                mkdir -p ~/.apache2/conf.d
                                echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /couchpotato http://10.0.0.1:'"$appport"'/${USER}/couchpotato\nProxyPassReverse /couchpotato http://10.0.0.1:'"$appport"'/${USER}/couchpotato' > ~/.apache2/conf.d/couchpototo.conf
                                /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                                if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                                then
                                    echo -en 'location ^~ /couchpotato {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/couchpotato.conf
                                    /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                                fi
                                # proxypass end
                                python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf"  --daemon
                                echo "Visit this URL to finish the set up wizard"
                                echo
                                echo -e "\033[32m""${host2https}couchpotato/""\e[0m"
                                echo
                                echo -e "\033[31m""It may take a few minutes for the program to load properly in the URL." "\033[32m""Pressing F5 in your browser can help.""\e[0m"
                                echo
                                echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                                echo
                            else
                                echo 'The folder ~/.couchpotato already exists. User Option 2 or remove it first'
                                echo
                            fi
                            ;;
                    "2")    
                            if [[ -d ~/.couchpotato ]]
                            then
                                if [[ -f ~/.couchpotato/couchpotato.pid ]]
                                then
                                    kill $(cat ~/.couchpotato/couchpotato.pid)
                                    echo "I need to wait 10 seconds for Couchpotato to shut down."
                                    sleep 10
                                    echo
                                fi
                                cd ~/.couchpotato
                                git pull origin
                                echo
                                python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf" --daemon
                            else
                                echo 'Couchpotato is not installed to ~/.couchpotato'
                                echo
                            fi
                            ;;
                    "3")
                            # Check for the existence of the ~/.nginx/conf.d/000-default-server.d directory so as to echo a relevant statement.
                            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                            then
                                echo "Installing the Apache and Nginx proxypass."
                                echo
                            else
                                echo "Installing the Apache proxypass."
                                echo
                            fi
                            # KIll the couchpotato process via the PID file if it is present.
                            if [[ -f ~/.couchpotato/couchpotato.pid ]]
                            then
                                kill "$(cat ~/.couchpotato/couchpotato.pid)"
                                echo "I need to wait 10 seconds for Couchpotato to shut down."
                                sleep 10
                                echo
                            fi
                            # proxypass starts - Install the Apache and ning proxypasses.
                            mkdir -p ~/.apache2/conf.d
                            echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\n\nProxyPass /couchpotato http://10.0.0.1:'"$proxyport"'/${USER}/couchpotato\nProxyPassReverse /couchpotato http://10.0.0.1:'"$appport"'/${USER}/couchpotato' > ~/.apache2/conf.d/couchpototo.conf
                            /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
                            # The nginx specific section - depends on the existence of the required directories.
                            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
                            then
                                echo -en 'location ^~ /couchpotato {\nproxy_set_header X-Real-IP $remote_addr;\nproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\nproxy_set_header Host $http_x_host;\nproxy_set_header X-NginX-Proxy true;\n\nrewrite /(.*) /'$(whoami)'/$1 break;\nproxy_pass http://10.0.0.1:'"$proxyport"'/;\nproxy_redirect off;\n}' >  ~/.nginx/conf.d/000-default-server.d/couchpotato.conf
                                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
                            fi
                            # proxypass ends
                            #
                            # Start couchpotato again
                            python ~/.couchpotato/CouchPotato.py --config_file="$HOME/.couchpotato/settings.conf" --daemon
                            echo "Visit this URL to use Couchpotato:"
                            echo
                            echo -e "\033[32m""${host2https}couchpotato/""\e[0m"
                            echo
                            echo -e "Couchpotato is running at the PID:$(cat ~/.couchpotato/couchpotato.pid)"
                            echo
                            exit
                            ;;
                    "4")
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
    exit
fi
#
############################
##### Core Script Ends #####
############################
#