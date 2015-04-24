
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Bash Script:
---

**1:** Installs Sickbeard or Sickrage from Github
**2:** Configures proxypass with the valid SSL URL format.
**3:** Can update Sickbeard or Sickrage and/or only configure the proxypass.
**4:** SickRage only (nginx required) - Presets rTorrent/Rutorrent rpc settings. Only password is required
**5:** Installs Unrar v5 locally to work with SickRage post processing. This feature is not enabled by default.

~~~
wget -qO ~/install.sick http://git.io/vfGch && bash ~/install.sick
~~~

Restarting:
---

### SickBeard:

See if any instances of SickBeard are running. Searches for FAQ or script specific instances only.

~~~
pgrep -fu "$(whoami)" "python $HOME/.sickbeard/SickBeard.py -d"
~~~

Use these commands to shut down all instances from `~/.sickbeard`:

> **Important note:** Give the program at least 10 seconds to shut down before restarting.

Try to kill  Sick Beard gracefully so that it saves all settings.

~~~
kill "$(pgrep -fu "$(whoami)" "python $HOME/.sickbeard/SickBeard.py -d")"
~~~

If it refuses to exit then you have to force it to quit using this command instead.

**Important note:** Make sure you have saved your setting via the WebUi before using this command.

~~~
kill -9 "$(pgrep -fu "$(whoami)" "python $HOME/.sickbeard/SickBeard.py -d")"
~~~

Use this command to restart the default instance:

~~~
python ~/.sickbeard/SickBeard.py -d --pidfile="$HOME/.sickbeard/sickbeard.pid"
~~~

### SickRage:

See if any instances of SickRage are running. Searches for FAQ or script specific instances only.

~~~
pgrep -fu "$(whoami)" "python $HOME/.sickrage/SickBeard.py -d"
~~~

Use these commands to shut down all instances from `~/.sickrage`:

> **Important note:** Give the program at least 10 seconds to shut down before restarting.

Try to kill  SickRage gracefully so that it saves all settings.

~~~
kill "$(pgrep -fu "$(whoami)" "python $HOME/.sickrage/SickBeard.py -d")"
~~~

If it refuses to exit then you have to force it to quit using this command instead.

**Important note:** Make sure you have saved your setting via the WebUi before using this command.

~~~
kill -9 "$(pgrep -fu "$(whoami)" "python $HOME/.sickrage/SickBeard.py -d")"
~~~

Use this command to restart the default instance:

~~~
python ~/.sickrage/SickBeard.py -d --pidfile="$HOME/.sickrage/sickrage.pid"
~~~

Manual Installation:
---

### SickRage - Recommended:

SickRage - [https://github.com/SiCKRAGETV/SickRage](https://github.com/SiCKRAGETV/SickRage)

~~~
git clone https://github.com/SiCKRAGETV/SickRage ~/.sickrage
~~~

> **Important note:** Please use this FAQ to install Unrar v5 locally for use with the post processing feature Unpack (rar only) - [Unrar - How to Install a Newer Version](https://www.feralhosting.com/faq/view?question=280) - You will need to restart your SickRage instance for the changes to take effect.

### SickBeard:

SickBeard - [https://github.com/midgetspy/Sick-Beard](https://github.com/midgetspy/Sick-Beard)

SSH to your slot and pull SickBeard:

~~~
git clone https://github.com/midgetspy/Sick-Beard ~/.sickbeard
~~~

Configuration
---

> **Important note:** To properly configure the proxypass below you will need to edit the config files while the programs is shut-down or set them from within the program and then save and restart. The command below is just a quick start.

Pick a port between `10001` and `49999`.  Remember this port!  Then let's start up the SickBeard daemon on that port.


### Sickbeard:

~~~
python ~/.sickbeard/SickBeard.py -d -p XXXXX --pidfile="$HOME/.sickbeard/sickbeard.pid"
~~~

### Sickrage:

~~~
python ~/.sickrage/SickBeard.py -d -p XXXXX --pidfile="$HOME/.sickrage/sickrage.pid"
~~~

where `XXXXX` is the port you picked.  If `XXXXX` does not work or errors out, it's probably in use, so pick something else.

Then connect to your Sickbeard Web GUI on your slot by pointing your browser to: 

~~~
http://server.feralhosting.com:XXXXX
~~~

Click Config->General Configuration

Set `HTTP Username` to your desired username.
Set `HTTP Password` to your desired password.
Click `Save Changes`.

Proxypass Sickbeard or SickRage:
---

This template info applies to both SickBeard and SickRage.

**Important note:** You will need to shutdown Sickbeard/Rage to modify the `config.ini` as it saves loaded settings every time the app shuts down, overwriting any changes you may have made.

You will need to first set the `web_root` in the Sickbeard/rage `config.ini` located in the root of the directory cloned from github.

By default this should be:

~~~
~/.sickbeard/config.ini
~~~

or

~~~
~/.sickrage/config.ini
~~~

So this command should work if the path has not been modified.

~~~
nano ~/.sickbeard/config.ini
~~~

or

~~~
nano ~/.sickrage/config.ini
~~~

You will need to enter the `web_root` in the format shown in the image where `username` is your Feral username.

**Important note:** The part you can customise is the  `/mypath`. `/username` must be your Feral username.

~~~
web_root = "/username/mypath"
~~~

Take note of the `web_port` while you are here and then save the changes.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Sickbeard%20-%20Basic%20Setup/webroot.png)

### Apache

~~~
nano ~/.apache2/conf.d/sickbeard.conf
~~~

Paste and then modify this code. You will need to change:

1: `PORT` for the port Sickbeard ot SickRage is running on as shown as number 2 in the image above. Change in two locations.

2: `/mypath` in four location with the path you set in the `config.ini`

~~~
Include /etc/apache2/mods-available/proxy.load
Include /etc/apache2/mods-available/proxy_http.load
Include /etc/apache2/mods-available/headers.load

ProxyRequests Off
ProxyPreserveHost On
ProxyVia On

ProxyPass /mypath http://10.0.0.1:PORT/${USER}/mypath retry=0 timeout=5
ProxyPassReverse /mypath http://10.0.0.1:PORT/${USER}/mypath
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Now reload Apache using this command:

~~~
/usr/sbin/apache2ctl -k graceful
~~~

Now stop and restart Sickbeard/Rage then visit the new URL.

~~~
https://server.feralhosting.com/username/mypath
~~~

### nginx

~~~
nano ~/.nginx/conf.d/000-default-server.d/sickbeard.conf
~~~

Paste and then modify this code. You will need to change:

1: `/mypath` in one location for the path you set on the `config.ini`
2: `/username` in one location with your Feral username
3: `PORT` in one location for the `web_port` in the `config.ini`

~~~
location ^~ /mypath {
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Host $http_x_host;
proxy_set_header X-NginX-Proxy true;

rewrite /(.*) /username/$1 break;
proxy_pass http://10.0.0.1:PORT/;
proxy_redirect off;
}
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Now reload nginx using this command:

~~~
/usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf
~~~

Now stop and restart Sickbeard/Rage then visit the new URL.

~~~
https://server.feralhosting.com/username/mypath
~~~

SickRage rTorrent rpc:
---

> **Important note:** You must update Apache to nginx to use the rtorrent rpc - [Update Apache to Nginx](https://www.feralhosting.com/faq/view?question=231).

These are your `rpc` settings:

Where `username` is your Feral username and `server` is the name of the server that is hosting rutorrent.

`rpc` url

~~~
https://server.feralhosting.com/username/rtorrent/rpc
~~~

Username:

~~~
rutorrent
~~~

Password is the password provided by Feral for your Rutorrent WebUi in your Manager.



