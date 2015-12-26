
How to patch and install OpenSSH server with HPN-SSH on a Feral slot
---

[http://www.openssh.com/portable.html](http://www.openssh.com/portable.html)
[https://www.psc.edu/index.php/hpn-ssh](https://www.psc.edu/index.php/hpn-ssh) and [http://sourceforge.net/projects/hpnssh/](http://sourceforge.net/projects/hpnssh/)

This article will show you how to successfully patch and install `openssh-7.1p1` with `openssh-7_1_P1-hpn-14.9` on a Feral slot and connect using keyfiles. Passwords will not be used to connect.

You will need to run these commands in [SSH](https://github.com/feralhosting/feralfilehosting/blob/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/readme.md) using your SSH client of choice. I recommend [xshell](https://github.com/feralhosting/feralfilehosting/blob/master/Feral%20Wiki/SSH/XShell%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/readme.md) in windows.

Download the files we need. These are the **1:** patch file and **2:** the openssh source code.

~~~
wget -qO ~/openssh-7_1_P1-hpn-14.9.diff http://downloads.sourceforge.net/project/hpnssh/HPN-SSH%2014v9%207.1p1/openssh-7_1_P1-hpn-14.9.diff
wget -qO ~/openssh-7.1p1.tar.gz http://www.mirrorservice.org/pub/OpenBSD/OpenSSH/portable/openssh-7.1p1.tar.gz
~~~

Unpack the source code

~~~
tar xf ~/openssh-7.1p1.tar.gz && cd openssh-7.1p1
~~~

Patch the source code

~~~
cat ~/openssh-7_1_P1-hpn-14.9.diff | patch -p1
~~~

Configure the server to install locally

~~~
./configure --prefix="$HOME" --with-privsep-user="$(whoami)" --with-privsep-path=/root --with-pid-dir="$HOME" --with-default-path="$HOME/bin"
~~~

Compile the source code

~~~
make && make install
~~~

Leave the source code directory and remove files and fodlers we no longer need.

~~~
cd && rm -rf openssh{-7.1p1,-7_1_P1-hpn-14.9.diff,-7.1p1.tar.gz}
~~~

Check the version of the installed server

~~~
~/bin/ssh -V
~~~

The result should look like this.

~~~
OpenSSH_7.1p1-hpn14v9, OpenSSL 1.0.1k 8 Jan 2015
~~~

Change the port at any time using this command.

~~~
sed -ri 's/#?Port (.*)/Port '"$(shuf -i 10001-32001 -n 1)"'/g' ~/etc/sshd_config
~~~

Check the port number at any time using this command

~~~
sed -rn 's|Port (.*)|\1|p' ~/etc/sshd_config
~~~

Some configuration tweaks (recommended)
---

You should perform these commands to ensure security or error free connections.

~~~
ln -s /usr/bin/id $HOME/bin/id
sed -i 's/#Protocol 2/Protocol 2/g' ~/etc/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' ~/etc/sshd_config
~~~

Editing the config file
---

**Important note:** You should always top the server before editing this file.

If you need to make some custom changes you can edit this file before you start the server otherwise you should just leave it alone and move to the next step.
 
~~~
nano ~/etc/sshd_config
~~~

Start, restart or stop sshd
---

Check if the process is running with this command.

~~~
ps x | grep 'sbin/./sshd' | grep -v grep
~~~

Stop the server with this command if it is running.

~~~
kill "$(cat ~/sshd.pid > /dev/null 2>&1)"
~~~

Start the server with this command.

~~~
~/sbin/./sshd
~~~

Connecting to your server
---

Once you have started the server then you must connect somehow.

You will need to use two things to connect

**1:** the custom SSH port defined above.

**2:** A keyfile combo - [Public Key Authentication for password-less login](https://github.com/feralhosting/feralfilehosting/blob/master/Feral%20Wiki/SSH/Public%20Key%20Authentication%20for%20password-less%20login/readme.md)

Create a keyfile using puttygen and copy the public key to this file on a new line:

~~~
~/.ssh/authorized_keys
~~~

For example using nano:


~~~
nano ~/.ssh/authorized_keys
~~~

Then paste your public key one a new line and save and exit.

**Important note:** The connect command will look something like this if you are using a shell:

~~~
ssh -p 12345 -i ~/mykeyfile username@serverferalhosting.com
~~~

You will now be able to connect top your patched server using your Feral username and the keyfile combo you have configured.

**username:** Your feral username
**authentication:** keyfile
**port:** use the command above to find your custom port.



