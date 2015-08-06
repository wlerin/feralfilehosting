
> **Important note:**  You can open a support ticket for help setting up Plex.

Install Plex
---

To install Plex, create the folder ~/private/plex with your FTP / SFTP client. You can also run the following SSH command: `mkdir ~/private/plex`

Plex will then be set up automatically in the next 5 minutes creating the file `~/private/plex/README` once done. It will be automatically restarted if it is not running.

### Gaining access to Plex

> **Important note:** Once Plex has been installed it will be limited to local connections only.

To access plex will need to set up an SSH tunnel and connect to Plex's local IP. The IP can be found in the file `~/private/plex/README` You should view this file in your FTP / SFTP client (possibly needing to download it first) or run the SSH command: 

~~~
cat ~/private/plex/README
~~~

Once we know the relevant IP, please set up [an SSH tunnel](https://www.feralhosting.com/faq/view?question=37) and then [configure your browser to use it](https://www.feralhosting.com/faq/view?question=242). In essence you're creating a `SOCKS5` proxy and then using your browser to connect to Plex's IP.

Once connected via the tunnel, navigate to `http://IP:32400/web` where IP is the IP we got from the `README` (in the format 10.x.x.x).

### Configuring Plex

To avoid having to use the SSH tunnel to talk to Plex we need to make it available for remote connections.  To do this, please click the settings icon in the top-right, then server, then "show advanced". In the general section you may need to sign in. Then select the "remote access" option. You'll see an IP address and port provided in this format:

**1:** Click on the settings icon.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/0.png)

**1:** Click in the `Server` tab
**2:** Click on the `General` section (if not already selected).
**3:** Enter your plex.tv account email address
**4:** Enter your plex.tv account password
**5:** Click on `Sign In`

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/1.png)

**1:** You will be logged in and see an avatar of yoru account.
**2:** Click on the `Remote Access` section. 

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/2.png)

1: Make sure you are on the `Remote Access` section
2: Click on the `Show Advanced` button

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/3.png)

**1:** Make sure you have shown the advanced settings
**2:** This is your remote address to access plex remotely.

> **Important note:** You must add the `/web` to the end of the remote address otherwise you will get a `401` access denied error.
For example:

~~~
123.123.123.123:12345/web
~~~

or

Where `server` is the name of the server that hosts the relevant slot.

~~~
server.feralhosting.com:12345/web
~~~

> **Important note:** Please make sure `manually specify port` is unticked.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/4.png)

When visiting Plex for the first time it will ask you to login and you will see this:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Plex/5.png)

Tips for Plex
---

**Plex is a popular piece of software.** Within the bounds of common sense, if you come across any problems, oddities or tips - please share them! You can do this with a ticket or reviewing this page.

Plex does not write metadata to video files, instead it creates bundles. If you're backing up the Library section please archive them first as it'll not only reduce the size but also the time taken to transfer the thousands of files (and confirmation packets) involved in transferring via SFTP.
The channels section is based on the UK locale.

In `web` -> `player settings`, select `only image formats` for burn subtitles for better performance.

In `web` -> `general`, untick `Play Theme Music`







