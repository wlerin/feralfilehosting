
> **Important note:**  You can open a support ticket for help setting up Plex.

Plex.tv account:
---

> **Important note:**  It is a requirement of this guide that you have already created and activated a [plex.tv](https://plex.tv/) account. 

If you have not already created an account with [plex.tv](https://plex.tv/) please do so now.

[https://plex.tv/users/sign_in](https://plex.tv/users/sign_in)

Here is an example of the sign up page:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/signup.png)

Install Plex
---

To install Plex all you need to do is create a folder named `plex` inside your `~/private` directory. 

You can do this with an FTP / SFTP client or using SSH and client.

### Install Plex Using Filezilla:

[Filezilla - Basic Setup for FTP or SFTP](https://www.feralhosting.com/faq/view?question=187)

### Install Plex Using SSH:

Optionally,  you can run this SSH command: 

~~~
mkdir -p ~/private/plex
~~~

Then run this command to automatically load the README when it is created:

~~~
while [ ! -f ~/private/plex/README ]; do printf '\rWaiting up to 5 minutes'; sleep 2; done && cat ~/private/plex/README
~~~

Restarting Plex:
---

> **Important note:** Plex will be automatically restarted if it is not running. It can take up to ten minutes to reload.

Run this command to kill the plex processes. Then wait up to 10 minutes for it to restart.

~~~
kill $(ps x | pgrep -fu "$(whoami)" 'plexmediaserver') &> /dev/null
~~~

Updating Plex
---

Run this command to update Plex to the latest version Feral is hosting and then wait up to ten minutes for it to reload.

~~~
kill $(ps x | pgrep -fu "$(whoami)" 'plexmediaserver') &> /dev/null; rm -rf ~/private/plex && mkdir -p ~/private/plex
~~~

Plex Post installation:
---

After the folder is created Plex will then be set up automatically within the next 5 minutes.

### Gaining access to Plex

> **Important note:** Once Plex has been installed and running it will be limited to local connections only.

When Plex is successfully installed it will have created this file:

`~/private/plex/README`

To access plex will need to set up an SSH tunnel and connect to Plex's local IP.

### Create an SSH tunnel

Please set up an SSH tunnel now if you don't have one active: [SSH Tunnels Guide - The Basics](https://www.feralhosting.com/faq/view?question=37)

Then configure your browser to use it using this guide: [SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242).

### Connecting to Plex locally:


The Local IP can be found in the file `~/private/plex/README` You can view this file in your FTP / SFTP client (possibly needing to download it first) or run this SSH command: 

~~~
cat ~/private/plex/README
~~~

Once connected via the tunnel, using your web browser, navigate to:

`http://IP:32400/web` 

Where `IP` is the IP we got from the `README`, For example:

`http://10.0.3.2:32400/web`

Configuring Plex
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

**1:** Make sure you are on the `Remote Access` section
**2:** Click on the `Show Advanced` button

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/3.png)

**1:** Make sure you are in the Remote Access section
**2:** Make sure you have shown the advanced settings
**3:** This is your remote address to access Plex remotely.

~~~
123.123.123.123:12345/web
~~~

Optionally you can replace this IP with the server hostname. Where `server` is the name of the server that hosts the relevant slot:

~~~
server.feralhosting.com:12345/web
~~~

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/4.png)

Remote Connections issues
---

**1:** If you see this error it means the remote connection is not working.
**2:** You will also see this red `x` to show the connection chain is broken.
**3:** Make sure the `Manually specify port` box is *unchecked*
**4:** Click on the `Retry` button

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/5.png)

**1:** Make sure you have shown the advanced settings
**2:** Make sure you are in the Remote Access section
**3:** If the connection is working the arrow will be green

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/6.png)

Remote Access:
---

> **Important note:** You must not use the active SSH tunnel proxy to connect to the remote connections. Disable your proxy first and then try to connect to the remote address.

In a web browser connect to the remote access URL shown in previous steps. It will need to be in the format:

~~~
123.123.123.123:12345/web
~~~

Optionally you can replace this IP with the server hostname. Where `server` is the name of the server that hosts the relevant slot:

~~~
server.feralhosting.com:12345/web
~~~

When visiting the remote Plex URL for the first time it will ask you to login and you will see this:

> **Important note:** You must add the `/web` to the end of the remote address otherwise you will get a `401` access denied error.
For example:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/login.png)

Tips for Plex
---

**Plex is a popular piece of software.** Within the bounds of common sense, if you come across any problems, oddities or tips - please share them! You can do this with a ticket or reviewing this page.

Plex does not write metadata to video files, instead it creates bundles. If you're backing up the Library section please archive them first as it'll not only reduce the size but also the time taken to transfer the thousands of files (and confirmation packets) involved in transferring via SFTP.
The channels section is based on the UK locale.

In `web` -> `player settings`, select `only image formats` for burn subtitles for better performance.

In `web` -> `general`, un check `Play Theme Music`

Add you own tips here!



