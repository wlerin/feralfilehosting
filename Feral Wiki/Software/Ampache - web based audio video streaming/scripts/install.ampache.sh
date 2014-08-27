#!/bin/bash
# install ampache
scriptversion="1.2.5"
scriptname="install.ampache"
# randomessence
#
# wget -qO ~/install.ampache.sh http://git.io/ED3FAQ && bash ~/install.ampache.sh
#
############################
## Version History Starts ##
############################
#
# v1.2.2 template updated and script tweaks
# v1.2.5 3.7.0 template socket fix for installer and configuration tweaks tested and working.
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Ampache%20-%20web%20based%20audio%20video%20streaming/scripts/install.ampache.sh"
ffmpegfv="https://bitbucket.org/feralhosting/feralfiles/downloads/ffmpeg-2.3.2-64bit-static.zip"
ampacheurl="https://github.com/ampache/ampache/archive/master.zip"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p "$HOME/bin"
#
if [[ ! -f "$HOME/$scriptname.sh" ]]
then
    wget -qO "$HOME/$scriptname.sh" "$scripturl"
fi
if [[ ! -f "$HOME/bin/$scriptname" ]]
then
    wget -qO "$HOME/bin/$scriptname" "$scripturl"
fi
#
wget -qO "$HOME/000$scriptname.sh" "$scripturl"
#
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/111$scriptname.sh"
    bash "$HOME/111$scriptname.sh"
    exit 1
fi
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/222$scriptname.sh"
    bash "$HOME/222$scriptname.sh"
    exit 1
fi
cd && rm -f {000,111,222}"$scriptname.sh"
chmod -f 700 "$HOME/bin/$scriptname"
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
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
	mkdir -p ~/ampache/{ffmpeg,log}
	wget -qO ~/ampache.zip "$ampacheurl"
	unzip -qo ~/ampache.zip
	cp -rf ~/ampache-master/. ~/www/$(whoami).$(hostname -f)/public_html/ampache
	wget -qO ~/ffmpeg.zip "$ffmpegfv"
	unzip -qo ~/ffmpeg.zip -d "$HOME"/ampache/ffmpeg
	chmod 700 ~/ampache/ffmpeg/{ffmpeg,ffmpeg-10bit,ffprobe,qt-faststart}
	cd && rm -rf {ampache,ffmpeg}.zip ampache-master
	echo "Done downloading and unpacking."
	echo
	# set htaccess memory limit and chmod it to 644
	echo "php_value memory_limit 512M" >> "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/.htaccess
	chmod 644 "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/.htaccess
	#
	# edit the template to that the user's default socket it inserted in the installer.
	sed -i 's|<input type="text" class="form-control" id="local_host" name="local_host" value="localhost">|<input type="text" class="form-control" id="local_host" name="local_host" value="<?php echo getenv('\''HOME'\'') . '\''/private/mysql/socket'\''; ?>">|g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/templates/show_install.inc.php
	#
	# Change some default settings.
	sed -i 's/catalog_video_pattern = "avi|mpg|flv|m4v|webm"/catalog_video_pattern = "avi|mpg|flv|m4v|webm|mkv"/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;memory_limit = 32/memory_limit = 2048/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;debug = "false"/debug = "true"/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's|;log_path = "/var/log/ampache"|log_path = "'"$HOME"'/ampache/log"|g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;min_bit_rate = 48/min_bit_rate = 192/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	echo "Changed some default settings done"
	echo
	#
	# Change the transcode_cmd to use our custom ffmpeg build.
	sed -i 's|;transcode_cmd = "ffmpeg -i %FILE%"|transcode_cmd = "'"$HOME"'/ampache/ffmpeg/ffmpeg -i %FILE%\"|g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	echo "Changed the transcode_cmd to use our custom ffmpeg build done"
	echo
	#
	# Change some default transcoding settings
	sed -i 's/;transcode_m4a      = allowed/transcode_m4a = allowed/g' "$HOME/"www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;transcode_flac     = required/transcode_flac = required/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;transcode_mp3      = allowed/transcode_mp3 = allowed/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_target = mp3/encode_target = mp3/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/g' "$HOME"/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	echo "Enabled transcoding done"
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