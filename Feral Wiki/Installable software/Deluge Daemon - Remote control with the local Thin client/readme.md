
This FAQ requires you have already installed Deluge using the [**Install Software** link in your Manager](https://www.feralhosting.com/manager/) link in the manager for your slot.

In SSH do these commands. Use this FAQ if you do not know how to SSH into your slot: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

To be able to connect your local deluge client to your remote daemon and interact with it as if it were running locally is easy and just takes a few steps.

Bash Script:
---

This bash script will do the following things for you.:

**1:** Print your hostname and daemon port 
**2:** Print your username and password

You will then be able to connect to deluge using the thin client with the information printed by the script.

~~~
wget -qO ~/delugethin.sh http://git.io/obe0mA && bash ~/delugethin.sh
~~~

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Installable%20software/Deluge%20Daemon%20-%20Remote%20control%20with%20the%20local%20Thin%20client/script.png)

Manual Installation Steps:
---

You need to know some settings and passwords on the server first. To do this, [SSH](http://www.feralhosting.com/faq/view?question=12) into your Feral slot and execute the following commands:

**1:** Get your connection details.

Copy and paste this one liner to retrieve all the required info in a single copy and paste command:

~~~
printf "$(hostname -f)\n$(whoami)\n$(sed -rn 's/(.*)"daemon_port": (.*),/\2/p' ~/.config/deluge/core.conf)\n$(sed -rn "s/$(whoami):(.*):(.*)/\1/p" ~/.config/deluge/auth)\n"
~~~

Here are the individual components of the one liner command:

Your hostname:

~~~
hostname -f
~~~

Your username:

~~~
whoami
~~~

Your connection port:

~~~
sed -rn 's/(.*)"daemon_port": (.*),/\2/p' ~/.config/deluge/core.conf
~~~

This is the password you will need to connect the thin client to the remote daemon.

~~~
sed -rn "s/$(whoami):(.*):(.*)/\1/p" ~/.config/deluge/auth
~~~

**Step 2:** Local Client (Thin Client) Set-up

Download [deluge](http://dev.deluge-torrent.org/wiki/Download) (make sure the version matches the daemon version running on the server).

Install and run deluge on your local machine and then run it.

Go to `Preferences -> Interface` and un-check`Enable` under `Classic Mode`.

You should now see a connection manager box pop up.

Remove the localhost daemon

Click `Add` and enter the address of your Feral server, for example: `athena.feralhosting.com` found from the commands in **Step 1**.

Set the port to the port you got in **Step 1**. 

Enter the username and password you got from **Step 1**.

Click `Add` to add your server's daemon — you should now see a green icon as the status for the host you just added. #

If the light stays red, remove the connection start again.

**Optional:** 

Expand `Options` and select `Automatically connect to selected host on startup` and `Do not show this dialogue on start-up`
Click `Connect`, and the connection manager pop up box should disappear. You should find deluge is now functioning as a local client while manipulating the remote deluge daemon on your Feral slot

To see more information regarding running deluge as a Thin Client visit [http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient](http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient).



