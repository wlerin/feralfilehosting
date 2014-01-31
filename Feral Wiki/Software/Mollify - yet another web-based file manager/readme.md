
**Important note:** Apache only

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
---

2.1: Move to the WWW root using this command via SSH

~~~
cd ~/www/$(whoami).$(hostname)/public_html/
~~~

2.2: Download and unzip the file using wget and zip via SSH using this command 

~~~
wget -qO mollify.zip http://www.mollify.org/download/latest.php
unzip -qo mollify.zip && rm -f mollify.zip
~~~

2.3: Create and open a file called `configuration.php` using this command: 

~~~
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

1: You will need to change the `SOCKETPATH` with the path to your MySQL socket found on the Slot details page for the relevant slot.
2: You will need to use a valid MySQL username and replace `USERNAME` with your username.
3: You will need to use this users' password and replace `PASSWORD` with this users password.

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




