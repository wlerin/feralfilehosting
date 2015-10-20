
[Syncthing - Secure & Private](http://syncthing.net/)
---

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/1.png)

Install syncthing:
---

> **Important note:** New minor versions of this program are being released often. Please check here for the current version and modify the installation code with the current URL
>
> [https://github.com/syncthing/syncthing/releases](https://github.com/syncthing/syncthing/releases)

### Bash Script:

Will install a selected version along with a proxypass for Apache or Nginx.

~~~
wget -qO ~/install.syncthing http://git.io/-MNlxQ && bash ~/install.syncthing
~~~

The URL will be in this format:

~~~
https://server.feralhosting.com/username/syncthing/
~~~

### Manual Installation.

~~~
mkdir -p ~/bin && source ~/.{profile,bashrc}
wget -qO ~/syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v0.11.26/syncthing-linux-amd64-v0.11.26.tar.gz
tar xf ~/syncthing.tar.gz
mv ~/syncthing-linux-amd64-v*/syncthing ~/bin/
cd && rm -rf syncthing{-linux-amd64-v*,.tar.gz}
~~~

Configure syncthing:
---

Now it is ready to run so that we can create the required configuration files.

Do this command in SSH to run it:

~~~
syncthing
~~~

Wait until it has fully loaded and created the required files then exit the process pressing  and holding `CTRL` then pressing `c`. It will look like this:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/2.png)

1: We run the binary
2: We wait until the process has fully loaded and configured itself.
3: we exit the process using `CTRL` + `c`

Editing the `config.xml`
---

Do this command in SSH:

~~~
nano ~/.config/syncthing/config.xml
~~~

Your  generated configuration file will load and look like this. We need to make a few changes to suit our needs.

~~~
<configuration version="11">
    <folder id="default" path="/media/DiskID/username/Sync" ro="false" rescanIntervalS="60" ignorePerms="false" autoNormalize="false">
        <device id="BLYW5FJ-ZCZFS7D-UIIXDIQ-OJQUWA3-LT7TFGK-3GAPZ4S-P5AYI3M-KIKPAQL"></device>
        <minDiskFreePct>1</minDiskFreePct>
        <versioning></versioning>
        <copiers>0</copiers>
        <pullers>0</pullers>
        <hashers>0</hashers>
        <order>random</order>
        <ignoreDelete>false</ignoreDelete>
    </folder>
    <device id="BLYW5FJ-ZCZFS7D-UIIXDIQ-OJQUWA3-LT7TFGK-3GAPZ4S-P5AYI3M-KIKPAQL" name="pallas" compression="metadata" introducer="false">
        <address>dynamic</address>
    </device>
    <gui enabled="true" tls="false">
        <address>127.0.0.1:8384</address>
        <apikey>V9tVDYebOoiUXR0wZdyeyktgeoyYTE3X</apikey>
    </gui>
    <options>
        <listenAddress>0.0.0.0:22000</listenAddress>
        <globalAnnounceServer>udp4://announce.syncthing.net:22026</globalAnnounceServer>
        <globalAnnounceServer>udp6://announce-v6.syncthing.net:22026</globalAnnounceServer>
        <globalAnnounceEnabled>true</globalAnnounceEnabled>
        <localAnnounceEnabled>true</localAnnounceEnabled>
        <localAnnouncePort>21025</localAnnouncePort>
        <localAnnounceMCAddr>[ff32::5222]:21026</localAnnounceMCAddr>
        <maxSendKbps>0</maxSendKbps>
        <maxRecvKbps>0</maxRecvKbps>
        <reconnectionIntervalS>60</reconnectionIntervalS>
        <startBrowser>true</startBrowser>
        <upnpEnabled>true</upnpEnabled>
        <upnpLeaseMinutes>60</upnpLeaseMinutes>
        <upnpRenewalMinutes>30</upnpRenewalMinutes>
        <upnpTimeoutSeconds>10</upnpTimeoutSeconds>
        <urAccepted>0</urAccepted>
        <urUniqueID></urUniqueID>
        <restartOnWakeup>true</restartOnWakeup>
        <autoUpgradeIntervalH>12</autoUpgradeIntervalH>
        <keepTemporariesH>24</keepTemporariesH>
        <cacheIgnoredFiles>true</cacheIgnoredFiles>
        <progressUpdateIntervalS>5</progressUpdateIntervalS>
        <symlinksEnabled>true</symlinksEnabled>
        <limitBandwidthInLan>false</limitBandwidthInLan>
        <databaseBlockCacheMiB>0</databaseBlockCacheMiB>
        <pingTimeoutS>30</pingTimeoutS>
        <pingIdleTimeS>60</pingIdleTimeS>
        <minHomeDiskFreePct>1</minHomeDiskFreePct>
    </options>
</configuration>
~~~

**Change 1:** The WebUi address and port to port between the range of `10001` to `49999`:

~~~
<address>127.0.0.1:8384</address>
~~~

Make sure the hostname is set to `0.0.0.0` and port is changed. For example:

~~~
<address>0.0.0.0:29384</address>
~~~

**Change 2:** The programs listening port to port between the range of `10001` to `49999` that is NOT the default `22000`:

~~~
<listenAddress>0.0.0.0:22000</listenAddress>
~~~

Change it to something else, for example:

~~~
<listenAddress>0.0.0.0:12532</listenAddress>
~~~

**Change 3:**

Find these settings:

~~~
<localAnnounceEnabled>true</localAnnounceEnabled>
<startBrowser>true</startBrowser>
<upnpEnabled>true</upnpEnabled>
~~~

And set them to false:

~~~
<upnpEnabled>false</upnpEnabled>
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Accessing the Webui:
---

Now we are ready to relaunch the properly configured syncthing so that we can access and use the WebUi.

in SSH do run this command:

~~~
syncthing
~~~

Now the WebUi should load on the port we configured earlier.

~~~
http://server.feralhosting.com:PORT
~~~

**Important note:** You can use https if you accept the invalid cert

This is what you will see when the syncthing WebUi loads, the first thin we need to do it click on the Options icon in the top right:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/3.png)

Now click on `Settings`:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/4.png)

Inside the settings you can set a usertname and password for the WebUi. Do this now:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/5.png)

You will need to restart the syncthing server for this to take effect:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/6.png)

Repository settings:
---

Each repository can be configured via the `Edit` button:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/7.png)

This is the options window for a repository:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/8.png)

Adding nodes:
---

[Syncthing Downloads](https://github.com/syncthing/syncthing/releases)

You will need to install and configure other syncthing instances on your local or mobile devices then use the `Show ID` in the Options to see your node ID.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/9.png)

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Syncthing%20-%20Basic%20Setup/10.png)

Once you have this you can add nodes to your server instance to sync files.

Help and further reading:
---

https://discourse.syncthing.net/category/documentation



