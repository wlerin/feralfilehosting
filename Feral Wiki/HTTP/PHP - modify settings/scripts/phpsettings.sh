#!/bin/bash
# php settings
scriptversion="0.0.3"
scriptname="phpsettings"
# randomessence
#
# wget -qO ~/phpsettings http://git.io/hGdl && bash ~/phpsettings
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
############################
### Version History Ends ###
############################
option1="Install Apache php.ini"
option2="Install nginx php.ini"
option3="Quit the Script"
############################
###### Variable Start ######
############################
#
updaterenabled="1"
#
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/PHP%20-%20modify%20settings/scripts/phpsettings.sh"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
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
else
    echo
    echo "The Updater has been disabled"
fi
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
    showMenu () 
    {
            echo "1) $option1"
            echo "2) $option2"
            echo "3) $option3"
            echo
    }

    while [ 1 ]
    do
            showMenu
            read -e CHOICE
            echo
            case "$CHOICE" in
                    "1")
                            cp -f /etc/php5/apache2/php.ini ~/.apache2/php.ini
                            echo -n 'PHPINIDir "${HOME}/.apache2/php.ini"' > ~/.apache2/conf.d/php.conf
                            #
                            sed -i "s|pdo_mysql.default_socket=|pdo_mysql.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            sed -i "s|mysql.default_socket =|mysql.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            sed -i "s|mysqli.default_socket =|mysqli.default_socket = $HOME/private/mysql/socket|g" ~/.apache2/php.ini
                            #
                            /usr/sbin/apache2ctl -k graceful >/dev/null 2>&1
                            echo "Done"
                            echo
                            ;;
                    "2")
                            if [[ -d ~/.nginx ]]
                            then
                                mv -f ~/.nginx/php/php.ini  ~/.nginx/php/php.ini.bak
                                cp -f /etc/php5/fpm/php.ini ~/.nginx/php/php.ini
                                #
                                sed -i "s|pdo_mysql.default_socket=|pdo_mysql.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                sed -i "s|mysql.default_socket =|mysql.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                sed -i "s|mysqli.default_socket =|mysqli.default_socket = $HOME/private/mysql/socket|g" ~/.nginx/php/php.ini
                                #
                                /usr/sbin/apache2ctl -k graceful >/dev/null 2>&1
                                killall php5-fpm >/dev/null 2>&1
                                /usr/sbin/php5-fpm -y $HOME/.nginx/php/fpm.conf >/dev/null 2>&1
                                echo "Done"
                                echo
                            else
                                echo "nginx is not installed. Please update to nginx first."
                                echo
                                echo "Updating Apache to nginx - https://www.feralhosting.com/faq/view?question=231"
                                echo
                            fi
                            ;;
                    "3")
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
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#