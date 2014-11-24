

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot.

Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Aerofs introduction
---

Aerofs is essentially a peer to peer secure dropbox style app. You only share directly with your attached devices.

"AeroFS encrypts your data end-to-end, and only shares your files with those who you invite. Files are never stored in the public cloud."

Install AeroFS:
---

Please go to [https://aerofs.com/](https://aerofs.com/ "aerofs.com") and create an account.

~~~
wget -qO ~/aerofs.tgz https://dsy5cjk52fz4a.cloudfront.net/aerofs-installer-0.8.77.tgz
tar xf ~/aerofs.tgz
~~~

### Teamserver example (Optional - Just for demonstration):

> **Important note:** The teamserver installation is pretty much exactly the same. Centralised files storage vs peer to peer clients.

~~~
wget -qO ~/aerofsts.tgz https://dsy5cjk52fz4a.cloudfront.net/aerofsts-installer-0.8.77.tgz
tar xf ~/aerofsts.tgz
screen -S aerofs ~/aerofs/aerofsts-cli
~~~

Running Aerofs
---

At first run we need set up the app and it work better in a screen, so type this command:

~~~
screen -S aerofs ~/aerofs/aerofs-cli
~~~

This will start the set-up process.

- Enter the email you registered with when prompted.

- Enter you password for this account when prompted.

- Enter the path you want for you Aerofs folder when prompted. This path will `~/Aerofs` by default if you just press enter.

When the set-up is complete press this keyboard sequence to detach from the screen:

Press and hold `CTRL` and `A` then press  `D`

Once you have setup up Aerofs you can start it easily using this command:

~~~
screen -dmS aerofs ~/aerofs/aerofs-cli &
~~~

To use the process interactively use this command:

~~~
~/aerofs/aerofs-sh
~~~

Here is the result:

~~~
AeroFS>
~~~

Type `help` to see the help page

~~~
AeroFS> help
~~~



