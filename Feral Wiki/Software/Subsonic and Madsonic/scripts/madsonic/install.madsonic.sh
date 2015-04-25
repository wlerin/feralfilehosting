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
# wget -qO ~/install.madsonic http://git.io/Eq97bg && bash ~/install.madsonic
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
##
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
    echo 'v2.0.0 - Templater update - minor script tweaks'
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
scriptversion="2.0.0"
#
# Script name goes here. Please prefix with install.
scriptname="install.madsonic"
#
# Author name goes here.
scriptauthor="None credited"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/Eq97bg"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Subsonic%20and%20Madsonic/scripts/madsonic/install.madsonic.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass="$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)"
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport="$(shuf -i 10001-49999 -n 1)"
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport="$(shuf -i 10001-49999 -n 1)"; done
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
makeissue=".makeissue $scriptname A description of the issue"
ticketurl="https://www.feralhosting.com/manager/tickets/new"
gitissue="https://github.com/feralhosting/feralfilehosting/issues/new"
#
############################
## Custom Variables Start ##
############################
#
madsonicversion="5.1 Build 5200"
javaversion="1.8 Update 45"
jvdecimal="1.8.0_45"
#
# Defines the memory variable
initmemory="2048"
maxmemory="2048"
#
# Gets the Java version from the last time this script installed Java
installedjavaversion="$(cat ~/.javaversion 2> /dev/null)"
#
# Java URL
javaupdatev="http://javadl.sun.com/webapps/download/AutoDL?BundleId=106240"
#
# Madsonic Standalone files
madsonicfv="https://bitbucket.org/feralhosting/feralfiles/downloads/5.1.5200-standalone.zip"
madsonicfvs="5.1.5200-standalone.zip"
#
# ffmpeg files
mffmpegfvc="https://bitbucket.org/feralhosting/feralfiles/downloads/sonic.ffmpeg.17.10.2014.zip"
mffmpegfvcs="sonic.ffmpeg.17.10.2014.zip"
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
example () {
    echo "This is my example function"
}
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
    echo -e "These are the recommended ways to report bugs for scripts in the FAQs:"
    echo
    echo -e "1: In IRC you can use wikibot to create a github issue by using this command format:"
    echo
    echo -e "\033[36m""$makeissue""\e[0m"
    echo
    echo -e "2: You could open a ticket describing the problem with details of which script and what the problem is."
    echo
    echo -e "\033[36m""$ticketurl""\e[0m"
    echo
    echo -e "3: You can create an issue directly on github using your github account."
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
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, which would reset the option, it will then find this file and set it back.
if [[ ! -z "$1" && "$1" = 'qr' ]] || [[ ! -z "$2" && "$2" = 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z "$1" && "$1" = 'nu' ]] || [[ ! -z "$2" && "$2" = 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq "1" ]]
    then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        #
        wget -qO ~/.000"$scriptname" "$scripturl"
        #
        if [[ "$(sha256sum ~/.000"$scriptname" | awk '{print $1}')" != "$(sha256sum ~/bin/"$scriptname" | awk '{print $1}')" ]]
        then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
            bash ~/.111"$scriptname"
            exit
        else
            if [[ -z "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" && "$(pgrep -fu "$(whoami)" "bash $HOME/bin/$scriptname")" -ne "$$" ]]
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
if [[ "$updatestatus" = "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    echo -e "The version of the" "\033[33m""Madsonic""\e[0m" "server being used in this script is:" "\033[31m""$madsonicversion""\e[0m"
    echo -e "The version of the" "\033[33m""Java""\e[0m" "being used in this script is:" "\033[31m""$javaversion""\e[0m"
    echo
    if [[ -f "$HOME/private/madsonic/.version" ]]
    then
        echo -e "Your currently installed version is:" "\033[32m""$(sed -n '1p' $HOME/private/madsonic/.version)""\e[0m"
        echo
    fi
fi
#
#############################
#### madsonicrsk starts  ####
#############################
#
# This section MUST be escaped properly using backslash when adding to it. If you need to see it uncommented, run this script in SSH. It will create the working, uncommented version at ~/bin/madsonicrsk
echo -e "#!/bin/bash
if [[ -d ~/private/madsonic ]]
then
    #
    httpport=\$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)
    #
    # v 1.2.0  Kill Start Restart Script generated by the Madsonic installer script
    #
    echo
    echo -e \"\\\033[33m1:\\\e[0m This is the process PID:\\\033[32m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m used the last time \\\033[36m~/private/madsonic/madsonic.sh\\\e[0m was started.\"
    echo
    echo -e \"\\\033[33m2:\\\e[0m This is the URL that Madsonic is configured to use:\"
    echo
    echo -e \"\\\033[31mMadsonic\\\e[0m last accessible at \\\033[31mhttps://\$(hostname -f)/\$(whoami)/madsonic/\\\e[0m\"
    echo
    echo -e \"\\\033[33m3:\\\e[0m Running instances checks:\"
    echo
    echo -e \"Checking to see, specifically, if the \\\033[32m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m is running\"
    echo -e \"\\\033[32m\"
    if [[ -z \"\$(ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
    then
        echo -e \"Nothing to show.\"
        echo -e \"\\\e[0m\"
    else
        ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
        echo -e \"\\\e[0m\"
    fi
    if [[ \"\$(ps -U \$(whoami) | grep -c java)\" -gt \"1\" ]]
    then
        echo -e \"There are currently \\\033[31m\$(ps -U \$(whoami) | grep -c java 2> /dev/null)\\\e[0m running Java processes.\"
        echo -e \"\\\033[31mWarning:\\\e[0m \\\033[32mMadsonic might not load or be unpredicatable with multiple instances running.\\\e[0m\"
        echo -e \"\\\033[33mIf there are multiple Madsonic processes please use the killall by using option [a] then use the restart option.\\\e[0m\"
        echo -e \"\\\033[31m\"
        ps -U \$(whoami) | grep java
        echo -e \"\\\e[0m\"
    fi
    echo -e \"\\\033[33m4:\\\e[0m Options for killing and restarting Madsonic:\"
    echo
    echo -e \"\\\033[36mKill PID only\\\e[0m \\\033[31m[y]\\\e[0m \\\033[36mKillall java processes\\\e[0m \\\033[31m[a]\\\e[0m \\\033[36mSkip to restart (where you can quit the script)\\\e[0m \\\033[31m[r]\\\e[0m\"
    echo
    read -ep \"Please press one of these options [y] or [a] or [r] and press enter: \"  confirm
    echo
    if [[ \$confirm =~ ^[Yy]\$ ]]
    then
        kill \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) 2> /dev/null
        echo -e \"The process PID:\\\033[31m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m that was started by the installer or custom scripts has been killed.\"
        echo
        echo -e \"Checking to see if the PID:\\\033[32m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m is running:\\\e[0m\"
        echo -e \"\\\033[32m\"
        if [[ -z \"\$(ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
        then
            echo -e \"Nothing to show, job done.\"
            echo -e \"\\\e[0m\"
        else
            ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
            echo -e \"\\\e[0m\"
        fi
    elif [[ \$confirm =~ ^[Aa]\$ ]]
    then
        killall -9 -u \$(whoami) java 2> /dev/null
        echo -e \"\\\033[31mAll java processes have been killed\\\e[0m\"
        echo
        echo -e \"\\\033[33mChecking for open java processes:\\\e[0m\"
        echo -e \"\\\033[32m\"
        if [[ -z \"\$(ps -U \$(whoami) | grep java 2> /dev/null)\" ]]
        then
            echo -e \"Nothing to show, job done.\"
            echo -e \"\\\e[0m\"
        else
            ps -U \$(whoami) | grep java
            echo -e \"\\\e[0m\"
        fi
    else
        echo -e \"Skipping to restart or quit\"
        echo
    fi
    if [[ -f ~/private/madsonic/madsonic.sh ]]
    then
        read -ep \"Would you like to restart Madsonic? [r] reload the kill features? [l] or quit the script? [q]: \"  confirm
        echo
        if [[ \$confirm =~ ^[Rr]\$ ]]
        then
            if [[ -z \"\$(ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
            then
                bash ~/private/madsonic/madsonic.sh
                echo -e \"Started Madsonic at PID:\\\033[31m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m\"
                echo
                echo -e \"\\\033[31mMadsonic\\\e[0m last accessible at \\\033[31mhttps://\$(hostname -f)/\$(whoami)/madsonic/\\\e[0m\"
                echo -e \"\\\033[32m\"
                if [[ -z \"\$(ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null)\" ]]
                then
                    echo -e \"Nothing to show, job done.\"
                    echo -e \"\\\e[0m\"
                else
                    ps -p \$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) --no-headers 2> /dev/null
                    echo -e \"\\\e[0m\"
                fi
                exit
            else
                echo -e \"Madsonic with the PID:\\\033[32m\$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)\\\e[0m is already running. Kill it first then restart\"
                echo
                read -ep \"Would you like to restart the RSK script and reload it? [y] or quit the script? [q] : \"  confirmrsk
                echo
                if [[ \$confirmrsk =~ ^[Yy]\$ ]]
                then
                    bash ~/bin/madsonicrsk
                fi
                exit
            fi
        elif [[ \$confirm =~ ^[Ll]\$ ]]
        then
            echo -e \"\\\033[31mReloading madsonicrsk to access kill features.\\\e[0m\"
            echo
            bash ~/bin/madsonicrsk
        else
            echo This script has done its job and will now exit.
            echo
            exit
        fi
    else
        echo
        echo -e \"The \\\033[31m~/private/madsonic/madsonic.sh\\\e[0m does not exist.\"
        echo -e \"please run the \\\033[31m~/install.madsonic\\\e[0m to install and configure madsonic\"
        exit
    fi
else
    echo -e \"Madsonic is not installed\"
fi" > ~/bin/madsonicrsk
#
#############################
##### madsonicrsk ends  #####
#############################
#
#############################
#### madsonicron starts  ####
#############################
#
echo '#!/bin/bash
echo "$(date +"%H:%M on the %d.%m.%y")" >> madsonicrun.log
if [[ -z "$(ps -p $(cat ~/private/madsonic/madsonic.sh.PID) --no-headers)" ]]
then
    bash ~/private/madsonic/madsonic.sh
else
    exit
fi' > ~/bin/madsonicron
#
#############################
##### madsonicron ends  #####
#############################
#
# Make the ~/bin/madsonicrsk and ~/bin/madsonicron files we created executable
chmod -f 700 ~/bin/madsonicrsk
chmod -f 700 ~/bin/madsonicron
#
#############################
##### proxypass starts  #####
#############################
#
# Apache proxypass
if [[ -f ~/private/madsonic/madsonic.sh ]]
then
    mkdir -p ~/.apache2/conf.d
    echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /madsonic http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/${USER}/madsonic\nProxyPassReverse /madsonic http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/${USER}/madsonic\nRedirect /${USER}/madsonic https://${APACHE_HOSTNAME}/${USER}/madsonic' > "$HOME/.apache2/conf.d/madsonic.conf"
    /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
    # Nginx proxypass
    if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
    then
        mkdir -p ~/.nginx/proxy
        echo -e 'location /madsonic {\n\nproxy_temp_path '"$HOME"'/.nginx/proxy;\n\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /madsonic/(.*) /'$(whoami)'/madsonic/$1 break;\nproxy_pass http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/'$(whoami)'/madsonic/;\nproxy_redirect http:// https://;\n\n}' > ~/.nginx/conf.d/000-default-server.d/madsonic.conf
        /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
    fi
    echo -e "The" "\033[36m""nginx/apache proxypass""\e[0m" "has been installed."
    echo
    echo -e "Madsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/madsonic/""\e[0m"
    echo
fi
#
#############################
###### proxypass ends  ######
#############################
#
if [[ "$updatestatus" == "y" ]]
then
    :
else
    echo -e "The" "\033[36m""~/bin/madsonicrsk""\e[0m" "has been updated."
    echo
    read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " -i "y" updatestatus
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
    mkdir -p ~/private
    #
    #############################
    #### Install Java Start  ####
    #############################
    #
    if [[ ! -f ~/bin/java && -f ~/.javaversion ]]
    then
        cd && rm -f ~/.javaversion
        export installedjavaversion=""
    fi
    if [[ "$installedjavaversion" != "$javaversion" ]]
    then
        echo "Please wait a moment while java is installed"
        echo
        rm -rf ~/private/java
        wget -qO ~/java.tar.gz "$javaupdatev"
        tar xf ~/java.tar.gz --strip-components=1 -C ~/
        rm -f ~/java.tar.gz
        echo -n "$javaversion" > ~/.javaversion
        rm -f {Welcome.html,THIRDPARTYLICENSEREADME-JAVAFX.txt,THIRDPARTYLICENSEREADME.txt,release,README,LICENSE,COPYRIGHT}
        echo -e "\033[31m""Important:""\e[0m" "Java" "\033[32m""$javaversion""\e[0m" "has been installed to" "\033[36m""$HOME/""\e[0m"
        if [[ -f ~/private/madsonic/madsonic.sh.PID ]]
        then
            kill $(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) 2> /dev/null
            bash ~/private/madsonic/madsonic.sh
        fi
        echo
    fi
    #
    #############################
    ##### Install Java End  #####
    #############################
    #
    if [[ ! -d ~/private/madsonic ]]
    then
        echo -e "Congratulations," "\033[31m""Java is installed""\e[0m"". Continuing with the installation."
        echo
        echo -e "Path" "\033[36m""~/private/madsonic/""\e[0m" "created. Moving to next step."
        mkdir -p ~/sonictmp
        mkdir -p ~/private/madsonic/transcode
        mkdir -p ~/private/madsonic/Incoming
        mkdir -p ~/private/madsonic/Podcast
        mkdir -p ~/private/madsonic/playlist/{import,export,backup}
        echo -n "$madsonicfvs" > ~/private/madsonic/.version
        echo
        echo -e "\033[32m""$madsonicfvs""\e[0m" "Is downloading now."
        wget -qO ~/sonictmp/madsonic.zip "$madsonicfv"
        echo -e "\033[36m""$madsonicfvs""\e[0m" "Has been downloaded and renamed to" "\033[36m""madsonic.zip\e[0m"
        echo -e "\033[36m""madsonic.zip""\e[0m" "Is unpacking now."
        unzip -qo ~/sonictmp/madsonic.zip -d ~/private/madsonic
        echo -e "\033[36m""madsonic.zip""\e[0m" "Has been unpacked to" "\033[36m""~/private/madsonic/\e[0m"
        echo
        echo -e "\033[32m""$mffmpegfvcs""\e[0m" "Is downloading now."
        wget -qO ~/sonictmp/ffmpeg.zip "$mffmpegfvc"
        echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Has been downloaded and renamed to" "\033[36m""ffmpeg.tar.gz\e[0m"
        echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Is being unpacked now."
        unzip -qo ~/sonictmp/ffmpeg.zip -d ~/private/madsonic/transcode/
        chmod -f 700 ~/private/madsonic/transcode/{Audioffmpeg,ffmpeg,lame,xmp}
        echo -e "\033[36m""$mffmpegfvcs""\e[0m" "Has been unpacked to" "\033[36m~/private/madsonic/transcode/\e[0m"
        rm -rf ~/sonictmp
        echo
        echo -e "\033[32m""Copying over a local version of lame.""\e[0m"
        # cp -f /usr/local/bin/lame ~/private/madsonic/transcode/ 2> /dev/null
        chmod -f 700 ~/private/madsonic/transcode/lame
        echo -e "Lame copied to" "\033[36m""~/private/madsonic/transcode/\e[0m"
        echo
        echo -e "\033[32m""Copying over a local version of Flac.""\e[0m"
        cp -f /usr/bin/flac ~/private/madsonic/transcode/ 2> /dev/null
        chmod -f 700 ~/private/madsonic/transcode/flac
        echo -e "Flac copied to" "\033[36m""~/private/madsonic/transcode/""\e[0m"
        echo
        echo -e "\033[31m""Configuring the start-up script.""\e[0m"
        echo -e "\033[35m""User input is required for this next step:""\e[0m"
        echo -e "\033[33m""Note on user input:""\e[0m" "It is OK to use a relative path like:" "\033[33m""~/private/rtorrent/data""\e[0m"
        #
        sed -i 's|MADSONIC_HOME=/var/madsonic|MADSONIC_HOME=~/private/madsonic|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i "s/MADSONIC_PORT=4040/MADSONIC_PORT=$appport/g" ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i 's|MADSONIC_CONTEXT_PATH=/|MADSONIC_CONTEXT_PATH=/$(whoami)/madsonic|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i "s/MADSONIC_INIT_MEMORY=192/MADSONIC_INIT_MEMORY=$initmemory/g" ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i "s/MADSONIC_MAX_MEMORY=384/MADSONIC_MAX_MEMORY=$maxmemory/g" ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i '0,/MADSONIC_PIDFILE=/s|MADSONIC_PIDFILE=|MADSONIC_PIDFILE=~/private/madsonic/madsonic.sh.PID|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        #
        read -ep "Enter the path to your media or leave blank and press enter to skip: " path
        #
        sed -ri "s@MADSONIC_DEFAULT_MUSIC_FOLDER=(.*)@MADSONIC_DEFAULT_MUSIC_FOLDER=$(echo $path | sed -e 's#/$##')@g" ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -ri 's|MADSONIC_DEFAULT_UPLOAD_FOLDER=(.*)|MADSONIC_DEFAULT_UPLOAD_FOLDER=~/private/madsonic/Incoming|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -ri 's|MADSONIC_DEFAULT_PODCAST_FOLDER=(.*)|MADSONIC_DEFAULT_PODCAST_FOLDER=~/private/madsonic/Podcast|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -ri 's|MADSONIC_DEFAULT_PLAYLIST_IMPORT_FOLDER=(.*)|MADSONIC_DEFAULT_PLAYLIST_IMPORT_FOLDER=~/private/madsonic/playlist/import|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -ri 's|MADSONIC_DEFAULT_PLAYLIST_EXPORT_FOLDER=(.*)|MADSONIC_DEFAULT_PLAYLIST_EXPORT_FOLDER=~/private/madsonic/playlist/export|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -ri 's|MADSONIC_DEFAULT_PLAYLIST_BACKUP_FOLDER=(.*)|MADSONIC_DEFAULT_PLAYLIST_BACKUP_FOLDER=~/private/madsonic/playlist/backup|g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i 's/quiet=0/quiet=1/g' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i "23 i export LC_ALL=en_GB.UTF-8\n" ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i '23 i export LANG=en_GB.UTF-8' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        sed -i '23 i export LANGUAGE=en_GB.UTF-8' ~/private/madsonic/madsonic.sh > /dev/null 2>&1
        # Apache proxypass
        mkdir -p ~/.apache2/conf.d
        echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /madsonic http://10.0.0.1:'"$appport"'/${USER}/madsonic\nProxyPassReverse /madsonic http://10.0.0.1:'"$appport"'/${USER}/madsonic\nRedirect /${USER}/madsonic https://${APACHE_HOSTNAME}/${USER}/madsonic' > "$HOME/.apache2/conf.d/madsonic.conf"
        /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
        echo
        # Nginx proxypass
        if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
        then
            mkdir -p ~/.nginx/proxy
            echo -e 'location /madsonic {\n\nproxy_temp_path '"$HOME"'/.nginx/proxy;\n\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /madsonic/(.*) /'$(whoami)'/madsonic/$1 break;\nproxy_pass http://10.0.0.1:'"$appport"'/'$(whoami)'/madsonic/;\nproxy_redirect http:// https://;\n\n}' > ~/.nginx/conf.d/000-default-server.d/madsonic.conf
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
        fi
        echo -e "\033[31m""Start-up script successfully configured.""\e[0m"
        echo "Executing the start-up script now."
        bash ~/private/madsonic/madsonic.sh
        echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/madsonicrsk""\e[0m"
        echo -e "\033[32m""Madsonic is now started, use the links below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
        echo
        echo -e "Madsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/madsonic/""\e[0m"
        echo -e "It may take a minute or two to load properly."
        echo
        echo -e "Madsonic started at PID:" "\033[31m""$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)""\e[0m"
        echo
        bash
        exit
    else
        echo -e "\033[31m""Madsonic appears to already be installed.""\e[0m" "Please kill the PID:" "\033[33m""$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)""\e[0m" "if it is running and delete the" "\033[36m""~/private/madsonic directory""\e[0m"
        echo
        read -ep "Would you like me to kill the process and remove the directories for you? [y] or update your installation [u] quit now [q]: "  confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
            echo "Killing the process and removing files."
            kill $(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) 2> /dev/null
            echo -e "\033[31m" "Done""\e[0m"
            echo "Removing ~/private/madsonic"
            rm -rf ~/private/madsonic
            echo -e "\033[31m" "Done""\e[0m"
            echo "Removing RSK scripts if present."
            rm -f ~/bin/madsonic.4.8
            rm -f ~/madsonic.4.8.sh
            rm -f ~/madsonicstart.sh
            rm -f ~/madsonicrestart.sh
            rm -f ~/madsonickill.sh
            rm -f ~/madsonicrsk.sh
            rm -f ~/bin/madsonicrsk
            rm -f ~/bin/madsonicron
            rm -f ~/.nginx/conf.d/000-default-server.d/madsonic.conf
            rm -f ~/.apache2/conf.d/madsonic.conf
            /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
            /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            echo -e "\033[31m" "Done""\e[0m"
            echo "Finalising removal."
            rm -rf ~/private/madsonic
            echo -e "\033[31m" "Done and Done""\e[0m"
            echo
            read -ep "Would you like you relaunch the installer [y] or quit [q]: " -i "y" confirm
            echo
            if [[ "$confirm" =~ ^[Yy]$ ]]
            then
                echo -e "\033[32m""Relaunching the installer.""\e[0m"
                if [[ -f ~/bin/"$scriptname" ]] 
                then
                    bash ~/bin/"$scriptname"
                else
                    wget -qO ~/bin/"$scriptname" "$scripturl"
                    bash ~/bin/"$scriptname"
                fi
            else
                exit
            fi
        elif [[ "$confirm" =~ ^[Uu]$ ]]
        then
            echo -e "Madsonic is being updated. This will only take a moment."
            kill $(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null) 2> /dev/null
            mkdir -p ~/sonictmp
            wget -qO ~/madsonic.zip "$madsonicfv"
            unzip -qo ~/madsonic.zip -d ~/sonictmp
            rm -f ~/sonictmp/madsonic.sh
            cp -rf ~/sonictmp/. ~/private/madsonic/
            wget -qO ~/ffmpeg.zip "$mffmpegfvc"
            unzip -qo ~/ffmpeg.zip -d ~/private/madsonic/transcode
            chmod -f 700 ~/private/madsonic/transcode/{Audioffmpeg,ffmpeg,lame,xmp}
            echo -n "$madsonicfvs" > ~/private/madsonic/.version
            rm -rf ~/madsonic.zip ~/ffmpeg.zip ~/sonictmp
            sed -i 's|^MADSONIC_CONTEXT_PATH=/$|MADSONIC_CONTEXT_PATH=/$(whoami)/madsonic|g' ~/private/madsonic/madsonic.sh
            # Apache proxypass
            mkdir -p ~/.apache2/conf.d
            echo -en 'Include /etc/apache2/mods-available/proxy.load\nInclude /etc/apache2/mods-available/proxy_http.load\nInclude /etc/apache2/mods-available/headers.load\nInclude /etc/apache2/mods-available/ssl.load\n\nProxyRequests Off\nProxyPreserveHost On\nProxyVia On\nSSLProxyEngine on\n\nProxyPass /madsonic http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/${USER}/madsonic\nProxyPassReverse /madsonic http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/${USER}/madsonic\nRedirect /${USER}/madsonic https://${APACHE_HOSTNAME}/${USER}/madsonic' > "$HOME/.apache2/conf.d/madsonic.conf"
            /usr/sbin/apache2ctl -k graceful > /dev/null 2>&1
            echo
            # Nginx proxypass
            if [[ -d ~/.nginx/conf.d/000-default-server.d ]]
            then
                mkdir -p ~/.nginx/proxy
                echo -e 'location /madsonic {\n\nproxy_temp_path '"$HOME"'/.nginx/proxy;\n\nproxy_set_header        Host            $http_x_host;\nproxy_set_header        X-Real-IP       $remote_addr;\nproxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;\nrewrite /madsonic/(.*) /'$(whoami)'/madsonic/$1 break;\nproxy_pass http://10.0.0.1:'$(sed -n -e 's/MADSONIC_PORT=\([0-9]\+\)/\1/p' ~/private/madsonic/madsonic.sh 2> /dev/null)'/'$(whoami)'/madsonic/;\nproxy_redirect http:// https://;\n\n}' > ~/.nginx/conf.d/000-default-server.d/madsonic.conf
                /usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
            fi
            bash ~/private/madsonic/madsonic.sh
            echo -e "A restart/start/kill script has been created at:" "\033[35m""~/bin/madsonicrsk""\e[0m"
            echo -e "\033[32m""Madsonic is now started, use the link below to access it. Don't forget to set path to FULL path to you music folder in the gui.""\e[0m"
            echo
            echo -e "Madsonic is accessible at:" "\033[32m""https://$(hostname -f)/$(whoami)/madsonic/""\e[0m"
            echo -e "It may take a minute or two to load properly."
            echo
            echo -e "Madsonic started at PID:" "\033[31m""$(cat ~/private/madsonic/madsonic.sh.PID 2> /dev/null)""\e[0m"
            echo
            bash
            exit
        else
            echo "You chose to quit and exit the script"
            echo
            exit
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
    exit
fi
#
############################
##### Core Script Ends #####
############################
#