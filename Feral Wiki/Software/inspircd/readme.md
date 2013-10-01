	
~~~
mkdir -p ~/programs
wget -qO ~/v2.0.14.tar.gz https://github.com/inspircd/inspircd/archive/v2.0.14.tar.gz
tar -xzf ~/v2.0.14.tar.gz
cd ~/inspircd-2.0.14
./configure --prefix=$HOME/programs
make
make install
cd && rm -rf ~/inspircd-2.0.14  ~/v2.0.14.tar.gz
~~~
