
### Feralhosting Mosh

Add the main binary location to your PATH using this command:

~~~
[[ ! "$(grep '~/programs/bin' ~/.bashrc)" ]] && echo 'export PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

### Protobuf

This is a required dependency that is not included with your slot.

~~~
mkdir -p ~/programs
wget -qO ~/protobuf-2.5.0.tar.gz http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
tar xf ~/protobuf-2.5.0.tar.gz && cd ~/protobuf-2.5.0
./configure --prefix=$HOME/programs && make && make install && cd
rm -rf  ~/protobuf-2.5.0.tar.gz ~/protobuf-2.5.0
~~~

### Mosh

Now download and install mosh:

~~~
wget -qO ~/mosh-1.2.4.tar.gz http://mosh.mit.edu/mosh-1.2.4.tar.gz
tar xf ~/mosh-1.2.4.tar.gz && cd ~/mosh-1.2.4
./configure --prefix=$HOME/programs PKG_CONFIG_PATH=$HOME/programs/lib/pkgconfig
make && make install && cd
rm -rf ~/mosh-1.2.4.tar.gz ~/mosh-1.2.4
~~~

Add the `LD_LIBRARY_PATH` using this command to overcome this error:

~~~
mosh-server: error while loading shared libraries: libprotobuf.so.8: cannot open shared object file: No such file or directory
~~~

By using this command:

~~~
[[ ! "$(grep '~/programs/lib' ~/.bashrc)" ]] && echo 'export LD_LIBRARY_PATH=~/programs/lib:$LD_LIBRARY_PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

Connect to your slot using this command.

~~~
mosh username@server.feralhosting.com --server="LANG=$LANG mosh-server"
~~~