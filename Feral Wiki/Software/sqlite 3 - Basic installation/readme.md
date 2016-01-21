
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot.

Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Sqlite installation
---

A very basic guide to manual installation of sqlite 3.

~~~
wget -qO ~/sqlite3.tar.gz https://www.sqlite.org/2016/sqlite-autoconf-3100200.tar.gz
tar xf ~/sqlite3.tar.gz && cd ~/sqlite-*/
./configure --prefix=$HOME && make && make install
cd && rm -rf sqlite{-autoconf-3100200,3.tar.gz}
~~~

For some applications you will have to link to this location, for example:

~~~
env CPPFLAGS="-I$HOME/include" LDFLAGS="-L$HOME/lib" ./configure --prefix=$HOME/
~~~



