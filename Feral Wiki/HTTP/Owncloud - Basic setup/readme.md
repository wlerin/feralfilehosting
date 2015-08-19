
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

Using Owncloud with the valid SSL URL format instead of the default.
---

If you want to be able to use the valid SSL URL with Owncloud you must make these edits.

Inside your `/owncloud` installation is a folder called `config` and inside this is a file called `config.php`.

So the relative path to to this file from your server root will be:

~~~
owncloud/config/config.php
~~~

To edit this file using nano:

~~~
nano -w ~/www/$(whoami).$(hostname -f)/public_html/owncloud/config/config.php
~~~

Open this file with a text editor and add these new options:

~~~
  'overwritehost' => 'server.feralhosting.com',
  'overwritewebroot' => '/username/owncloud',
~~~

Where `server` is the name of your Feral server that is hosting owncloud and where `username` is your Feral username.

**1:** Once you have done this your `config.php` will look something like this with the two new customised lines added at the end:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/config.png)

Now Owncloud will work with the valid SSL URL format and not the other. All 3rd party apps will also work, so this is the best approach to dealing with the issue.

These options are taken from the `config.sample.php` located in the same directory.

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

Using MySQL with Owncloud:
---

> **Important note:** You will need to have MySQL already installed. MySQL can take up to 15 minutes to install as it is compiled upon request of installation so please be patient:

You can do this from the `Install Software` link in your [Account Manager](https://www.feralhosting.com/manager/) for the relevant slot.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_mysql.png)

Then click the button to install MySQL.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_software_button.png)

> **Important note:** You will see the installation process listed as pending. Refresh the page periodically to see when it has been completed. 

Take note of your `Socket` path and your `Password` once the installation is completed.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/mysql_socket.png)

Configuring Owncloud to use MySQL:
---

**1:** Select Mysql as the database type. The use these settings to configure Owncloud and MySQL.

**2:**Username: `root`
**3:**Password: Your mysql root user password
**4:**Database name: `owncloud`
**5:**Hostname: `localhost:/media/DiskID/home/username/private/mysql/socket`
**6:** Click on `Finish setup`

Where the `/media/DiskID/home/username/private/mysql/socket` is your socket path listed on the Slot Details page for the relevant slot.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/Owncloud%20-%20Basic%20setup/mysql.png)

Owncloud will then use the root account to configure the required users and databases. The MySQL set-up can take a few minutes to complete so please be patient.



