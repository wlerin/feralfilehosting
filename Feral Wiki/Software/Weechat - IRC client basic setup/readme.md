
This FAQ is for downloading and installing [WeeChat](http://www.weechat.org/) on your slot.

WeeChat is a fast, light and extensible chat client. It runs on many platforms like Linux, Unix, BSD, GNU Hurd, Mac OS X and Windows (cygwin). 

### 1: Do some ground work

Put the files in a nice location:

~~~
mkdir -p ~/private/programs
~~~

**Important note:** Only run the [code single]echo[/code] command below if you have not already done so in this FAQ or another. You can check first using this command:

~~~
grep "~/private/programs" ~/.bashrc
~~~

No result means you have not used it. More than one result means you have used the command more than you needed. Remove extra entries.

Add the location to your [code single]PATH[/code] using this command.

~~~
echo 'PATH=~/private/programs/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
~~~

### 2: Download and extract pre build cmake-2.8.11.2-Linux-i386

**Recommended** fast and simple.

~~~
wget -qO ~/cmake.tar.gz http://www.cmake.org/files/v2.8/cmake-2.8.11.2-Linux-i386.tar.gz
tar -xzf ~/cmake.tar.gz
cp -rf ~/cmake-2.8.11.2-Linux-i386/. ~/private/programs
rm -rf ~/cmake-2.8.11.2-Linux-i386 ~/cmake.tar.gz
~~~

### 2: Or, build cmake from source instead

**Optional** It takes a bit longer than using a precompiled cmake binary, but some prefer compiling from source. You can skip this step if you've already got cmake available.

~~~
wget -qO ~/cmake-2.8.11.2.tar.gz http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
tar xzf ~/cmake-2.8.11.2.tar.gz
cd ~/cmake-2.8.11.2
./bootstrap --prefix=$HOME/private/programs
make && make install && cd
rm -rf ~/cmake-2.8.11.2 ~/cmake-2.8.11.2.tar.gz
~~~

### 3: Build WeeChat using cmake

Use these commands to build Weechat, placing the binary into [code single]~/private/programs[/code]

~~~
wget -qO ~/weechat.tar.gz http://www.weechat.org/files/src/weechat-0.4.1.tar.gz
tar -xzf ~/weechat.tar.gz
cd ~/weechat-0.4.1
cmake -DPREFIX=$HOME/private/programs
make && make install && cd
rm -rf ~/weechat.tar.gz ~/weechat-0.4.1
~~~

### 4: Start WeeChat

We have added the location to the [code single]PATH[/code] in step 1, so we can use this command:

~~~
screen -dmS weechat weechat-curses
~~~

Now attach to the screen:

~~~
screen -r weechat
~~~

The full path to execute WeeChat is:

~~~
~/private/programs/bin/./weechat-curses
~~~

### 5: Configure WeeChat

These are some required settings. You enter them in WeeChat after you have started it.

~~~
/server add What-Network irc.what-network.net/6697 -ssl
~~~

Replace  [code single]"username,username_1,username_2"[/code] and the two  instances of [code single]"username"[/code] with a username of your  choice.

~~~
/set irc.server.What-Network.nicks "username,username_1,username_2"
/set irc.server.What-Network.username "username"
/set irc.server.What-Network.realname "username"
~~~

Some final settings:

~~~
/set irc.server.What-Network.ssl on
/set irc.server.What-Network.ssl_verify off
/set irc.server.What-Network.ssl_dhkey_size 1024
/save
~~~

Add other networks as desired.

### 6: Connecting to predefined IRC networks

Use this command to connect to the Feral Hosting IRC channel,  `#feral` on the `What-Network`  IRC network that we defined in the previous step.

~~~
/connect What-Network
~~~

### 7: Join a channel

~~~
/j #feral
~~~

To detach from the screen, press and hold [code single]CRTL[/code] and [code single]a[/code] then press [code single]d[/code].

### Further reading

Here you can get information on further configuration, such as auto join and more.

[WeeChat FAQ](http://www.weechat.org/files/doc/weechat_faq.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_quickstart.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_user.en.html)




