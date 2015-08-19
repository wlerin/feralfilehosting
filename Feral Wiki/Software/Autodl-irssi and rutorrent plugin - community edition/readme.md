
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH Guide - The Basics](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

If you see this error in your rutorrent Web Gui:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Autodl-irssi%20and%20rutorrent%20plugin%20-%20community%20edition/error.png)

~~~
Error downloading files. Make sure autodl-irssi is started and configured properly (eg. password, port number): Error getting files listing: Error: Could not connect: (111) Connection refused
~~~

You simply need to run the installer again to apply the fix.

> **Important note:** This will not delete or change any of your configured settings. It will just update autodl and apply the fix.

~~~
wget -qO ~/install.autodl.sh http://git.io/oTUCMg && bash ~/install.autodl.sh
~~~

Preparation
---

SSH to your slot and run these commands:

**Important note:** These commands do not delete the `~/.autodl` folder or the `~/.autodl/autodl.cfg` but this file will be overwritten during manual installation below so please back it up now if you need it.

~~~
killall irssi -u $(whoami); screen -wipe
cp -f ~/.autodl/autodl.cfg ~/.autodl/autodl.cfg.bak
cd && rm -rf .irssi/scripts/AutodlIrssi .irssi/scripts/autorun/autodl-irssi.pl
cd && rm -rf www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/autodl-irssi
~~~

Manual installation of autodl-irssi
---

SSH to your slot and run these commands:

~~~
mkdir -p ~/.irssi/scripts/autorun ~/.autodl
echo -e "[options]\ngui-server-port = 0\ngui-server-password = PASS" > ~/.autodl/autodl.cfg
wget -qO ~/autodl-irssi.zip http://update.autodl-community.com/autodl-irssi-community.zip
unzip -qo ~/autodl-irssi.zip -d ~/.irssi/scripts/
cp -f ~/.irssi/scripts/autodl-irssi.pl ~/.irssi/scripts/autorun/
cd && rm -f autodl-irssi.zip .irssi/scripts/{README*,autodl-irssi.pl,CONTRIBUTING.md}
~~~

Configuring your autodl-irssi connection to the autodl-irssi rutorrent plugin.
---

This step is not required. If you don’t want to use the UI configuration editor, 

To configure autodl-irssi for rutorrent:

You can use any torrent client. You just need the rutorrent UI installed to use this feature.

~~~
nano ~/.autodl/autodl.cfg
~~~

The `autodl.cfg` it will look like this

~~~
[options]
gui-server-port = 0
gui-server-password = PASS
~~~

**1:** Change the port to something between `10001` and `49999`

**2:** Create a password and replace `PASS` with your new password.

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Manual installation of autodl-irssi rutorrent plugin
---

> **Important note:** These next commands are to download and then edit the GUI plugin to connect with the process. And are required if you wish to use the rutorrent GUI to manage autodl-irssi.

~~~
cd ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/
wget -qO autodl-rutorrent.zip https://github.com/autodl-community/autodl-rutorrent/archive/master.zip
unzip -qo autodl-rutorrent.zip
cp -rf autodl-rutorrent-master/. autodl-irssi
rm -rf autodl-rutorrent.zip autodl-rutorrent-master
cp -f autodl-irssi/_conf.php autodl-irssi/conf.php
nano autodl-irssi/conf.php
~~~

### Edit this info:

~~~
$autodlPort = 15896; // Set the same port value as you set earlier (the one in ~/.autodl/autodl.cfg)
~~~

~~~
$autodlPassword = "ey47DT7heE7E8"; // Set the same password as before (while editing ~/.autodl/autodl.cfg)
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Run Irssi in a screen
---
 
~~~
screen -dmS autodl irssi
~~~

To re attach to this screen in SSH to control irssi type this command in your shell:

~~~
screen -r autodl
~~~

Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

Using rutorrent autodl-irssi plugin:
---

Check out the Wiki Page.

[https://github.com/autodl-community/autodl-irssi/wiki/_pages](https://github.com/autodl-community/autodl-irssi/wiki/_pages)

Updating
---

If you are running the autodl-irssi-community version (installed here) and `NOT` the autodl-irssi version from months ago, you can update to the latest plugin version by re-running these steps, or running the following command in irssi:

**Important note:** If you update the core program files (not just not the trackers) you will have to run the installer script at the top of this FAQ again.

Inside the screen you would type this into `irssi`:

~~~
/autodl update
~~~



