
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot.

Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Redis installation
---

Redis is meant to be set an run from within the extracted folder.

~~~
wget -qO ~/redis.tar.gz http://download.redis.io/releases/redis-2.8.17.tar.gz
tar xf ~/redis.tar.gz
mv -f ~/redis-2.8.17 ~/.redis
cd ~/.redis && make
~~~

Then edit the conf to your needs, located here:

~~~
~/.redis/redis.conf
~~~

Then start redis using this command, inside a screen for easier management:

~~~
screen -S redis
~~~

Then run using this command:

~~~
~/.redis/src/./redis-server ~/redis/redis.conf
~~~

Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

Your programs should be able to connect to the local `redis-server` using the settings you configured in the `redis.conf`



