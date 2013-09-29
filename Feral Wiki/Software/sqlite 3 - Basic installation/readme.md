
A very basic guide to manual installation of sqlite 3.

~~~
mkdir -p ~/programs
[ -z "$(grep '~/programs/bin' ~/.bashrc)" ] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

~~~
wget -qO ~/sqlite3.tar.gz http://www.sqlite.org/2013/sqlite-autoconf-3080002.tar.gz
tar xf ~/sqlite3.tar.gz && cd ~/sqlite-*/
./configure --prefix=$HOME/programs && make && make install
cd && rm -rf ~/sqlite-*/ ~/sqlite3.tar.gz
~~~

For some applications you will have to link to this location, for example:

~~~
env CPPFLAGS="-I$HOME/programs/include" LDFLAGS="-L$HOME/programs/lib" ./configure --prefix=$HOME/programs
~~~

### Just the Binary

~~~
wget -qO ~/sqlite.deb http://ftp.uk.debian.org/debian/pool/main/s/sqlite/sqlite_2.8.17-8_amd64.deb
dpkg-deb -x ~/sqlite.deb ~/sqlitetmp
cp -rf ~/sqlitetmp/usr/bin/. ~/programs/bin
~~~