
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

### Installation

**1: Download the CouchPotato source to your home directory**

~~~
git clone https://github.com/RuudBurger/CouchPotatoServer.git ~/.couchpotato
~~~

**2: Create a basic configuration file**

Run this command to create some core settings we will need:

~~~
echo -e "[core]\nhost = 0.0.0.0\nport = $(shuf -i 6000-60000 -n 1)\nlaunch_browser = 0\nurl_base = /$(whoami)/couchpotato" > ~/.couchpotato/settings.conf
~~~

This will make you a basic `~/.couchpotato/settings.conf` that looks something like this:

~~~
[core]
host = 0.0.0.0
port = 12345
launch_browser = 0
url_base = /username/couchpotato
~~~

We need this port, so run this command:

~~~
cat ~/.couchpotato/settings.conf | grep -m1 'port ='
~~~

This should return a result like:

~~~
port = 12345
~~~

Apache proxypass:

Now run this command:

~~~
nano ~/.apache2/conf.d/couchpototo.conf
~~~

Below is the information you will paste into this new file. First you will need to edit the `PORT` in the `10.0.0.1:PORT` in both lines to be the same as the result given from the previous command, which in our example is `123

~~~
Include /etc/apache2/mods-available/proxy.load
Include /etc/apache2/mods-available/proxy_http.load

ProxyPass /couchpotato http://10.0.0.1:PORT/${USER}/couchpotato
ProxyPassReverse /couchpotato http://10.0.0.1:PORT/${USER}/couchpotato
~~~

**Important note:** If you get an error message about the address already being in use, just run the command again.

**3: Run the CouchPotato Wizard**

First we are going to run it to see if it works and do some basic setup. After that we will stop it then start it as a daemon in the background.

~~~
python ~/.couchpotato/CouchPotato.py --daemon
~~~

You should now be able to access CouchPotato in your browser at:

~~~
https://server.feralhosting.com:YOUR_PORT
~~~

Using https the port generated above.

**4: Set a username and password**

Make sure to set a username and password. This is important, otherwise anyone can get access, and automatically start downloads on your slot.

**5: Set the directory to download the NZB/torrent to**

Under Downloaders, the default option is Black Hole, which will just download the NZB/torrent to a folder. You should set the directory to wherever your client watches.

By default, that should be:

~~~
~/private/client/watch
~~~

Make sure to replace **client** with whichever client you use.

CouchPotato also has support for other clients, such as Transmission, which allows it to interact directly with the client, but information for these isn't be included here.

**6: Complete the rest of the wizard**

Fill in any sites that you are a member of. 

Enabling renaming is optional, and isn't covered in this FAQ.

When everything is completed, hit the big green button at the bottom of the page.


