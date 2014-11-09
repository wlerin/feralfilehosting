
Bash Script:
---

**1:** Installs Sickbeard or Sickrage from Github
**2:** Configures proxypass with the valid SSL URL format.
**3:** Can update Sickbeard or Sickrage and/or only configure the proxypass.
**4:** SickRage only (nginx required) - Presets rTorrent/Rutorrent rpc settings. Only password is required

~~~
wget -qO ~/install.sickbeard.sh http://git.io/bPrsUg && bash ~/install.sickbeard.sh
~~~

Manual Installation:
---

### SickRage - Recommended:

SickRage - [https://github.com/SickragePVR/SickRage](https://github.com/SickragePVR/SickRage)

~~~
git clone https://github.com/SickragePVR/SickRage ~/SickRage
~~~

### SickBeard:

SSH to your slot and pull SickBeard:

~~~
git clone https://github.com/midgetspy/Sick-Beard ~/Sick-Beard
~~~

Configuration
---

> **Important note:** To properly configure the proxypass below you will need to edit the config files while the programs is shut-down or set them from within the program and then save and restart. The command below is just a quick start.

Pick a port between `10000` and `50000`.  Remember this port!  Then let's start up the SickBeard daemon on that port.

~~~
python ~/Sick-Beard/SickBeard.py -d -p XXXXX
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

If SickBeard goes down, restart it with:

~~~
python ~/Sick-Beard/SickBeard.py -d -p XXXXX
~~~

Proxypass Sickbeard or SickRage:
---

This template info applies to both SickBeard and SickRage.

**Important note:** You will need to shutdown Sickbeard/Rage to modify the `config.ini` as it saves loaded settings every time the app shuts down, overwriting any changes you may have made.

You will need to first set the `web_root` in the Sickbeard/rage `config.ini` located in the root of the directory cloned from github.

By default this should be:

~~~
~/Sick-Beard/config.ini
~~~

or

~~~
~/SickRage/config.ini
~~~

So this command should work if the path has not been modified.

~~~
nano ~/Sick-Beard/config.ini
~~~

or

~~~
nano ~/SickRage/config.ini
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

ProxyPass /mypath http://10.0.0.1:PORT/${USER}/mypath
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



