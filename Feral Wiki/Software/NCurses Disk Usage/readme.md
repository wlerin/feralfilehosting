
Ncdu is a disk usage analyzer with an ncurses interface. It is designed to find space hogs on a remote server where you don't have an entire graphical setup available, but it is a useful tool even on regular desktop systems. Ncdu aims to be fast, simple and easy to use, and should be able to run in any minimal POSIX-like environment with ncurses installed.

You need to SSH into your slot to complete this guide. If you don't know how to do this [here is a basic guide](https://www.feralhosting.com/faq/view?question=12)

Automated Install
---

~~~
wget -qO ~/ncdu.install http://git.io/vTwuq && bash ~/ncdu.install
~~~

Manual Install
---

Check to see if dependencies are installed:

~~~
dpkg -s libncurses5-dev
dpkg -s libncursesw5-dev
~~~

If they are not, you will need to open a ticket for them to be installed before you continue.
sample:

~~~
Please can you install the libncurses5-dev libncursesw5-dev dependencies for NCDU?

https://packages.debian.org/en/wheezy/libncurses5-dev
https://packages.debian.org/en/wheezy/libncursesw5-dev

apt-get install libncurses5-dev libncursesw5-dev

Thank you.
~~~

Now install NCurses Disk Usage using these commands:

~~~
wget -qO ~/ncdu-1.11.tar.gz http://dev.yorhel.nl/download/ncdu-1.11.tar.gz
cd ~/ 
tar xvzf ncdu-1.11.tar.gz
cd ncdu-1.11
./configure --prefix="$HOME"
make
make install
cd ~/
rm -r ~/ncdu-1.11*
~~~

If ~/bin is already in your $PATH, then do this to run NCurses Disk Usage.

~~~
ncdu ~/
~~~

Otherwise, run it like this:

~~~
~/bin/ncdu ~/
~~~

Usage
---

Use the arrow keys, enter, and delete to navigate (or vim movement keys), and 'q' to quit"



