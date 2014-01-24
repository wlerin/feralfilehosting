

What is Mollify?
---

Mollify is a web file manager for publishing and managing files hosted in a web server of your choice. Different users can have access to different files and with different permissions.

User interface is simple and intuitive, and it is totally customizable. See Features for complete list of features.

Mollify is published with GPLv2 license. For details and commercial license, see license.


![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Mollify%20-%20yet%20another%20web-based%20file%20manager/example.png)

Features
---

[http://www.mollify.org/features.php](http://www.mollify.org/features.php)

Installation
----

2.1: Move to the WWW root using this command via SSH

~~~
cd ~/www/$(whoami).$(hostname)/public_html/
~~~

2.2: Download and unzip the file using wget and zip via SSH using this command 

~~~
wget -qO mollify.zip http://www.mollify.org/download/latest.php
unzip -qo mollify.zip
~~~

2.3: Create and open a file called `configuration.php` using this command: 

~~~
echo -n > mollify/backend/configuration.php
nano -w mollify/backend/configuration.php
~~~

For a very simple and fast setup just copy and paste this:

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "sqlite3",
            "file" => "my.db"
        )
    );
?> 
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

You are now ready to create an admin account and start using mollify:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Mollify%20-%20yet%20another%20web-based%20file%20manager/2.png)

Installation options.
---

**Important note:** There is commas at the end of each line are important in the configuration file and are required except for the last. Make sure each line insdie the `"db" => array( )` is terminated with a  `,` except for the last line. For example:

~~~
"db" => array(
    "type" => "",
    "user" => "",
    "password" => "",
    "table_prefix" => ""
)
~~~

### Using mysql:

1: It is required you have installed MySQL via your Manager for the relevant slot. Use this FAQ - [Installing Software](https://www.feralhosting.com/faq/view?question=6)

2: It is suggested you create a limited user following this FAQ [adminer](https://www.feralhosting.com/faq/view?question=116). This is an optional but recommended step, to create a limited user.

Once you have done both of these steps you can continue to install Mollify using MySQL

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "mysql",
            "user" => "USERNAME",
            "password" => "PASSWORD",
            "socket" => "/media/DiskID/home/username/private/mysql/socket",
            "database" => "mollify",
            "table_prefix" => "mollify_",
            "charset" => "utf8"
        )
    );
?> 
~~~

### Using PDO

**Sqlite:**

1: Create a username and replace `username` with this new username.
2: Generate a good password and replace `password` with this new password.

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "pdo",
            "str" => "sqlite:mollify.db",
            "user" => "username",
            "password" => "password",
            "table_prefix" => "mollify_"
        )
    );
?>
~~~

For example:

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "pdo",
            "str" => "sqlite:mollify.db",
            "user" => "testuser",
            "password" => "qwas124145cv35",
            "table_prefix" => "mollify_"
        )
    );
?>
~~~

Then it is ready to use.

**MySQL:**

1: You will need to change the `SOCKETPATH` with the path to your MySQL socket found on the Slot details page for the relevant slot.
2: You will need to use a valid MySQL username and replace `username` with your username.
3: You will need to use this users' password and replace `password` with this users password.

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "pdo",
            "str" => "mysql:unix_socket=SOCKETPATH;dbname=mollify",
            "user" => "username",
            "password" => "password",
            "table_prefix" => "mollify_"
        )
    );
?> 
~~~

For example:

~~~
<?php
    $CONFIGURATION = array(
        "db" => array(
            "type" => "pdo",
            "str" => "mysql:unix_socket=/media/DiskID/home/username/private/mysql/socket;dbname=mollify",
            "user" => "testuser",
            "password" => "214kolvnmds813",
            "table_prefix" => "mollify_"
        )
    );
?>
~~~

Then it is ready to use.

3: Post-Installation
----

In order to make the most out of Mollify, you'll need to create *Published Folders*, Users and Groups.  These can all be managed from within the Admin Pane and it is very straight forward.  You can link to anywhere within your Feral slot and the files will become accessible, even private folders. *Once created, make sure directories, groups and users are checked.*

Mollify also supports a plugin architecture.  You can get the plugins from their [download page](http://code.google.com/p/mollify/downloads/list).  

Download the plugins you want to install, extract them then upload to the following directories:

Plugins that start with `plugin` go in the  folder:

~~~
~/www/user.server.feralhosting.com/public_html/mollify/backend/plugin/
~~~

Plugins that begin with `viewer` go in the folder:

~~~
~/www/user.server.feralhosting.com/public_html/mollify/backend/plugin/FileViewerEditor/viewers/
~~~

NOTE: Using the Flowplayer plugin as an example, the downloaded file will be `viewer_flowplayer_1.0.zip`. Do not upload this extracted folder, but go inside and find the `Flowplayer` folder. That is the folder to be uploaded to the `viewer` directory.

~~~
cd ~/www/$(whoami).$(hostname)/public_html/mollify/backend/plugin/FileViewerEditor/viewers/
wget -qN http://mollify.googlecode.com/files/viewer_flowplayer_1.0.zip
unzip -qo viewer_flowplayer_1.0.zip && rm -f viewer_flowplayer_1.0.zip
~~~

Once plugins are installed into their appropriate folders, [reference my pastebin configuration](http://pastebin.com/twzZae9t). 

Add the new information to your `configuration.php` file and save. Some changes require you to check for an update to the mysql database.  You can check for updates by going to:

~~~
http(s)://user.server.feralhosting.com/mollify/update
~~~

Your configuration.php file should now look like this:

~~~
<?php
    $CONFIGURATION_TYPE = "mysql";
    $DB_HOST = "";
    $DB_PORT = "";
    $DB_DATABASE = "DATABASE";
    $DB_USER = "root";
    $DB_PASSWORD = "xxxxx";
    $DB_SOCKET = "/media/xxx/home/xxx/private/mysql/socket";
    $DB_TABLE_PREFIX = "mollify_";
 
        $PLUGINS = array(
                "FileViewerEditor" => array(
                        "viewers" => array(
                                "Image" => array("gif", "png", "jpg"),
                                "TextFile" => array("txt", "php", "html"),
                                "JPlayer" => array("mp3"),
                                "Divx" => array("avi", "mkv"),
                            //  "VLC" => array("mp4", "mkv", "avi")
                                "FlowPlayer" => array("f4v", "flv", "mp4")
                        ),
                        "previewers" => array(
                                "Image" => array("gif", "png", "jpg")
                        ),
                        "editors" => array(
                                "TextFile" => array("txt")
                        ),
                )
        );
?>
~~~

NOTE: The commenting out `//` in front of VLC under `$PLUGINS = array` is necessary.  When removing the `//` it will not load the Mollify page. Not sure why this is, but you may have different experiences with it.

After updating the configuration file and completing the settings in the Admin Pane, you can access Mollify by going to: `http(s)://server.feralhosting.com/user/mollify/`

4: Notes
----

1: Where you see `username` in directories/url's, insert your Feral username and where you see `server`, insert your server name.

2: Playing video files may require add-ons or plug-ins to be present in your browser, such as divx+, quicktime or java.

3: Under the Installation section, the $ are not necessary.



