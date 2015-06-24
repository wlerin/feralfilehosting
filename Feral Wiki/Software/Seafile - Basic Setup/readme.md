
Python imaging library

~~~
pip install --user pil
~~~

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

server name:        somename
server ip/domain:   0.0.0.0
server port:        PORT 1
seafile data dir:   /media/diskid/home/username/seafile-data
seafile port:       PORT 2
fileserver port:    PORT 3

~~~
./seafile.sh start PORT 4
./seahub.sh start
~~~

