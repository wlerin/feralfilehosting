
Installing Murmur 
===

"Magic" Installer 
---

To install Murmur on your seedbox, you should use this script

~~~
wget -qO ~/install.murmur http://git.io/-mVd3g && bash ~/install.murmur
~~~

Simply grab the script with wget or curl on your machine, run it, and you'll have Murmur installed at 

~~~
~/murmur/murmurd
~~~

Once you're done with that, please read the `Configuring Murmur.ini` section.

Note: This script does nothing malicious. If you find a bug, please edit this Wiki page to note it, or message

~~~
zovt
~~~

on IRC.

Configuring Murmur.ini 
---

At this point, running

~~~
~/murmur/murmurd
~~~

will start murmur and leave you with a working server. However, this will pollute whatever directory you're running it from with log files and database files. If you don't want that, read on.

By default, the above script should have created a file called

~~~
murmur.ini
~~~

in

~~~
~/murmur/
~~~

Fire up your favorite text editor and edit

~~~
~/murmur/murmur.ini
~~~

and change the paths on the following lines in the file to whatever you like:

~~~
database=
logfile=
pidfile=
~~~

I personally like just adding

~~~
~/murmur
~~~

to the front of the paths, but you can use any directory you'd like.

All Done! 
---

Now, run murmur with

~~~
~/murmur/murmurd -ini ~/murmur/murmur.ini
~~~

connect, and you're good to go!



