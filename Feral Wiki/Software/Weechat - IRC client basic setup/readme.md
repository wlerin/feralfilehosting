
This FAQ is for downloading and installing [WeeChat](http://www.weechat.org/) on your slot.

WeeChat is a fast, light and extensible chat client. It runs on many platforms like Linux, Unix, BSD, GNU Hurd, Mac OS X and Windows (cygwin). 

### 1: Do some ground work

Put the files in a nice location

~~~
mkdir -p ~/private/programs
~~~

**Important note:** Only run the `echo` command below if you have not already done so in this FAQ or another. You can check first using this command:

~~~
grep "~/private/programs" ~/.bashrc
~~~

No result means you have not used it. More than one result means you have used the command more than you needed. Remove extra entries.

Add the location to your `PATH` using this command.

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

### 2: Optional. Build cmake from source instead

**Optional** You can skip this step. Takes a bit longer.

~~~
wget -qO ~/cmake-2.8.11.2.tar.gz http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
tar xzf ~/cmake-2.8.11.2.tar.gz
cd ~/cmake-2.8.11.2
./bootstrap --prefix=$HOME/private/programs
make && make install && cd
rm -rf ~/cmake-2.8.11.2 ~/cmake-2.8.11.2.tar.gz
~~~

### 3: Build WeeChat using cmake

USe these commands to build Weechat into `~/private/programs`

~~~
wget -qO ~/weechat.tar.gz http://www.weechat.org/files/src/weechat-0.4.1.tar.gz
tar -xzf ~/weechat.tar.gz
cd ~/weechat-0.4.1
cmake -DPREFIX=$HOME/private/programs
make && make install && cd
rm -rf ~/weechat.tar.gz ~/weechat-0.4.1
~~~

### 4: Start WeeChat

We have added the location to the `PATH` in step 1, so we can use this command:

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

### 5: configure WeeChat

These are some required settings. You enter then in WeeChat after you have started it.

Replace `"username,username_1,username_2"` and the two instances of `"username"` with a username of your choice.

~~~
/server add What-Network irc.what-network.net/6697 -ssl
/set irc.server.What-Network.nicks "username,username_1,username_2"
/set irc.server.What-Network.username "username"
/set irc.server.What-Network.realname "username"
/set irc.server.What-Network.ssl on
/set irc.server.What-Network.ssl_verify off
/set irc.server.What-Network.ssl_dhkey_size 1024
/save
~~~

### 6: connect to the IRC

Use this command to connect.

~~~
/connect What-Network
~~~

### Join a channel

~~~
/j #feral
~~~

Now to detach from the screen you press and hold `CRTL` and `a` then press `d`

### Further reading

Here you can get information on further configuration, such as auto join and more.

[WeeChat FAQ](http://www.weechat.org/files/doc/weechat_faq.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_quickstart.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_user.en.html "WeeChat User’s Guide")



