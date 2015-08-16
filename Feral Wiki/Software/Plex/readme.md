
> **Important note:**  You can open a support ticket for help setting up Plex.

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH Guide - The Basics](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Plex.tv account:
---

If you have not already created an account with [plex.tv](https://plex.tv/) please do so now.

[https://plex.tv/users/sign_in](https://plex.tv/users/sign_in)

Install Plex
---

To install Plex all you need to do is create a directory named `plex` inside your `private` directory that is located in your slot's root directory.

Run these SSH commands using an SSH client:

First create the required directory:

~~~
mkdir -p ~/private/plex
~~~

Then run this command to automatically load the `README` when it is created:

~~~
while [ ! -f ~/private/plex/README ]; do printf '\rWaiting up to 5 minutes'; sleep 2; done && cat ~/private/plex/README
~~~

Plex Post installation:
---

After the `~/private/plex` directory is created Plex will then be installed and set up automatically within the next 5 minutes.

### Gaining access to Plex

> **Important note:** Once Plex has been installed and running it will be limited to local connections only. You have to create an SSH tunnel connect to the Plex server. Please follow these steps to create the SSH tunnel and complete the plex setup.

**1:** Create an SSH tunnel

Please set up an SSH tunnel on the relevant slot now if you don't have one active: [SSH Tunnels Guide - The Basics](https://www.feralhosting.com/faq/view?question=37)

Then configure your browser to use it using this guide: [SSH Tunnels - How to use them with your applications.](https://www.feralhosting.com/faq/view?question=242)

**2:** Set up static port forwarding

Make the necessary directory structure by using this command:

~~~
mkdir -p ~/.config/feral/ns/forwarding/tcp
~~~

> **Important note:** If you have port issues you can just run these two commands again. The system will sweep every five minutes and create the port forwarding, so please wait till it does this. Please note that it will also remove any incorrect files from the tcp directory *including files trying to forward a port which is already in use. If 5 minutes later your file is missing this is likely to be why.*

Create the port forward file required for remote access.

~~~
rm -f ~/.config/feral/ns/forwarding/tcp/*
echo 32400 > ~/.config/feral/ns/forwarding/tcp/"$(shuf -i 10001-32001 -n 1)"
~~~

The second command above will forward local port `32400` to a randomly generated port between `10001` and `32001`.

### 3. Connecting to Plex locally

The Local IP can be found in the file `~/private/plex/README` You can view this file in your FTP / SFTP client (possibly needing to download it first) or run this SSH command:

~~~
cat ~/private/plex/README
~~~

Once connected via the tunnel, using your web browser, navigate to:

~~~
http://IP:32400/web
~~~

Where IP is the IP we got from the `README`. For example:

~~~
http://10.0.3.2:32400/web
~~~

To avoid having to use the SSH tunnel to talk to Plex we need to make it available for remote connections. To do this, please click the settings icon in the top-right, then server, then "show advanced". In the general section you may need to sign in. Then select the "remote access" option. You'll see an IP address and port provided in this format:

**1:** Click on the settings icon.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/0.png)

**1:** Click in the `Server` tab
**2:** Click on the `General` section (if not already selected).
**3:** Enter your plex.tv account email address
**4:** Enter your plex.tv account password
**5:** Click on `Sign In`

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/1.png)

**1:** You will be logged in and see an avatar of your account.
**2:** Click on the `Remote Access` section. 

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/2.png)

**1:** Make sure you are on the `Remote Access` section
**2:** Click on the `Show Advanced` button

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/3.png)

**1:** Make sure you are in the Remote Access section
**2:** Make sure you have shown the advanced settings
**3:** This will be where your address to access plex remotely will be displayed.

~~~
123.123.123.123:12345/web
~~~

You will need to tick the box to manually specify the port, then select the port you chose when setting up static port forwarding.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/4.png)

**After disconnecting from the tunnel**, in a web browser connect to the remote access URL shown in previous steps. It will need to be in the format:

~~~
123.123.123.123:12345/web
~~~

Optionally you can replace this IP with the server hostname. Where `server` is the name of the server that hosts the relevant slot:

~~~
server.feralhosting.com:12345/web
~~~

When visiting the remote Plex URL for the first time it may ask you to login.

Tips for Plex
---

**Plex is a popular piece of software.** Within the bounds of common sense, if you come across any problems, oddities or tips - please share them! You can do this with a ticket or reviewing this page.

Plex does not write metadata to video files, instead it creates bundles. If you're backing up the Library section please archive them first as it'll not only reduce the size but also the time taken to transfer the thousands of files (and confirmation packets) involved in transferring via SFTP.
The channels section is based on the UK locale.

In `web` -> `player settings`, select `only image formats` for burn subtitles for better performance.

In `web` -> `general`, un check `Play Theme Music`

Add you own tips here!

Restarting Plex:
---

> **Important note:** Plex will be automatically restarted if it is not running. It can take up to ten minutes to reload.

Run this command to kill the plex processes. Then wait up to 10 minutes for it to restart.

~~~
pkill -9 -fu "$(whoami)" 'plexmediaserver'
~~~

Updating Plex
---

Run this command to update Plex to the latest version Feral is hosting and then wait up to ten minutes for it to reload.

~~~
pkill -9 -fu "$(whoami)" 'plexmediaserver'&& rm -rf ~/private/plex && mkdir -p ~/private/plex
~~~



