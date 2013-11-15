
[Transdroid](http://transdroid.org) can be used to control rTorrent from your Android phone.

## Required prerequisites

**Important note:** To use transdroid with rutorrent/rtorrent you are required to:

**1:** Have rutorrent/rtorrent installed already via the Software Install page for the relevant slot.

**2:** Then [update to nginx using this FAQ](https://www.feralhosting.com/faq/view?question=231). Once you have done that, use this information below to use transdroid to connect to rtorrent.

## rutorrent

Open Transdroid 2 on your device. Click on the menu button and then click on `settings`.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/settings.png)

Then click on `Add new server`.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/addserver.png)

You will now see this list of main options:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/mainoptions.png)

**Name:** Can be anything you want, such as `rutorrent`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/name.png)

**Server type:** `rTorrent`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/servertype.png)

**IP or host name:** `server.feralhosting.com` (where `server` is the name of the actual server that hosts the relevant slot)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/hostname.png)

**User Name:** `rutorrent`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/username.png)

**Password:** `*********`  This password will be the password shown in your Slot Details page for the relevant slot.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/rutorrent.slotdetails.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/password.png)

### Advanced Options

Click on `Advanced Options` now. You will see this list of options.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/advancedoptions.png)

***Port number** `443`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/port.png)

**SCGI/Folder:** `/username/rtorrent/rpc` (case sensitive and where username is your Feral username)

**Important note:** You need the `/` at the beginning and no trailing slash.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/scgipath.png)

**Use SSL** MAke sure to tick this box

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/ssl.png)

### Options Settings

Click on `Options Settings` now.

**Server OS:** `Linux`

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/main/port.png)

If all settings were correctly entered you should now be able to connect:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Other%20software/Using%20Transdroid%20to%20Control%20rTorrent%20-%20Deluge%20-%20Transmission%20From%20Your%20Android%20Phone/rutorrent/scgipath.png)




### Deluge

**Important note:** To use transdroid with Deluge you are required to:

**1:** Have Deluge installed already via the Software Install page for the relevant slot.

**2:** Log into the WebUi to connect the WebUi to the daemon process.

Open Transdroid on your device and open the settings, then click on `Add new server`.

**Set IP/domain:** `server.feralhosting.com` (server is the servername of your slot)

**Port:** `443`

**Deluge Web Password:** your Web Gui password from your Slot Details page. (Not to be confused with Require Authentication option)

When entering your password, if you rotate your phone horizontally you can see the characters.

**Folder:** `/username/deluge` (username is your Feral username)

You need the `/` at the beginning and no trailing slash.

**Server OS:** `Linux`

If you get an error about Web Gui not being connected to a daemon log in via the Web Gui and connect to the daemon, then try again.

**SSL**




