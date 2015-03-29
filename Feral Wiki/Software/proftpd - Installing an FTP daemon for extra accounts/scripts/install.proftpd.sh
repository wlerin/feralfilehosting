#!/bin/bash
# proftpd basic setup script
scriptversion="1.2.1"
# Don't foregt to change the conf file size if the configurations are modified.
scriptname="install.proftpd"
proftpdversion="proftpd-1.3.5"
installedproftpdversion=$(cat $HOME/proftpd/.proftpdversion 2> /dev/null)
# randomessence
#
# wget -qO ~/install.proftpd http://git.io/nQJBxw && bash ~/install.proftpd
#
############################
#### Script Notes Start ####
############################
#
# Warning - If you modify the conf files dont forget to modify the related variables in the Variable section
#
############################
##### Script Notes End #####
############################
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
# Disables the built in script updater permanently.
updaterenabled="1"
#
proftpdconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/proftpd.conf"
proftpdconfsize="3701"
sftpconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/sftp.conf"
sftpconfsize="832"
ftpsconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/ftps.conf"
ftpsconfsize="947"
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/scripts/install.proftpd.sh"
#
proftpdurl="https://github.com/feralhosting/proftpd-1.3.5.git"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion=""$scriptversion"-nu"
else
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
        scriptversion=""$scriptversion"-DEV"
    fi
fi
#
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
    if [[ -d "$HOME/proftpd" ]]
    then
        if [[ -f "$HOME"/proftpd/.proftpdversion ]]
        then
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version $installedproftpdversion of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        else
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        fi
        if [[ "$agree2update" =~ ^[Yy]$ ]]
        then
            killall -9 proftpd -u $(whoami) >/dev/null 2>&1
            mkdir -p "$HOME"/proftpd/install_logs
            cd && rm -rf "$proftpdversion"
            git clone -q "$proftpdurl"
            chmod -R 700 "$HOME/$proftpdversion"
            echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
            cd "$HOME/$proftpdversion"
            echo "Starting to 1: configure, 2: make, 3 make install"
            echo
            install_user=$(whoami) install_group=$(whoami) ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
            echo "1: configure complete, moving to 2 of 3"
            make > "$HOME"/proftpd/install_logs/make.log 2>&1
            echo "2: make complete, moving to 3 of 3"
            make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
            echo "3: make install complete, moving to post installation configuration"
            echo
            "$HOME"/proftpd/bin/ftpasswd --group --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.group --gid $(id -g $(whoami)) --member $(whoami) >/dev/null 2>&1
            # Some tidy up
            cd && rm -rf "$proftpdversion"
            chmod 440 ~/proftpd/etc/ftpd{.passwd,.group}
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/sftp.conf >/dev/null 2>&1
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/ftps.conf >/dev/null 2>&1
            echo -e "proftpd sftp and ftps servers were started."
            echo
            exit 1
        elif [[ "$agree2update" =~ ^[Ee]$ ]]
        then
            echo "You chose to exit"
            echo
            exit 1
        else
            read -ep "Are you sure you want to do a full reinstall, all settings, jails and users will be lost? [y]es i am sure or [e]xit: " areyousure
            if [[ "$areyousure" =~ ^[Yy]$ ]]
            then
                killall -9 proftpd -u $(whoami) >/dev/null 2>&1
            else
                echo "You chose to exit"
                echo
                exit 1
            fi
        fi
    fi
    #
    mkdir -p "$HOME"/proftpd/etc/sftp/authorized_keys
    mkdir -p "$HOME"/proftpd/etc/keys
    mkdir -p "$HOME"/proftpd/{ssl,install_logs
    cd && rm -rf "$proftpdversion"
    git clone -q "$proftpdurl"
    chmod -R 700 "$HOME/$proftpdversion"
    echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
    cd "$HOME/$proftpdversion"
    echo -e "\033[32m""About to configure, make and install proftpd. This could take some time to complete. Be patient.""\e[0m"
    echo
    # configure and install
    echo "Starting to 1: configure, 2: make, 3 make install"
    echo
    install_user=$(whoami) install_group=$(whoami) ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
    echo "1: configure complete, moving to 2 of 3"
    make > "$HOME"/proftpd/install_logs/make.log 2>&1
    echo "2: make complete, moving to 3 of 3"
    make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
    echo "3: make install complete, moving to post installation configuration"
    echo
    # Some tidy up
    cd && rm -rf "$proftpdversion"
    # Generate our keyfiles
    ssh-keygen -q -t rsa -f "$HOME"/proftpd/etc/keys/sftp_rsa -N '' && ssh-keygen -q -t dsa -f "$HOME"/proftpd/etc/keys/sftp_dsa -N ''
    echo "rsa keys generated with no passphrase"
    openssl req -new -x509 -nodes -days 365 -subj '/C=GB/ST=none/L=none/CN=none' -newkey rsa:2048 -keyout "$HOME"/proftpd/ssl/proftpd.key.pem -out "$HOME"/proftpd/ssl/proftpd.cert.pem >/dev/null 2>&1
    echo "ssl keys generated"
    echo
    # Get the conf files from github and configure them for this user
    echo "Downloading and configuring the .conf files."
    echo
    until [[ $(stat -c %s ~/proftpd/etc/proftpd.conf 2> /dev/null) -eq "$proftpdconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/proftpd.conf "$proftpdconf"
    done
    until [[ $(stat -c %s ~/proftpd/etc/sftp.conf 2> /dev/null) -eq "$sftpconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/sftp.conf "$sftpconf"
    done
    until [[ $(stat -c %s ~/proftpd/etc/ftps.conf 2> /dev/null) -eq "$ftpsconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/ftps.conf "$ftpsconf"
    done
    # proftpd.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|User my_username|User '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|Group my_username|Group '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|AllowUser my_username|AllowUser '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    # sftp.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/sftp.conf"
    sed -i 's|Port 23001|Port '$(shuf -i 10001-49999 -n 1)'|g' "$HOME/proftpd/etc/sftp.conf"
    echo -e "This is your" "\033[31m""SFTP""\e[0m" "port:" "\033[31m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/sftp.conf)""\e[0m"
    # ftps.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/ftps.conf"
    sed -i 's|Port 23002|Port '$(shuf -i 10001-49999 -n 1)'|g' "$HOME/proftpd/etc/ftps.conf"
    echo
    echo -e "This is your" "\033[32m""FTPS""\e[0m" "port:" "\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/ftps.conf)""\e[0m"
    echo
    echo -e "The basic setup and configuration has been completed." "\033[31m""Please now enter a password for your main, unlimited user""\e[0m"
    echo
    "$HOME"/proftpd/bin/ftpasswd --passwd --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.passwd --uid $(id -u $(whoami)) --gid $(id -g $(whoami)) --home "$HOME"/ --shell /bin/false
    "$HOME"/proftpd/bin/ftpasswd --group --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.group --gid $(id -g $(whoami)) --member $(whoami) >/dev/null 2>&1
    echo
    echo -e "\033[31m""If for some reason the user creation failed, see Step 6 of the FAQ to do this again""\e[0m"
    echo
    echo -e "You have completed Steps 1 through 6. Please continue with the FAQ from Step 7 onwards."
    echo
    echo -e "proftpd was NOT started to allow you to edit the jails in Step 8 of the FAQ as required."
    echo
    echo -e "See Step 9 of the FAQ for how to start proftpd"
    echo
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
