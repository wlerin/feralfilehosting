
[http://www.seafile.com/en/home/](http://www.seafile.com/en/home/)

This documentation is pretty comprehensive:

[http://manual.seafile.com/](http://manual.seafile.com/)

Requirements:
---

Python imaging library

~~~
pip install --user pil
~~~

Optional but recommended:
---

> **Important note:** You can use MySQL but for the initial set-up and configuration using Sqlite 3 is a lot easier. [http://manual.seafile.com/deploy/index.html](http://manual.seafile.com/deploy/index.html)

Sqlite 3

~~~
wget -qO ~/sqlite3.tar.gz http://www.sqlite.org/2015/sqlite-autoconf-3081002.tar.gz
tar xf ~/sqlite3.tar.gz && cd ~/sqlite-*/
./configure --prefix=$HOME && make && make install
cd && rm -rf ~/sqlite-*/ ~/sqlite3.tar.gz
~~~

Seafile

~~~
wget https://bintray.com/artifact/download/seafile-org/seafile/seafile-server_4.2.3_x86-64.tar.gz
tar xf seafile-server_4.2.3_x86-64.tar.gz && cd seafile-server-4.2.3
./setup-seafile.sh
~~~
What would you like to use as the name of this seafile server?
Your seafile users will be able to see the name in their seafile client.
You can use a-z, A-Z, 0-9, _ and -, and the length should be 3 ~ 15
[server name]: myserver

What is the ip or domain of this server?
For example, www.mycompany.com, or, 192.168.1.101

[This server's ip or domain]: 0.0.0.0

What tcp port do you want to use for ccnet server?
10001 is the recommended port.
[default: 10001 ] PORT1

Where would you like to store your seafile data? 
Note: Please use a volume with enough free space.
[default: /media/diskID/home/username/seafile-data ]   just press enter

What tcp port would you like to use for seafile server?
12001 is the recommended port.
[default: 12001 ] PORT2

What tcp port do you want to use for seafile fileserver?
8082 is the recommended port.
[default: 8082 ] PORT3

server name:        somename
server ip/domain:   0.0.0.0
server port:        PORT 1
seafile data dir:   /media/diskid/home/username/seafile-data
seafile port:       PORT 2
fileserver port:    PORT 3

~~~
./seafile.sh start
~~~

Starting the WebUi

~~~
./seahub.sh start PORT 4
~~~

What is the email for the admin account?
[ admin email ] an email address

What is the password for the admin account?
[ admin password ] 

Enter the password again:
[ admin password again ] 

The WebUi should be accessible via the URL format

username.server.feralhosting.com:PORT4



