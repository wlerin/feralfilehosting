
### configure

~~~
./configure --prefix=$HOME/programs
~~~

protobuf

~~~
./configure --prefix=$HOME/programs PKG_CONFIG_PATH=$HOME/programs/lib/pkgconfig
~~~

git

~~~
./configure --prefix=$HOME/programs --with-curl=$HOME/programs
~~~

~~~
./configure --prefix=$HOME/programs --with-curl=/opt/curl/current
~~~

### cmake

~~~
cmake -DPREFIX=$HOME/programs
~~~

~~~
cmake -DPREFIX=$HOME/programs -DCURL_LIBRARY=$HOME/programs/lib/libcurl.so -DCURL_INCLUDE_DIR=$HOME/programs/include
~~~

~~~
cmake -DCMAKE_INSTALL_RPATH=/opt/curl/current/lib -DPREFIX=$HOME/programs -DCURL_LIBRARY=/opt/curl/current/lib/libcurl.so -DCURL_INCLUDE_DIR=/opt/curl/current/include
~~~

### python

~~~
[[ ! "$(grep '~/.local/bin' ~/.bashrc)" ]] && echo 'PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

### Custom software installations PATHS commands

~~~
[[ ! "$(grep '~/programs/bin' ~/.bashrc)" ]] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

~~~
[[ ! "$(grep '~/programs/lib' ~/.bashrc)" ]] && echo 'export LD_LIBRARY_PATH=~/programs/lib:$LD_LIBRARY_PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

### bashrc PATHs

~~~
export PATH=~/.local/bin:$PATH
~~~

~~~
export PATH=~/programs/bin:$PATH
~~~

~~~
export LD_LIBRARY_PATH=~/programs/lib:$LD_LIBRARY_PATH
~~~