
[http://wired.read-write.fr/](http://wired.read-write.fr/)

~~~
mkdir -p ~/programs
[ -z "$(grep '~/wired' ~/.bashrc)" ] && echo 'PATH=~/wired:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

~~~
wget -qO ~/wired.tar.gz http://downloads.sourceforge.net/project/wired2/wired/wired.tar.gz
tar xf ~/wired.tar.gz && cd ~/wired
env CPPFLAGS="-I$HOME/programs/include" LDFLAGS="-L$HOME/programs/lib" ./configure --prefix=$HOME/ --with-user=$(whoami) --with-group=$(whoami)
make && make install
rm -rf ~/wired ~/wired.tar.gz 
~~~

