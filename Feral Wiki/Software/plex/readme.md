
~~~
wget -qO ~/plex.deb http://downloads.plexapp.com/plex-media-server/0.9.8.6.175-88ffbb2/plexmediaserver_0.9.8.6.175-88ffbb2_amd64.deb
dpkg-deb -x ~/plex.deb ~/plex
cp -rf ~/plex/usr/. ~/plex && cp -rf ~/plex/etc/default ~/plex
sed -i 's|/usr/lib/plexmediaserver|'$HOME'/plex/lib/plexmediaserver|g' ~/plex/sbin/start_pms
sed -i 's|/etc/default/plexmediaserver|'$HOME'/plex/default/plexmediaserver|g' ~/plex/sbin/start_pms
rm -rf ~/plex/etc ~/plex/usr/
~~~

What we are doing with the `sed` commands:

Find these lines and change them:

**1:**

~~~
export PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
~~~

Change to:

~~~
export PLEX_MEDIA_SERVER_HOME=/media/DiskID/home/username/plex/lib/plexmediaserver
~~~

**2:**

~~~
test -f /etc/default/plexmediaserver && . /etc/default/plexmediaserver
~~~

Change to:

~~~
test -f /media/DiskID/home/username/plex/default/plexmediaserver && . /media/DiskID/home/username/plex/default/plexmediaserver
~~~

**3:**

~~~
(cd /usr/lib/plexmediaserver; ./Plex\ Media\ Server)
~~~

Change to:

~~~
(cd /media/DiskID/home/username/plex/lib/plexmediaserver; ./Plex\ Media\ Server)
~~~

Using `sed`:

Save the changes in nano:

~~~
screen -S plex
~~~

~~~
~/plex/sbin/./start_pms
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