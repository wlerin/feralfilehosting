
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

Plex Installation and Set Up Outlined
---

To install Plex this is the procedure you will need follow. All these steps are described in this guide.

**1:** Create a directory named `plex` inside your `private` directory that is located in your slot's root directory.
**2:** Activate the the port forward using the commands described below.
**3:** Create an SSH tunnel on the relevant slot to connect to the Local Plex URL.
**4:** Once connected to Plex you must then connect the server to your plex.tv account.
**5:** Then active remote connection by manually specifying the port that was used for the port forward.
**6:** Disable the SSH proxy in your web browser and then connect to the remote Plex URL.

Once done Plex should be fully functional. To achieve this please continue reading the guide.

Plex Installation
---

> **Important note:** After the `~/private/plex` directory is created Plex will then be installed and set up automatically within the next 5 minutes.

Run these SSH commands using an SSH client:

~~~
mkdir -p ~/private/plex
mkdir -p ~/.config/feral/ns/forwarding/tcp && rm -f ~/.config/feral/ns/forwarding/tcp/*
echo 32400 > ~/.config/feral/ns/forwarding/tcp/"$(shuf -i 10001-32001 -n 1)"
~~~

Then run this command to automatically load the `README` when it is created by the installation. It can take up to five minutes:

~~~
while [ ! -f ~/private/plex/README ]; do printf '\rWaiting...'; sleep 2; done && cat ~/private/plex/README
~~~

> **Important note:** If you have port issues later in the guide you can just run these two commands again. The system will sweep every five minutes and create the port forwarding, so please wait till it does this. Please note that it will also remove any incorrect files from the tcp directory *including files trying to forward a port which is already in use. If 5 minutes later your file is missing this is likely to be why.*

~~~
mkdir -p ~/.config/feral/ns/forwarding/tcp && rm -f ~/.config/feral/ns/forwarding/tcp/*
echo 32400 > ~/.config/feral/ns/forwarding/tcp/"$(shuf -i 10001-32001 -n 1)"
~~~

Plex Post installation check-list:
---

> **Important note:** Once Plex has been installed and running it will be limited to local connections only. In order to successfully connect to the local Plex URL you must have done these things:

**1:** Plex was installed and the `README` was successfully loaded.

**2:** You activated the port forward using the commands listed in the previous section.

> **Important note:** You will need to create an SSH tunnel connect and then configure your web browser to use it in order to connect to the Plex server. Please follow these steps below to create the SSH tunnel and complete the plex setup:

**3:** You have created the SSH tunnel: [SSH Tunnels Guide - The Basics](https://www.feralhosting.com/faq/view?question=37)

**4:** You configured your Web Browser to use it: [SSH Tunnels - How to use them with your applications.](https://www.feralhosting.com/faq/view?question=242)

Connecting to Plex locally
---

The Local IP can be found again in the file `~/private/plex/README`. Use this command to view the URL only.

> **Important note:**  If the result of the command below is an error about the file not existing make sure Plex was actually installed before you continue.

~~~
cat ~/private/plex/README | sed -rn 's/URL: (.*)/\1/p'
~~~

Once connected via the tunnel, using your configured web browser, navigate to:

~~~
http://IP:32400/web
~~~

Where IP is the IP we got from the `README`. For example:

~~~
http://10.0.3.2:32400/web
~~~

Plex activating remote connections
---

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

> **Important note:** Even if the`Remote Access` if shown as fully active at this point you must still follow this guide to manually specify the port.

**1:** Make sure you are on the `Remote Access` section
**2:** Click on the `Show Advanced` button

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/3.png)

> **Important note:** You will need to tick the box to manually specify the port, then select the port you chose when setting up static port forwarding. To get your port required for this step you can run this command in SSH:

~~~
ls ~/.config/feral/ns/forwarding/tcp/
~~~

**1:** Make sure you are in the Remote Access section
**2:** Make sure you have shown the advanced settings
**3:** Check the box to specify the remote port manually.
**4:** Enter the the port shown from by `ls` command above. The example port used is `12345`
**5:** Click on `Retry` to active the configuration.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/4.png)

Once you have done this you will see something like this:

**1:** You specified the port using the port forward port.
**2:** You will see your slot's `IP` and the remote port.
**3:** You will see that Remote Access has been fully activated and enabled.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/5.png)

Plex Remote Access via remote URL
---

> **Important note:** Once the remote connection is activated you will need to disable the SSH tunnel in the browser to connect to the remote URL.

In a web browser connect to the remote access URL shown in previous steps. It will need to be in the URL format:

> **Important note:** The port used in the URL will need to be the port used in the port forward we manually specified in Plex.

~~~
123.123.123.123:12345/web
~~~

Using the information shown in the example image we can know the URL for this example is:

~~~
185.21.216.184:12345/web
~~~

Optionally you can replace this IP with the server hostname. Where `server` is the name of the server that hosts the relevant slot:

~~~
server.feralhosting.com:12345/web
~~~

> **Important note:**  When visiting the remote Plex URL it may ask you to login with your plex.tv account

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/login.png)

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

Tips for Plex
---

**Plex is a popular piece of software.** Within the bounds of common sense, if you come across any problems, oddities or tips - please share them! You can do this with a ticket or reviewing this page.

Plex does not write metadata to video files, instead it creates bundles. If you're backing up the Library section please archive them first as it'll not only reduce the size but also the time taken to transfer the thousands of files (and confirmation packets) involved in transferring via SFTP.
The channels section is based on the UK locale.

In `web` -> `player settings`, select `only image formats` for burn subtitles for better performance.

In `web` -> `general`, un check `Play Theme Music`

Add you own tips here!



