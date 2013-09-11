
Owncloud Manual installation

~~~
wget -qO ~/own.tar.bz2 http://download.owncloud.org/community/owncloud-5.0.11.tar.bz2
tar xjf  ~/own.tar.bz2 -C ~/www/$(whoami).$(hostname)/public_html/
~~~

Now visit the URL in your browser, it will look something like this:

~~~
https://server.feralhosting.com/username/owncloud
~~~

The easiest way to install Owncloud is to use the sqlite database option (default)

**Important note:** If you are planning on using MySQL as the database you will need to follow this [FAQ](https://www.feralhosting.com/faq/view?question=9) and enable networking, make a note of your port and then restart MySQL on your slot.








