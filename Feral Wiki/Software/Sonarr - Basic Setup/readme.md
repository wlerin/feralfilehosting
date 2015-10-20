
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH Guide - The Basics](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Installing Mono and then Sonarr
---

Use this command to create the `~/bin` directory and reload your shell for this change to take effect.

~~~
mkdir -p ~/bin && bash
~~~

Then you need to install `libtool`

~~~
wget -qO ~/libtool.tar.gz http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
tar xf ~/libtool.tar.gz && cd ~/libtool-2.4.6
./configure --prefix=$HOME && make && make install && cd && rm -rf libtool{-2.4.6,.tar.gz}
~~~

Then you can install mono locally:

> **Important notes:** mono takes a long time to install. Once you do the last command expect to wait up to 20 minutes for the process to complete.

~~~
wget -qO ~/mono.tar.gz http://download.mono-project.com/sources/mono/mono-4.2.1.36.tar.bz2
tar xf ~/mono.tar.gz && cd ~/mono-4.2.1
./autogen.sh --prefix="$HOME" && make get-monolite-latest
make && make install && cd && rm -rf mono{-4.2.1,.tar.gz}
~~~

Then install and run Sonarr/NzbDrone:

~~~
wget -qO ~/NzbDrone.tar.gz http://update.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz
tar xf ~/NzbDrone.tar.gz
mkdir -p ~/.config/NzbDrone
wget -qO ~/.config/NzbDrone/config.xml http://git.io/vcCvh
sed -i 's|<Port>8989</Port>|<Port>'$(shuf -i 10001-32001 -n 1)'</Port>|g' ~/.config/NzbDrone/config.xml
sed -i 's|<UrlBase></UrlBase>|<UrlBase>/'"$(whoami)"'/sonarr</UrlBase>|g' ~/.config/NzbDrone/config.xml
~~~

This will now be the URL you need to connect until you activate the proxypass.

~~~
echo -e "\nhttp://$(hostname -f):$(sed -rn 's|(.*)<Port>(.*)</Port>|\2|p' ~/.config/NzbDrone/config.xml)/$(whoami)/sonarr/\n"
~~~

Start Sonarr

~~~
screen -dmS sonarr mono --debug ~/NzbDrone/NzbDrone.exe
~~~

Attach to this screen at any time by using this command:

~~~
screen -r sonarr
~~~

Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

Configuration
---

You configuration will be saved here:

~~~
~/.config/NzbDrone/config.xml
~~~

Change the port manually:

~~~
sed -i 's|<Port>8989</Port>|<Port>'$(shuf -i 10001-32001 -n 1)'</Port>|g' ~/.config/NzbDrone/config.xml
~~~

Read the  port:

~~~
sed -rn 's|(.*)<Port>(.*)</Port>|\2|p' ~/.config/NzbDrone/config.xml
~~~

Proxypass
---

### Apache - Run these commands:

~~~
wget -qO ~/.apache2/conf.d/sonarr.conf http://git.io/vcCGM
sed -i 's|PORT|'"$(sed -rn 's|(.*)<Port>(.*)</Port>|\2|p' ~/.config/NzbDrone/config.xml)"'|g' ~/.apache2/conf.d/sonarr.conf
/usr/sbin/apache2ctl -k graceful 2>/dev/null
~~~

This will now be the URL you need to connect until you activate the proxypass.

~~~
echo -e "\nhttps://$(hostname -f)/$(whoami)/sonarr/\n"
~~~

### nginx - Run these commands:

~~~
wget -qO ~/.nginx/conf.d/000-default-server.d/sonarr.conf http://git.io/vcC03
sed -i 's|PORT|'"$(sed -rn 's|(.*)<Port>(.*)</Port>|\2|p' ~/.config/NzbDrone/config.xml)"'|g' ~/.nginx/conf.d/000-default-server.d/sonarr.conf
/usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf 2>/dev/null
~~~

This will now be the URL you need to connect until you activate the proxypass.

~~~
echo -e "\nhttps://$(hostname -f)/$(whoami)/sonarr/\n"
~~~

Restart Sonarr
---

To shut-down Sonarr:

~~~
killall mono
~~~

If it won't go down then use this:

> **Important notes:** You may lose settings this way, make sure to save first:

~~~
killall -9 mono
~~~

Then restart like this:

~~~
screen -dmS sonarr mono --debug ~/NzbDrone/NzbDrone.exe
~~~

Attach to this screen at any time by using this command:

~~~
screen -r sonarr
~~~

Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.



