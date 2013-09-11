
Owncloud Manual installation

~~~
wget -qO ~/own.tar.bz2 http://download.owncloud.org/community/owncloud-5.0.11.tar.bz2
tar xjf  ~/own.tar.bz2 -C ~/www/$(whoami).$(hostname)/public_html/
~~~

Now visit the URL in your browser, it will look something like this:

~~~
https://server.feralhosting.com/username/owncloud
~~~

The easiest way to install Owncloud is to use the sqlite database option (default). Using MySQL can be done but requires a lot of extra steps that we are not going to cover in this basic set-up.

Once you have visited the URl in a browser you will see this:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Owncloud%20-%20Basic%20setup/1.png)







