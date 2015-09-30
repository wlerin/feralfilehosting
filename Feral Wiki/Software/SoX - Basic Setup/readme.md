
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH Guide - The Basics](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Install SoX
--

You can [open a ticket](https://www.feralhosting.com/manager/tickets/new) ask for SoX to be installed:

~~~
Please can you install the Application: APPLICATION NAME

https://packages.debian.org/sid/sox

apt-get install sox

Reason: So i can use SoX to work with audio files

Thank you.
~~~

Install SoX manually and optionally Flac and lame
---

We need to ask for these to be installed.

~~~
apt-get install libflac-dev libmp3lame-dev libvorbis-dev libmad0-dev
~~~

You check which dependencies are already installed using these commands:

> **Important notes:** A result of `1` Means it is installed and `0` means it is not:

~~~
dpkg-query -s libflac-dev 2>&1 | grep -c 'ok installed'
dpkg-query -s libmp3lame-dev 2>&1 | grep -c 'ok installed'
dpkg-query -s libvorbis-dev 2>&1 | grep -c 'ok installed'
dpkg-query -s libmad0-dev 2>&1 | grep -c 'ok installed'
~~~

Once you have your dependencies required then do this:

~~~
wget -qO ~/sox.tar.gz http://downloads.sourceforge.net/project/sox/sox/14.4.2/sox-14.4.2.tar.gz
tar xf ~/sox.tar.gz && cd ~/sox-14.4.2
./configure --prefix=$HOME
make && make install
cd && rm -rf sox{-14.4.2,.tar.gz}
~~~

Optional - Install Flac locally:

~~~
wget -qO ~/flac.tar.xz http://downloads.xiph.org/releases/flac/flac-1.3.1.tar.xz
tar xf ~/flac.tar.xz && cd ~/flac-1.3.1
./configure --prefix=$HOME
make && make install
cd && rm -rf flac{-1.3.1,.tar.xz}
~~~

Optional - Install Lame locally:

~~~
wget -qO ~/lame.tar.gz http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xf ~/lame.tar.gz && cd ~/lame-3.99.5
./configure --prefix=$HOME
make && make install
cd && rm -rf lame{-3.99.5,.tar.gz}
~~~

SoX Documentation
---

[http://sox.sourceforge.net/Docs/Documentation](http://sox.sourceforge.net/Docs/Documentation)