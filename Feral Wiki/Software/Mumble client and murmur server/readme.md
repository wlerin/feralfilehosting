
# Preface

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

# Installing mumble
[Mumble](http://mumble.sourceforge.net/) is an open source, low-latency, high quality voice chat software primarily intended for use while gaming.

The murmur server is the server for the mumble VoIP client.

You will need to get the installed files from a running system where you can install packages. This process was done from a [debian jessie](http://gemmei.acc.umu.se/debian-cd/8.1.0/amd64/iso-cd/debian-8.1.0-amd64-netinst.iso) system (it can be installed as VM, only a very basic install is needed)

Install the necessary packages:

~~~
apt-get install mumble-server
~~~

Send the files to your slot (using either ssh or a terminal on the VM):
~~~
USER=<your-feral-user>
SLOT=<your-slot.feralhosting.com>
rsync -rlptDv /usr/sbin/murmurd $USER@$SLOT:murmur/
rsync -rlptDv /usr/lib/x86_64-linux-gnu/libQtDBus.so.4.8.6 /usr/lib/x86_64-linux-gnu/libQtSql.so.4.8.6 /usr/lib/x86_64-linux-gnu/libQtXml.so.4.8.6 /usr/lib/x86_64-linux-gnu/libQtNetwork.so.4.8.6 /usr/lib/x86_64-linux-gnu/libQtCore.so.4.8.6 /usr/lib/x86_64-linux-gnu/libIce.so.3.5.1 /usr/lib/x86_64-linux-gnu/libIceUtil.so.3.5.1 /usr/lib/x86_64-linux-gnu/libdns_sd.so.1.0.0 $USER@$SLOT:murmur/lib/
rsync -rlptDv /usr/lib/x86_64-linux-gnu/qt4/plugins/sqldrivers/libqsqlite.so $USER@$SLOT:murmur/sqldrivers/
~~~


Connect via SSH into your feral slot and run these:

~~~
cd murmur
wget https://raw.githubusercontent.com/mumble-voip/mumble/master/scripts/murmur.ini
cd lib ; ln -s libIce.so.3.5.1 libIce.so.35; ln -s libIceUtil.so.3.5.1 libIceUtil.so.35; ln -s libQtCore.so.4.8.6 libQtCore.so.4; ln -s libQtDBus.so.4.8.6 libQtDBus.so.4; ln -s libQtNetwork.so.4.8.6 libQtNetwork.so.4; ln -s libQtSql.so.4.8.6 libQtSql.so.4; ln -s libQtXml.so.4.8.6 libQtXml.so.4; ln -s libdns_sd.so.1.0.0 libdns_sd.so.1; cd ..
~~~


After setting up the ini file like explained below, the server has to be started as such:

~~~
cd ~/murmur
export LD_LIBRARY_PATH=$HOME/murmur/lib
./murmurd
~~~

# Configuring and setting up the server
That is basically it for the download and extraction of the server. There are a couple of things we need to do before we start it.

Find and open this file.

~~~
~/private/murmur/murmur.ini
~~~

For example in SSH do this:

~~~
nano -w ~/private/murmur/murmur.ini
~~~

We must change the default port:

~~~
port=64738
~~~

to something else, any number between 6000 - 50000 is OK, for example:

~~~
port=23456
~~~

Optionally you can set a server password.

~~~
serverpassword=
~~~

Once this is done you can run the program using this command:

~~~
~/private/murmur/./murmur.x86 -ini ~/private/murmur/murmur.ini
~~~

Superuser password:
---

Please Look in this file `~/private/murmur/murmur.log` for your super user password.

The result should look something like:

~~~
<W>2014-05-19 08:56:47.423 1 => Password for 'SuperUser' set to '`i]>~ZIQ]eL
~~~
-K#'`
This command should work to show it in SSH when used against a default log:

~~~
sed -n 7p ~/private/murmur/murmur.log
~~~

# Mumble Client:


Now you need to install the [Mumble client](http://mumble.sourceforge.net/) for your platform.

Create a new server and use the Address:

~~~
server.feralhosting.com
~~~

Where server is the actual name of your feral server.

**Important note:** You can use this command to run more than once server instance. So be careful to check for before running it.

Use this command to see all running instances of the murmur server

~~~
ps x | grep murmur | grep -v grep
~~~

To kill the process (all running instances) use this command:

~~~
pkill -u $(whoami) murmurd
~~~

