Debian package:

Visit here to see the current version to use in the below command:

~~~
http://shell.ninthgate.se/packages/debian/pool/main/p/plexmediaserver/
~~~

Then modify and use this if required:

~~~
wget -qO ~/plex.deb http://shell.ninthgate.se/packages/debian/pool/main/p/plexmediaserver/plexmediaserver_0.9.11.16.958-80f1748-debian_amd64.deb
dpkg-deb -x ~/plex.deb ~/plex
screen -S plex
cd ~/plex/usr/lib/plexmediaserver/ && bash start.sh
ctrl + a + d
cd && rm -rf plex.deb
~~~

Then connect to the slot using a web browser at:

~~~
server.feralhosting.com:32400/web
~~~

To actually connect to the server after logging in you will need to SSH tunnel in the browser through the slot in question

To make the server `Server is mapped to port 32400` connection work, I:

**1:** ticked the box `Manually specify port` leaving the port on `32400` 

**2:** ticked the box `Require authentication on local networks` in Settings/myPlex

The optionally under Network (advanced settings)

List of networks that are allowed without auth

It will default to `127.0.0.1/255.255.255.255`

You can use this, but it will uncheck the require auth box.

~~~
10.0.0.1/255.255.0.0
~~~

Crontab
---

Someone one else got there first?

Edit your crontab:

~~~
crontab -e
~~~

Then add these two lines.

~~~
@reboot cd ~/plex/usr/lib/plexmediaserver/ && bash -l start.sh >> ~/plex.log
* * * * * cd ~/plex/usr/lib/plexmediaserver/ && bash -l start.sh >> ~/plex.log
~~~

Check the  `~/plex.log` for detail on restart attempts.



