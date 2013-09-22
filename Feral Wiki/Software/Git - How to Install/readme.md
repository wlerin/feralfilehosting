
### Git 1.7.10.4

This command will show you your installed Git version

~~~
git --version
~~~

If you specifically need a higher version you can used the FAQ to install 1.8.3.1.

### Git 1.8.4.0

You need to SSH into your slot to complete this guide. If you don't know how to do this [here is a basic guide](https://www.feralhosting.com/faq/view?question=12)

~~~
mkdir -p ~/programs
wget -qO ~/git-1.8.4.tar.gz  http://git-core.googlecode.com/files/git-1.8.4.tar.gz
tar -xzf ~/git-1.8.4.tar.gz && cd ~/git-1.8.4
./configure --prefix=$HOME/programs && make && make install
cd && rm -rf ~/git-1.8.4 git-1.8.4.tar.gz
~~~

Git has been installed. Now use this command to add the PATH to your `~/.bashrc`

~~~
[ -z "$(grep '~/programs/bin' ~/.bashrc)" ] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

Then do this to check the version.

~~~
git --version
~~~

You can now do things like clone. Here is an example command:

~~~
git clone git://github.com/username/repo.git ~/where/you/want/this/repo
~~~



