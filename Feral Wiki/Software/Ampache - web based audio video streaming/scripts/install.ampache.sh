#!/bin/bash
# install ampache
scriptversion="1.3.0"
scriptname="install.ampache"
# randomessence
#
# wget -qO ~/install.ampache http://git.io/ED3FAQ && bash ~/install.ampache
#
############################
## Version History Starts ##
############################
#
# v1.2.2 template updated and script tweaks
# v1.2.5 3.7.0 template socket fix for installer and configuration tweaks tested and working.
# v1.2.6 modified transcode template to include path to static ffmpeg so as not to break the script tweaks.
# v1.2.7 changed the default mysql sample bitrate inserted to 320 from 32
# v1.2.8 and user preferences
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
ffmpegfv="https://bitbucket.org/feralhosting/feralfiles/downloads/ffmpeg-2.4.2-64bit-static.zip"
ampacheurl="https://github.com/ampache/ampache/archive/3.7.0.zip"
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
# -f 700 "$HOME/bin/$scriptname"
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
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " -i "y" updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
	mkdir -p ~/.ampache/{ffmpeg,log}
	wget -qO ~/ampache.zip "$ampacheurl"
    unzip -qo ~/ampache.zip
	cp -rf ~/ampache-"$ampacheversion"/. -d ~/www/$(whoami).$(hostname -f)/public_html/ampache
	wget -qO ~/ffmpeg.zip "$ffmpegfv"
	unzip -qo ~/ffmpeg.zip -d ~/.ampache/ffmpeg
	chmod 700 ~/.ampache/ffmpeg/{ffmpeg,ffmpeg-10bit,ffprobe,qt-faststart}
	cd && rm -rf {ampache,ffmpeg}.zip ampache-"$ampacheversion"
	echo "Done downloading and unpacking."
	echo
	# set htaccess memory limit and chmod it to 644
	echo "php_value memory_limit 512M" >> ~/www/$(whoami).$(hostname -f)/public_html/ampache/.htaccess
	chmod 644 ~/www/$(whoami).$(hostname -f)/public_html/ampache/.htaccess
	#
	# edit the template to that the user's default socket it inserted in the installer.
	sed -i 's|<input type="text" class="form-control" id="local_host" name="local_host" value="localhost">|<input type="text" class="form-control" id="local_host" name="local_host" value="<?php echo getenv('\''HOME'\'') . '\''/private/mysql/socket'\''; ?>">|g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/templates/show_install.inc.php
	#
    # URL settings for Valid SSL
    sed -i 's|;http_host = "localhost"|http_host = "'$(hostname -f)'"|g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
    sed -i 's|$web_path = scrub_in(|$web_path = scrub_in('\''/'$(whoami)''\'' . |g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/install.php
    # Changed the inserted sample bitrate
    sed -i "s|'sample_rate','32',|'sample_rate','320',|g" ~/www/$(whoami).$(hostname -f)/public_html/ampache/sql/ampache.sql
    sed -i "s|(-1,19,'32')|(-1,19,'320')|g" ~/www/$(whoami).$(hostname -f)/public_html/ampache/sql/ampache.sql
    #
	# Change some default settings.
	sed -i 's/catalog_video_pattern = "avi|mpg|flv|m4v|webm"/catalog_video_pattern = "avi|mpg|flv|m4v|webm|mkv"/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;memory_limit = 32/memory_limit = 2048/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;debug = "false"/debug = "true"/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's|;log_path = "/var/log/ampache"|log_path = "'"$HOME"'/.ampache/log"|g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;min_bit_rate = 48/min_bit_rate = 192/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	echo "Changed some default settings done"
	echo
	#
	# Change the transcode_cmd to use our custom ffmpeg build.
	sed -i 's|;transcode_cmd = "ffmpeg -i %FILE%"|transcode_cmd = "'"$HOME"'/.ampache/ffmpeg/ffmpeg -i %FILE%\"|g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
    sed -i 's|        $trconfig\['\''transcode_cmd'\''\] = $mode . '\'' -i %FILE%'\'';|        $trconfig\['\''transcode_cmd'\''\] = '\'''"$HOME"'/.ampache/ffmpeg/'\'' . $mode . '\'' -i %FILE%'\'';|g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/lib/install.lib.php
	echo "Changed the transcode_cmd to use our custom ffmpeg build done"
	echo
	#
	# Change some default transcoding settings
	sed -i 's/;transcode_m4a      = allowed/transcode_m4a = allowed/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;transcode_flac     = required/transcode_flac = required/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;transcode_mp3      = allowed/transcode_mp3 = allowed/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_target = mp3/encode_target = mp3/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/encode_args_mp3 = "-vn -b:a %SAMPLE%K -c:a libmp3lame -f mp3 pipe:1"/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
	sed -i 's/;encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/encode_args_ogg = "-vn -b:a %SAMPLE%K -c:a libvorbis -f ogg pipe:1"/g' ~/www/$(whoami).$(hostname -f)/public_html/ampache/config/ampache.cfg.php.dist
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