
### Prep

~~~
mkdir -p ~/programs
[[ ! "$(grep '~/.local/bin' ~/.bashrc)" ]] && echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
[[ ! "$(grep '~/programs/bin' ~/.bashrc)" ]] && echo 'export PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
[[ ! "$(grep '~/programs/lib' ~/.bashrc)" ]] && echo 'export LD_LIBRARY_PATH=~/programs/lib:$LD_LIBRARY_PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

### Curl

~~~
wget -qO ~/curl.tar.gz http://curl.haxx.se/download/curl-7.33.0.tar.gz
tar xf ~/curl.tar.gz && cd ~/curl-7.33.0
./configure --prefix=$HOME/programs
make && make install && cd && rm -rf ~/curl-7.33.0 ~/curl.tar.gz
~~~

### Cmake

~~~
wget -qO ~/cmake.tar.gz http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
tar xf ~/cmake.tar.gz && cd ~/cmake-2.8.12
./bootstrap --prefix=$HOME/programs
./configure --prefix=$HOME/programs
make && make install && cd && rm -rf ~/cmake.tar.gz ~/cmake-2.8.12
~~~

### WeeChat - curl first

~~~
wget -qO ~/weechat.tar.gz http://www.weechat.org/files/src/weechat-0.4.2.tar.gz
tar xf ~/weechat.tar.gz && cd ~/weechat-0.4.2
cmake -DPREFIX=$HOME/programs
~~~

Feral default:

~~~
cmake -DCMAKE_INSTALL_RPATH=/opt/curl/current/lib -DPREFIX=$HOME/programs -DCURL_LIBRARY=/opt/curl/current/lib/libcurl.so -DCURL_INCLUDE_DIR=/opt/curl/current/include
~~~

Curl installed to `~/programs`:

~~~
cmake -DPREFIX=$HOME/programs -DCURL_LIBRARY=$HOME/programs/lib/libcurl.so -DCURL_INCLUDE_DIR=$HOME/programs/include
~~~

~~~
make && make install && cd && rm -rf ~/weechat.tar.gz ~/weechat-0.4.2
~~~

### node

~~~
wget -qO ~/node.tar.gz http://nodejs.org/dist/v0.10.20/node-v0.10.20.tar.gz
tar xf ~/node.tar.gz && cd ~/node-v0.10.*
./configure --prefix=$HOME/programs
make && make install && cd && rm -rf ~/node-v0.10.*/ ~/node.tar.gz
~~~

### git - curl first

~~~
wget -qO ~/git-1.8.4.2.tar.gz http://git-core.googlecode.com/files/git-1.8.4.2.tar.gz
tar xf ~/git-1.8.4.2.tar.gz && cd ~/git-1.8.4.2
~~~

Feral default:

~~~
./configure --prefix=$HOME/programs --with-curl=/opt/curl/current
~~~

Curl installed to `~/programs`

~~~
./configure --prefix=$HOME/programs --with-curl=$HOME/programs
~~~

~~~
make && make install && cd && rm -rf ~/git-1.8.4.2 git-1.8.4.2.tar.gz
~~~

~~~
git clone https://github.com/RuudBurger/CouchPotatoServer.git ~/.couchpotato && mkdir ~/.couchpotato/ssl
~~~

### Protobuf

~~~
wget -qO ~/protobuf-2.5.0.tar.gz http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
tar xf ~/protobuf-2.5.0.tar.gz && cd ~/protobuf-2.5.0
./configure --prefix=$HOME/programs && make && make install && cd && rm -rf  ~/protobuf-2.5.0.tar.gz ~/protobuf-2.5.0
~~~

### Mosh - protobuf needs to be done first

~~~
wget -qO ~/mosh-1.2.4.tar.gz http://mosh.mit.edu/mosh-1.2.4.tar.gz
tar xf ~/mosh-1.2.4.tar.gz && cd ~/mosh-1.2.4
./configure --prefix=$HOME/programs PKG_CONFIG_PATH=$HOME/programs/lib/pkgconfig
make && make install && cd && rm -rf ~/mosh-1.2.4.tar.gz ~/mosh-1.2.4
~~~

### sqlite

~~~
wget -qO ~/sqlite3.tar.gz http://www.sqlite.org/2013/sqlite-autoconf-3080002.tar.gz
tar xf ~/sqlite3.tar.gz && cd ~/sqlite-*/
./configure --prefix=$HOME/programs && make && make install && cd && rm -rf ~/sqlite-*/ ~/sqlite3.tar.gz
~~~

Some programs require linking to the installation like this:

~~~
env CPPFLAGS="-I$HOME/programs/include" LDFLAGS="-L$HOME/programs/lib" ./configure --prefix=$HOME/programs
~~~

### librsync

~~~
wget -qO ~/librsync.tar.gz http://downloads.sourceforge.net/project/librsync/librsync/0.9.7/librsync-0.9.7.tar.gz
tar xf ~/librsync.tar.gz && cd ~/librsync-0.9.7
./configure --prefix=$HOME/programs --with-pic
make && make install && cd && rm -rf ~/librsync-0.9.7 ~/librsync-0.9.7
~~~

### duplicity

~~~
wget -qO ~/duplicity.tar.gz http://code.launchpad.net/duplicity/0.6-series/0.6.22/+download/duplicity-0.6.22.tar.gz
tar xf ~/duplicity.tar.gz && cd ~/duplicity-0.6.22
python setup.py install --prefix=$HOME/.local --librsync-dir=$HOME/programs
cd && rm -rf ~/duplicity-0.6.22 ~/duplicity.tar.gz
~~~

### ZNC

~~~
mkdir -p ~/programs
wget -qO ~/znc.tar.gz http://znc.in/releases/znc-latest.tar.gz
tar xf ~/znc.tar.gz && cd ~/znc-*
./configure --prefix=$HOME/programs
make && make install && cd
rm -rf ~/znc.tar.gz ~/znc-*
~~~

~~~
znc --makeconf
~~~

### ffmpeg static

~~~
wget -qO ~/ffmpeg.tar.gz http://ffmpeg.gusari.org/static/64bit/ffmpeg.static.64bit.2013-09-16.tar.gz
mkdir -p ~/ffmpeg && tar xf ~/ffmpeg.tar.gz -C ~/ffmpeg && rm -f ~/ffmpeg.tar.gz
echo 'export PATH=~/ffmpeg:$PATH' >> ~/.bashrc && source ~/.bashrc
ffmpeg -version
~~~

### filebot

~~~
wget -qO ~/filebot.deb "http://www.filebot.net/download.php?mode=s&type=deb&arch=amd64"
dpkg-deb -x ~/filebot.deb ~/filebot
cp -rf ~/filebot/usr/share/filebot/. ~/filebot && rm -rf ~/filebot/usr
sed -i 's|/usr/share/|'$HOME/'|g' ~/filebot/bin/filebot.sh
bash ~/filebot/bin/filebot.sh
~~~

### Sphinx search

~~~
mkdir -p ~/programs
wget -qO ~/sphinx.tar.gz http://sphinxsearch.com/files/sphinx-2.1.2-release.tar.gz
tar xf ~/sphinx.tar.gz && cd ~/sphinx-2.1.2-release
./configure --prefix=$HOME/programs --with-mysql=$HOME/private/mysql
make && make install && cd
rm -rf ~/sphinx.tar.gz ~/sphinx-2.1.2-release
~~~

