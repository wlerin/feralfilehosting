
This FAQ is for downloading and installing [WeeChat](http://www.weechat.org/) on your slot.

WeeChat is a fast, light and extensible chat client. It runs on many platforms like Linux, Unix, BSD, GNU Hurd, Mac OS X and Windows (cygwin). 

Please run this command in SSH first:

~~~
mkdir -p ~/bin && bash
~~~

1: Build WeeChat and install it
---

Please use this script.

**Important note:** If you get errors about missing dependencies please see the dependencies section at the end of this FAQ.

~~~
wget -qO ~/install.weechat.sh http://git.io/L6oalA && bash ~/install.weechat.sh
~~~

2: Start WeeChat
---

We have added the location to the `PATH` in step 1, so we can use this command:

~~~
screen -dmS weechat weechat
~~~

Now attach to the screen:

~~~
screen -r weechat
~~~

The full path to execute WeeChat is:

~~~
~/bin/weechat
~~~

3: Configure WeeChat
---

These are some required settings. You enter them in WeeChat after you have started it.

~~~
/server add What-Network irc.what-network.net/6697 -ssl
~~~

Replace  `"username,username_1,username_2"` and the two  instances of `"username"` with a username of your  choice.

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

4: Connecting to predefined IRC networks
---

Use this command to connect to the Feral Hosting IRC channel,  `#feral` on the `What-Network`  IRC network that we defined in the previous step.

~~~
/connect What-Network
~~~

5: Join a channel
---

~~~
/j #feral
~~~

To detach from the screen, press and hold `CRTL` and `a` then press `d`.

Further reading
---

Here you can get information on further configuration, such as auto join and more.

[WeeChat FAQ](http://www.weechat.org/files/doc/weechat_faq.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_quickstart.en.html)

[WeeChat Quick Start Guide](http://www.weechat.org/files/doc/stable/weechat_user.en.html)


Dependencies:
---

[http://www.weechat.org/files/doc/stable/weechat_user.en.html#dependencies](http://www.weechat.org/files/doc/stable/weechat_user.en.html#dependencies)

You may need to ask for certain dependencies to be installed. If you experience this through the scripts failing to configure  weechat and exiting then please ask for that dependency using this format.

~~~
Please can you install some dependencies for Weechat

https://packages.debian.org/en/source/wheezy/libcurl4-gnutls-dev
https://packages.debian.org/en/source/wheezy/libncursesw5-dev
https://packages.debian.org/en/source/wheezy/libgcrypt11-dev

apt-get install libcurl4-gnutls-dev libncursesw5-dev libgcrypt11-dev

Thank you.
~~~



