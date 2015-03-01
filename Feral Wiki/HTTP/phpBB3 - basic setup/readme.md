
You will need to have MySQL already installed. You can do this from your [Manager](https://www.feralhosting.com/manager/)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_mysql.png)

In SSH do these commands. Use this FAQ if you do not know how to SSH into your slot: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

### Download and extract

Download the phpBB3 package:

~~~
wget -qO ~/phpbb3.zip https://www.phpbb.com/files/release/phpBB-3.1.3.zip
~~~

Then extract the file archive:

~~~
unzip -qo ~/phpbb3.zip -d ~/www/$(whoami).$(hostname -f)/public_html
~~~

Optional: Clean up by removing the phpBB3 zip

~~~
rm -f ~/phpbb3.zip
~~~

### Preparation

**1:** Make a limited access user and a new database to use with phpBB3 - [Adminer - MySQL administration](https://www.feralhosting.com/faq/view?question=116)

**2:** The continue with the installation.

### Installation

phpBB3 is now ready to install via a web browser.

It is highly recommended you follow this FAQ and create a new database with a limited user instead of using root as mentioned in Step 1 above - [How to install MySQL and MySQL Adminer for easy MySQL administration](https://www.feralhosting.com/faq/view?question=116)

Next Visit the web based installer, which by default is at:

> **Important note:** nginx users should use this full URL since the redirect to the installation causes issues. If you get redirected to a URL with `:8080` then remove the `:8080` from the address bar and press enter or use the full URL format below.

~~~
http://username.server.feralhosting.com/phpBB3/install/index.php
~~~

Progress with the installer.

**Important note:** Feral does not include email support via php mail. You will have to configure phpBB3 to use an external smtp service, like Google Apps.

### Database settings

**Important note:** Make sure you completed step 3 of the preparation.

Database type: `mysql`

Your socket path will be displayed on the Slot details page for the relevant slot.

**Database hostname:** `:/media/DiskID/username/private/mysql/socket`

**Database name:** The username you created in Adminer

**Database name:** The database you created in Adminer.

Leave all other fields blank or with their defaults.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/phpBB3 - basic setup/dbsettings-socket.png)

### URL Settings

While phpBB3 can use both URL formats, it will default to `username.server.feralhosting.com` as the primary URL format (noticeable with login redirects and similar). 

Fortunately we can change this without having to hack phpbb3.

When you arrive at Server URL Settings page of the installer, follow the pointers in the image to make the server.feralhosting.com/username URL format the default and primary one.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/HTTP/phpBB3 - basic setup/urlsettings.png)

Removing the installation folder
---

Once the set-up is complete you can use this command to remove the installation directory.

~~~
rm -rf ~/www/$(whoami).$(hostname -f)/public_html/phpBB3/install
~~~



