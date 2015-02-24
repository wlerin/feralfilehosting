#!/bin/bash
# Install Wordpress
scriptversion="1.0.3"
scriptname="install.wordpress"
# randomessence
#
# wget -qO ~/install.wordpress.sh http://git.io/2JBQlg && bash ~/install.wordpress.sh
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
    if [ ! -d "$HOME/www/$(whoami).$(hostname -f)/public_html/wordpress" ]
    then
        echo -e "Downloading and extracting latest version to:"
        echo
        echo -e "\033[32m""https://$(hostname -f)/$(whoami)/wordpress/""\e[0m"
        echo
        wget -qO "$HOME"/latest.tar.gz "$wordpressurl"
        tar xf "$HOME"/latest.tar.gz -C "$HOME"/www/$(whoami).$(hostname -f)/public_html
        # insert user socket path instead of localhost
        sed -i 's|<td><input name="dbhost" id="dbhost" type="text" size="25" value="localhost" /></td>|<td><input name="dbhost" id="dbhost" type="text" size="25" value="<?php echo  '\'':'\'' . getenv('\''HOME'\'') . '\''/private/mysql/socket'\''; ?>" /></td>|g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/wordpress/wp-admin/setup-config.php
        #
        cd && rm -f "$HOME"/latest.tar.gz
        echo -e "Done: Visit your WWW/wordpress to complete the installation."
        echo
    else
        echo -e "The wordpress directory already exists."
        read -ep "Do you want to overwrite it anyway? [y] yes or [n] no : " confirm
        echo
        if [[ "$confirm" =~ ^[Yy]$ ]]
        then
            echo -e "Downloading and extracting latest version to:"
            echo
            echo -e "\033[32m""https://$(hostname -f)/$(whoami)/wordpress/""\e[0m"
            echo
            wget -qO "$HOME"/latest.tar.gz "$wordpressurl"
            tar xf "$HOME"/latest.tar.gz -C "$HOME"/www/$(whoami).$(hostname -f)/public_html
            # insert user socket path instead of localhost
            sed -i 's|<td><input name="dbhost" id="dbhost" type="text" size="25" value="localhost" /></td>|<td><input name="dbhost" id="dbhost" type="text" size="25" value="<?php echo  '\'':'\'' . getenv('\''HOME'\'') . '\''/private/mysql/socket'\''; ?>" /></td>|g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/wordpress/wp-admin/setup-config.php
            #
            cd && rm -f "$HOME"/latest.tar.gz
            echo -e "Done: Visit your WWW/wordpress to complete the installation."
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