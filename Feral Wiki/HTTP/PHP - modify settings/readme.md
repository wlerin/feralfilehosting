
Apache using htaccess
---

In your `.htaccess` files you can add these lines and change the paths or numbers to match yours:

**Important note:** `.htaccess` files work recursively from their current location. If you want some settings to apply to the entire server put these settings in a `.htaccess` in your server root. If you only need them to apply to certain directories, place the settings in a `.htaccess` within those directories.

This is an example of the `.htaccess` in your server root.

Where `username` is your Feral username and `server` is the name of the server your slot is hosted on.

~~~
~/www/username.server.feralhosting.com/public_html/.htaccess
~~~

**Default Socket setting**

~~~
php_value pdo_mysql.default_socket "/media/DiskID/home/username/private/mysql/socket"
php_value mysql.default_socket "/media/DiskID/home/username/private/mysql/socket"
php_value mysqli.default_socket "/media/DiskID/home/username/private/mysql/socket"
~~~

Will make it so `localhost` uses these socket paths.

If networking has been enabled in your `~/private/mysql/my.conf` you can also set these:

**Default port settings**

~~~
php_value mysql.default_port 23456
php_value mysqli.default_port 23456
~~~

This will define the default port.

**Modifying other settings:**

The basic concept is this:

~~~
php_value some_setting value/path
~~~

For example:

~~~
php_value max_execution_time 100
~~~

This will change the default value from 30 to 100

**Max file upload size**

~~~
php_value upload_max_filesize 100M
php_value post_max_size 100M
php_value max_input_time 300
php_value max_execution_time 300
php_value memory_limit = 100M
~~~

Will allow larger file uploads, up to `100M`.

Apache using php.ini
---

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

~~~
cp -f /etc/php5/apache2/php.ini ~/.apache2/php.ini
echo -n 'PHPINIDir "${HOME}/.apache2/php.ini"' > ~/.apache2/conf.d/php.conf
/usr/sbin/apache2ctl -k graceful
~~~

You can now edit your php.ini at `~/.apache2/php.ini`. For changes to take effect you must reload the Apache conf files using thins command:

For default socket settings find and edit these options:

~~~
pdo_mysql.default_socket
mysql.default_socket
mysqli.default_socket
~~~

Change them to this, where the MySQL socket path is the path listed  in the MySQL section of the slot details page for the relevant slot.

~~~
pdo_mysql.default_socket = /media/DiskID/home/username/private/mysql/socket
mysql.default_socket = /media/DiskID/home/username/private/mysql/socket
mysqli.default_socket = /media/DiskID/home/username/private/mysql/socket
~~~

When you have finished editing then reload Apache for the settings to take effect. 

~~~
/usr/sbin/apache2ctl -k graceful
~~~

> **Important note:** This error  is normal and you can ignore it.

~~~
mkdir: cannot create directory `/var/run/apache2': Permission denied
~~~

nginx using php.ini
---

You will have to have already updated to nginx for these commands to work using this FAQ - [Updating Apache to nginx](https://www.feralhosting.com/faq/view?question=231)

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

~~~
mv -f ~/.nginx/php/php.ini  ~/.nginx/php/php.ini.bak
cp -f /etc/php5/fpm/php.ini ~/.nginx/php/php.ini
~~~

Now you can edit your `php.ini` located at:

~~~
~/.nginx/php/php.ini
~~~

For default socket settings find and edit these options:

~~~
pdo_mysql.default_socket
mysql.default_socket
mysqli.default_socket
~~~

Change them to this, where the MySQL socket path is the path listed  in the MySQL section of the slot details page for the relevant slot.

~~~
pdo_mysql.default_socket = /media/DiskID/home/username/private/mysql/socket
mysql.default_socket = /media/DiskID/home/username/private/mysql/socket
mysqli.default_socket = /media/DiskID/home/username/private/mysql/socket
~~~

Restart nginx for the changes to take effect:

~~~
killall -9 -u $(whoami) nginx php5-fpm
~~~

Now wait until it restarts within 5 minutes.



