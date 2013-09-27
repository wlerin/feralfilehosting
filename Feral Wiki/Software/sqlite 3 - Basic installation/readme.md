
A very basic guide to manual installation of sqlite 3.

~~~
wget -qO ~/sqlite3.tar.gz http://www.sqlite.org/2013/sqlite-autoconf-3080002.tar.gz
tar -xzf ~/sqlite3.tar.gz && cd ~/sqlite-*/
./configure --prefix=$HOME/programs && make && make install
cd && rm -rf ~/sqlite-*/ ~/sqlite3.tar.gz
~~~

Now you can also add the bin path to your PATH to execute the sqlite 3 binary more easily:

~~~
[ -z "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
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