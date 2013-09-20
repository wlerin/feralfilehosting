
### Protobuf

This is a required dependency that is not included with your slot.

~~~
mkdir -p ~/private/programs
wget -qO ~/protobuf-2.5.0.tar.gz http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
tar xf ~/protobuf-2.5.0.tar.gz && cd ~/protobuf-2.5.0
./configure --prefix=$HOME/private/programs && make && make install && cd
~~~

### Mosh

~~~
wget -qO ~/mosh-1.2.4.tar.gz http://mosh.mit.edu/mosh-1.2.4.tar.gz
tar xf ~/mosh-1.2.4.tar.gz && cd ~/mosh-1.2.4
./configure --prefix=$HOME/private/programs PKG_CONFIG_PATH=$HOME/private/programs/lib/pkgconfig
make && make install && cd
~~~

**Important note:** Only run the echo command below if you have not already done so in this FAQ or another. You can check first using this command:

~~~
grep "~/private/programs" ~/.bashrc
~~~

No result means you have not used it. More than one result means you have used the command more than you needed. Remove duplicate entries.

If needed add the locations to your PATH/LD_LIBRARY_PATH using these commands.

~~~
echo 'PATH=~/private/programs/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
echo 'export LD_LIBRARY_PATH=~/private/programs/lib:$LD_LIBRARY_PATH' >> ~/.bashrc && source ~/.bashrc
~~~

~~~
mosh username@server.feralhosting.com --server="LANG=$LANG mosh-server"
~~~