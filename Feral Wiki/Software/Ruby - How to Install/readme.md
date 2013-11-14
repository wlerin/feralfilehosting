
You need to SSH into your slot to complete this guide. If you don't know how to do this [here is a basic guide](https://www.feralhosting.com/faq/view?question=12):

~~~
mkdir -p ~/programs
[[][/[][ ! "$(grep '~/programs/bin' ~/.bashrc)" ]] && echo 'export PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc

~~~
wget -qO ~/ruby.tar.gz http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar xf ~/ruby.tar.gz && cd ~/ruby-*
./configure --prefix=$HOME/programs && make && make install
cd && rm -rf ~/ruby-* ~/ruby.tar.gz
~~~

###Check our versions:###

Now these to check your versions:

~~~
ruby -v
gem -v
~~~

This command to update gems to 2.0.3

~~~
gem update --system
~~~



