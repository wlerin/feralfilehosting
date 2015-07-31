
**NOTE: this is currently only available on our SSD slots.** ETA for all slots is 1-2 weeks.

Install Plex
---

To install Plex, create the folder ~/private/plex with your FTP / SFTP client. You can also run the following SSH command: `mkdir ~/private/plex`

Plex will then be set up automatically in the next 5 minutes creating the file `~/private/plex/README` once done. It will be automatically restarted if it is not running.

### Gaining access to Plex

Once Plex has been installed it will be limited to local connections only.

To do this you will need to set up an SSH tunnel and connect to Plex's local IP. The IP can be found in the file `~/private/plex/README` You should view this file in your FTP / SFTP client (possibly needing to download it first) or run the SSH command: `cat ~/private/plex/README`

Once we know the relevant IP, please set up [an SSH tunnel](https://www.feralhosting.com/faq/view?question=37) and then [configure your browser to use it](https://www.feralhosting.com/faq/view?question=242). In essence you're creating a SOCKS5 proxy and then using your browser to connect to Plex's IP.

Once connected via the tunnel, navigate to `http://IP:32400/web` where IP is the IP we got from the `README` (in the format 10.x.x.x).

### Configuring Plex

When visiting Plex for the first time it will ask you to login. If you don't have a login then you will need to sign up with Plex giving them your e-mail address.

To avoid having to use the SSH tunnel to talk to Plex we need to make it available for remote connections.  To do this, please click the settings icon in the top-right, then server, then "show advanced". In the general section you may need to sign in. Then select the "remote access" option. You'll see an IP address and port provided in this format:

~~~
Private IP: $port <- Public IP: $port <- Internet
~~~

Please tick "manually specify port" and enter the port given next to the public IP. You should now be able to visit http://$server.feralhosting.com:$port/web (replace $server with your server name and $port with the port you specified) and drop the SSH tunnel.

Tips for Plex
---

- **Plex is a popular piece of software.** Within the bounds of common sense, if you come across any problems, oddities or tips - please share them! You can do this with a ticket or reviewing this page.
- Plex does not write metadata to video files, instead it creates bundles. If you're backing up the Library section please archive them first as it'll not only reduce the size but also the time taken to transfer the thousands of files (and confirmation packets) involved in transferring via SFTP.
- The channels section is based on the UK locale.
- In web -> player settings, select "only image formats" for burn subtitles for better performance.
- In web -> general, untick Play Theme Music
- You can open a support ticket for help setting up Plex.