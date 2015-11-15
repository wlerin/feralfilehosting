
**Important note:** For using Owncloud With nginx please complete the nginx section of this guide first.

Owncloud Manual installation
---

In [SSH](https://www.feralhosting.com/faq/view?question=12) run this command. It will download the `setup.php` to the root of your `WWW`

~~~
wget -P ~/www/$(whoami).$(hostname -f)/public_html/ https://download.owncloud.com/download/community/setup-owncloud.php
~~~

Now visit the URL in this format, in your browser, it will look something like this:

 **Important note:** If you use or force https you may need to unblock the remote content of the installer in Firefox.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/https.png)

~~~
http://username.server.feralhosting.com/setup-owncloud.php
~~~

You should be able to just click on this file from your apache/nginx/h5ai index.

**1:** Just click next

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/web-install-1.png)

**2:** Leave the installation directory as `owncloud`. This will create and install it to a the `/owncloud` directory in your server root.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/web-install-2.png)

**3:** Click next when done to visit the final stage of the setup.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/web-install-3.png)

The easiest way to install Owncloud is to use the sqlite database option (default). 

Once you have visited the URL in a browser you will see this:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/1.png)

nginx
---

 **Important note:** This configuration depends on the user installing owncloud to the default location which is the subdirectory `/owncloud` inside the `public_html` folder.

**Owncloud custom conf:**

Now download a preconfigured conf file to use in conjunction with this edit:

~~~
wget -qO ~/.nginx/conf.d/000-default-server.d/owncloud.conf http://git.io/nVy4Cg
~~~

Now run this command in SSH:

 **Important note:** You need to run this command at least once to properly configure the `owncloud.conf`

~~~
sed -ri "s|fastcgi_pass(.*);|fastcgi_pass    unix:$HOME/.nginx/php/socket;|g" ~/.nginx/conf.d/000-default-server.d/owncloud.conf
~~~

Now reload nginx:

~~~
/usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf
~~~

Owncloud should now work as intended with nginx.
