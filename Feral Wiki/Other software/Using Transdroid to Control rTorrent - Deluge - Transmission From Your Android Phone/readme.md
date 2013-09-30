
[Transdroid](http://transdroid.org) can be used to control rTorrent from your Android phone.

[Transdroid-desktop](http://code.google.com/p/transdroid-desktop/) can be used on your computer to control rtorrent(Cross-platform).

Upon installing, you will be presented with a screen explaining that you need to open the settings menu. Do so.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/1.png)

### Rutorrent

**Important note:** To use transdroid with rutorrent/rtorrent you are required to

1: Have rutorrent/rtorrent installed already

2: Then [update to nginx using this FAQ](https://www.feralhosting.com/faq/view?question=231). Once you have done that, use this information below to use transdroid to connect to rtorrent.

Click `Add new server`.

**Name:** Can be anything you want, such as `feral`

**Server type:** rtorrent

**Host:** `username.server.feralhosting.com` (server is the servername of your slot)

**Port:** `80` ( `443` can be used if you check `SSL` and `accept all certs` )

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/rutorrent.host.png)

**SCGI Folder:** `/rtorrent/rpc` (case sensitive)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/rutorrent.rpc.png)

**Use authentication:** `Yes` (checked)

**Username:** `rutorrent`

**Password:** The password listed on your manager page for the rutorrent Web Gui

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/rutorrent.auth.png)

**Server OS:** `Linux`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/rutorrent.os.png)

** SSL **

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/rutorrent.ssl.png)

### Deluge

Set IP/domain to: 

~~~
server.feralhosting.com
~~~

**Port:** `443`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/deluge/deluge.host.png)

**Deluge Web Password:** your Web Gui password from your Slot Details page. (Not to be confused with require Authentication) 

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/deluge/deluge.webpass.png)

**Folder:** `/username/deluge`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/deluge/deluge.folder.png)

The important one is the Folder field. You need the `/` at the beginning and no trailing slash.

**Server OS:** `Linux`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/deluge/deluge.os.png)

If you get an error about Web Gui not being connected to a daemon log in via the Web Gui and connect to the daemon, then try again.

** SSL **

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/deluge/deluge.ssl.png)



