
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Bash script installation
---

> **Important note:** This script can also update proftpd and add or modify users. When updates become available and the script update your installation without losing any settings, jails or users you have configured.

Run this command in SSH:

~~~
wget -qO ~/install.proftpd http://git.io/nQJBxw && bash ~/install.proftpd
~~~

You can easily add or modify users from the installation script at any time.

~~~
install.proftpd adduser
~~~

You can also pass a username directly to the script and it will use that automatically.

~~~
install.proftpd adduser username
~~~

**Important note:** Use the option `help` for important information on start up commands, configured ports, connection info and debugging:

~~~
install.proftpd help
~~~

**Important note:** The script will generate Filezilla connection profiles you can download and import. Use the `help` option to see the location.

Step 1: Creating new users and groups
---

These users, when created, are all **jailed by default** based on the configuration file settings.

There is a bash add user script (optional) linked near the end of this section. The users created with this script are also jailed by default.

> **Important note:** You will get a directory listing error when connecting if your user's `HOME`, when created, does not match an existing jail path. You can get around this by manually specifying a remote path which is supported by most FTP programs. See Step 8 of this FAQ for more info on specifying a users' root/home directory.

> **Important note:** There are three existing and default jail directories you can use without needing to edit the configuration files.

~~~
private/rtorrent/data
private/deluge/data
private/transmission/data
~~~

If you use one of these jail paths as your user's `HOME` or as a remote directory in your FTP program your user will already have access and get a successful directory listing when connecting.

Create user bash script
---

~~~
install.proftpd adduser
~~~

It will find the next available ID and then ask you for a name, or you can invoke it with a name.

You will need to:

**1:** Enter a username for your new user

**2:** Enter a relative path from the slot's root to the users `HOME`. Do not use `~/` in the path

**3:** Enter a password.

And that should be your new user created and ready to connect once you have started the servers in Step 3.

Step 2: Jail your users:
---

> **Important note:** Don't forget changes made to the` proftpd.conf`, `sftp.conf` and `ftps.conf` will require the proftpd running process to restarted for the changes to take effect. See Step 3 for restart commands.

Inside the:

~~~
## Permissions
~~~

Section of the `proftpd.conf` you will find that three **READ ONLY** jails have already been set up. The `proftpd.conf` uses a **READ ONLY** jail for all users who are not specifically named with `AllowUser` inside the `<Limit ALL>`section. Any users you create will be jailed by default and restricted to only the default jails.

> **Important note:** A user's HOME is the start location where they are placed upon connecting to the server. If they do not have a HOME that corresponds to an existing jail they will most like get a "Directory listing failed" or similar error. You can manually set these paths in most FTP programs, such as Filezilla (default remote directory) since having a HOME is not that important, as long as they have permission to access the remote directory set in your FTP program.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/remotedirectory.png)

One of the existing jail examples is for `private/rtorrent/data` so all you need to do is create a user whose `--home` is:

~~~
--home $HOME/private/rtorrent/data
~~~

When using the SSH command in the previous section.

Or if you are using the bash script, just do this when prompted for the users `HOME` path:

~~~
private/rtorrent/data
~~~

This way when they log in they will be put into this folder. If you don't give them a `--home` that corresponds to the configured jails they will get a blank listing and may not be able to navigate to the jail.

To add more jails look at the example described next to see how we do this.

Adding or editing custom jails
---

**Part 1:** Choose or create a folder to lock them in (their HOME location). Then use the relative path to that folder in the commands below for `--home`. This is an optional step, but if their `HOME` corresponds to the jail path you wish to set for them, they will connect directly to their `HOME` folder by default, using an FTP client, with no need to manually specify the location.

~~~
~/proftpd/bin/ftpasswd --passwd --name my_username --file ~/proftpd/etc/ftpd.passwd --uid 5001 --gid 5001 --home $HOME/path/to/jail --shell /bin/false
~~~

For example:

~~~
~/proftpd/bin/ftpasswd --passwd --name my_username --file ~/proftpd/etc/ftpd.passwd --uid 5001 --gid 5001 --home $HOME/private/downloads/ --shell /bin/false
~~~

**Part 2:** Edit your:

~~~
~/proftpd/etc/proftpd.conf
~~~

Then add the following. The example code below makes a **READ ONLY** jail some with SFTP specific commands.

You will notice there are already three existing and configured configured jails in the `proftpd.conf`

~~~
# Note: You need to specify a users root/home directory when using ftpasswd
<Directory /media/DiskID/home/my_username/private/downloads/>
# STAT LSTAT are specific to SFTP only. See below
<Limit STAT LSTAT DIRS READ>
AllowAll
</Limit>
</Directory>
~~~

Using symlinks to other directories
---

If you want to be able to follow symlinks outside the allowed directory you will need to add a new `<Directory>` section for each folder inside the `proftpd.conf`, for example:

You have created a new folder called `proftpd_pub` in the root of your slot using this command:

~~~
mkdir -p ~/proftpd_pub
~~~

You have also created a special `completed` directory for your finished torrents opened in Deluge located at:

~~~
~/private/deluge/completed
~~~

You have then created this symlink to the Deluge completed directory inside the `proftpd_pub` directory like this:

~~~
ln -s ~/private/deluge/completed ~/proftpd_pub/downloads
~~~

To allow the jailed users access via the symlink you would need to add the following to `proftpd.conf` to give them read only access to both required directories.

~~~
<Directory /media/DiskID/home/username/proftpd_pub/>
# STAT LSTAT are specific to SFTP only. See below
<Limit STAT LSTAT DIRS READ>
AllowAll
</Limit>
</Directory>
#
<Directory /media/DiskID/home/username/private/deluge/completed/>
# STAT LSTAT are specific to SFTP only. See below
<Limit STAT LSTAT DIRS READ>
AllowAll
</Limit>
</Directory>
~~~

Then you will need to restart the proftpd running process for the changes to take effect.

AllowAll or AllowUser
---

The use of `AllowAll` means that any non main user has read only access to the default jails in the default `proftpd.conf`. 

You can remove this and use `AllowUser` insted in this way:

~~~
<Directory/media/DiskID/home/username/private/deluge/completed/>
# STAT LSTAT are specific to SFTP only. See below
<Limit STAT LSTAT DIRS READ>
AllowUser my_username
</Limit>
</Directory>
~~~

In this example only `my_username` has read only access to this jail. You can add more than one user.

This will let you fine tune access to the jails.

Make a jail writeable so users can upload.
---

To make a directory writeable so users can upload to it you would add `WRITE` permissions.

The default set-up is read only by default on all example jails using this set-up.

~~~
<Limit STAT LSTAT DIRS READ>
~~~

To make it so we can upload we simply need to add `WRITE` to the allowed permissions for this jail. So it becomes.

~~~
<Limit WRITE STAT LSTAT DIRS READ>
~~~

That is it, this jail is now writeable and users can upload. 

If you wanted to fine tune their upload permissions you would break down the `WRITE` permission into it component parts. What this means is that `WRITE` is a group of commands covering:

~~~
APPE, DELE, MKD, RMD, RNTO, STOR, STOU, XMKD, XRMD 
~~~

So instead of `WRITE` you could allow the specific permissions only.

Please see the Useful links section at the end of the FAQ for info on directives you can use in the proftpd.conf and the use of Limits.

Step 3: Let's start ProFTPD:
---

> **Important note:** If you make changes to the `proftpd.conf` you will need to restart it for these changes to take effect.

**Before you start proftpd make sure you have configured your jails. Configuration file changes require you restart proftpd to take effect.**

This is how you would have both sftp and ftps daemons running at the same time. You will need to run two separate instances of proftpd using different configurations using these commands.

**SFTP**

~~~
~/proftpd/sbin/proftpd -c ~/proftpd/etc/sftp.conf
~~~

**FTPS**

~~~
~/proftpd/sbin/proftpd -c ~/proftpd/etc/ftps.conf
~~~

> **Important note:** These warning are normal and to be expected. They are not errors. Proftpd will have started and be running and you should be able to now SFTP/FTPS to the port defined in your configuration files.

~~~
[server ~] ~/proftpd/sbin/proftpd -c ~/proftpd/etc/sftp.conf
2015-00-00 00:00:00,000 server proftpd[0000] server.feralhosting.com: SocketBindTight in effect, ignoring DefaultServer
2015-00-00 00:00:00,000 server proftpd[0000] server.feralhosting.com: unable to set daemon groups: Operation not permitted
~~~

> **Important note:** If you see an error about truncated data on certain lines this is due to there being no new,blank line at the end of the relevant configuration files. You should not see this error with the configuration files included in this FAQ unless you have modified them and removed the blank line at the end.

Do this command to see if it/they are running:

~~~
ps x | grep proftpd | grep -v grep
~~~

You will see one or more results like this:

~~~
4880 ?        Ss     0:00 proftpd: (accepting connections)
~~~

We are only interested in the results that end with:

~~~
proftpd: (accepting connections)
~~~

These are the actual SFTP and/or FTPS proftpd processes.

To kill the process so you can restart them use this:

~~~
kill -9 PID
~~~

Where PID is the number listed in the `ps x | grep proftpd | grep -v grep` command we used.

or 

~~~
killall -9 proftpd -u $(whoami)
~~~

To kill all processes.

Crontab automatic restart on server reboot
---

To edit your crontab you must do this command:

~~~
crontab -e
~~~

Now all you need to do is add whichever of these lines you want to restart on a reboot:

**SFTP**

~~~
@reboot $HOME/proftpd/sbin/proftpd -c $HOME/proftpd/etc/sftp.conf
~~~

**FTPS**

~~~
@reboot $HOME/proftpd/sbin/proftpd -c $HOME/proftpd/etc/ftps.conf
~~~

Then press and hold `CTRL` then press `X` to save then press `Y` say yes and exit

Step 4: Connecting to my Server
---

The process is the same as normal:

[FTP and SFTP basics - Filezilla](https://www.feralhosting.com/faq/view?question=187)

**Host**: server.feralhosting.com
**username**: whatever user names you created
**port**: as you defined in the config files.

SFTP Public/Private Keys (optional)
---

The `sftp.conf` has been configured to accept and use key pairs. There is just one things you must do to make it work. You must convert it to `SSH RFC 4716` format. This is not as complicated as it sounds.

The `sftp.conf` has been configured to look for keyfiles already, all you need to do is:

**1:** Convert the public key to  `SSH RFC 4716` format.
**2:** Upload it to the `~/proftpd/etc/sftp/authorized_keys/` directory
**3:** Rename the file to match the username of the user it is authenticating. You can have multiple copies of the same files with different usernames.

It will then work the next time a user tries to authenticate using a matching private key-file.

**On Windows:**

If you are on Windows and you used [Puttygen](https://www.feralhosting.com/faq/view?question=13) to create your keyfile, just open it up in Puttygen and save the public key as shown, with no file extension.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/puttygen1.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/puttygen2.png)

Now upload this file **named after your proftpd user** to:

~~~
~/proftpd/etc/sftp/authorized_keys/
~~~

So for example, if the uploaded filed is named after `my_username` it will look like this after you have uploaded it.

~~~
~/proftpd/etc/sftp/authorized_keys/my_username
~~~

Then use this command in SSH to give all files in that directory 600 permissions.

~~~
find ~/proftpd/etc/sftp/authorized_keys/ -type f -exec chmod 600 {} \;
~~~

**On Unix:**

~~~
ssh-keygen -e -f /path/to/file
~~~

You might have to have only 1 key in a file for this command to work. See the note below.

For example:

~~~
ssh-keygen -e -f ~/.ssh/authorized_keys
~~~

> **Important note:** I could only make it return the first line of multiple lines in this command. If anyone has a solutions to this please update the FAQ. I suggest using the command directly on the OpenSSH format private or public keys.

Quick FAQs:
---

**Q:** I get permission errors uploading files or trying to change permissions.

A: This is disabled in the proftp.conf in the SITE CHMOD section. Use the `AllowUser Username` directive inside the Limit tags to overcome this on a per user basis

**Q:** "Failed to retrieve directory listing" and "Failed to parse returned path."

A: Your users Jail home must correspond to an existing Jail path. If you have made changes to any of the conf files don't forget to restart proftpd as shown in Step 3

Useful Links:
---

[Proftpd FAQ](http://www.proftpd.org/docs/faq/linked/faq.html)

[Howto index](http://www.proftpd.org/docs/howto/index.html)

[Limits](http://www.proftpd.org/docs/howto/Limit.html)
[Controls via mod_ctrls](http://www.proftpd.org/docs/howto/Controls.html)
[directives list](http://www.proftpd.org/docs/directives/linked/configuration.html)

[Core Modules](http://www.proftpd.org/docs/modules/index.html)
[Contrib Modules](http://www.proftpd.org/docs/contrib/index.html)

[example-conf](http://www.proftpd.org/docs/example-conf.html)



