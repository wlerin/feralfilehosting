#!/bin/bash
# Script name
scriptversion="1.2.0"
scriptname="ampache"
# Author name
#
############################
## Version History Starts ##
############################
#
# How do I customise this updater? 
# 1: scriptversion="0.0.0" replace "0.0.0" with your script version. This will be shown to the user at the current version.
# 2: scriptname="somescript" replace "somescript" with your script name. this will be shown to the user when they first run the script.
# 3: Search and replace all instances of "somescript", 29 including this one, with the name of your script, do not include the .sh aside from doing step 2.
# 4: Then replace ALL "https://raw.github.com/feralhosting" with the URL to the RAW script URL.
# 5: Insert you script in the "Script goes here" labelled section 
#
# This updater deals with updating two files at the same time, the  "~/somescript.sh" and the "~/bin/somescript" . You can remove one part of the updater, if you wish, to focus on a single file instance.
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
ffmpegfv="https://bitbucket.org/feralhosting/feralfiles/downloads/ffmpeg-2.0.1-64bit-static.zip"
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
if [[ ! -f "$HOME/ampache.sh" ]]
then
    wget -qO $HOME/ampache.sh https://raw.github.com/feralhosting
fi
if [[ ! -f "$HOME/bin/ampache" ]]
then
    wget -qO $HOME/bin/ampache https://raw.github.com/feralhosting
fi
#
wget -qO $HOME/000ampache.sh https://raw.github.com/feralhosting
#
if ! diff -q "$HOME/000ampache.sh" "$HOME/ampache.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/ampache.sh https://raw.github.com/feralhosting
    wget -qO $HOME/bin/ampache https://raw.github.com/feralhosting
    bash $HOME/ampache.sh
    exit 1' > $HOME/111ampache.sh
    bash $HOME/111ampache.sh
    exit 1
fi
if ! diff -q "$HOME/000ampache.sh" "$HOME/bin/ampache" > /dev/null 2>&1
then
    echo '#!/bin/bash
    wget -qO $HOME/ampache.sh https://raw.github.com/feralhosting
    wget -qO $HOME/bin/ampache https://raw.github.com/feralhosting
    bash $HOME/ampache.sh
    exit 1' > $HOME/222ampache.sh
    bash $HOME/222ampache.sh
    exit 1
fi
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
#
rm -f $HOME/000ampache.sh $HOME/111ampache.sh $HOME/222ampache.sh
chmod -f 700 $HOME/bin/ampache
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
mkdir -p $HOME/ampache/ffmpeg $HOME/ampache/log
wget -qO $HOME/ampache.zip https://github.com/ampache/ampache/archive/master.zip
unzip -qo $HOME/ampache.zip
cp -rf $HOME/ampache-master/. $HOME/www/$(whoami).$(hostname)/public_html/ampache
wget -qO $HOME/ffmpeg.zip $ffmpegfv
unzip -qo $HOME/ffmpeg.zip -d $HOME/ampache/ffmpeg
chmod 700 ~/ampache/ffmpeg/ffmpeg ~/ampache/ffmpeg/ffmpeg-10bit ~/ampache/ffmpeg/ffprobe ~/ampache/ffmpeg/qt-faststart
rm -rf $HOME/ampache.zip $HOME/ffmpeg.zip $HOME/ampache-master
echo "done downloading and unpacking."
echo
# set htaccess memory limit and chmod it to 644
echo "php_value memory_limit 512M" >> $HOME/www/$(whoami).$(hostname)/public_html/ampache/.htaccess
chmod 644 $HOME/www/$(whoami).$(hostname)/public_html/ampache/.htaccess
#
# edit the template to that the user's default socket it inserted in teh installer.
sed -i 's|<td><input type="text" name="local_host" value="localhost" /></td>|<td><input type="text" name="local_host" value="<?php echo getenv('\''PWD'\'') . '\''/private/mysql/socket'\''; ?>" /></td>|g' $HOME/www/konichiwa.nesoi.feralhosting.com/public_html/ampache/templates/show_install.inc.php
#
# Change some default settings.
sed -i 's/catalog_video_pattern = "avi|mpg|flv|m4v"/catalog_video_pattern = "avi|mpg|flv|m4v|mkv"/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;memory_limit = 32/memory_limit = 2048/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;debug = "false"/debug = "true"/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's|;log_path = "/var/log/ampache"|log_path = "'$HOME'/ampache/log"|g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;min_bit_rate = 48/min_bit_rate = 192/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
echo "Changed some default settings done"
echo
#
# Change the transcode_cmd to use our custom ffmpeg build.
sed -i 's|;transcode_cmd = "ffmpeg -i %FILE%"|transcode_cmd = "'$HOME'/ampache/ffmpeg/ffmpeg -i %FILE%\"|g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
echo "Changed the transcode_cmd to use our custom ffmpeg build done"
echo
#
# Change some default transcoding settings
sed -i 's/;transcode_m4a      = allowed/transcode_m4a = allowed/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;transcode_flac     = required/transcode_flac = required/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;transcode_mp3      = allowed/transcode_mp3 = allowed/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;encode_target = mp3/encode_target = mp3/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
sed -i 's/;encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/g' $HOME/www/$(whoami).$(hostname)/public_html/ampache/config/ampache.cfg.php.dist
echo "Enabled transcoding done"
echo
### Enable transcoding.
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