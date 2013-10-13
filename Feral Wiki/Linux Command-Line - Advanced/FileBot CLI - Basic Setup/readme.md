
Filebot basic installation to use the command line options (no GUI) on your Feral slot.

FileBot is the ultimate tool for organizing and renaming your movies, tv shows or anime, and music well as downloading subtitles and artwork. It's smart and just works.

Powerful and full-featured cmdline interface and scripting interface for any kind of automation

[Filebot Command Line](http://www.filebot.net/cli.html)

### FileBot CLI setup

The download, unpacking and editing.

~~~
wget -qO ~/filebot.deb "http://www.filebot.net/download.php?mode=s&type=deb&arch=amd64"
dpkg-deb -x ~/filebot.deb ~/filebot
cp -rf ~/filebot/usr/share/filebot/. ~/filebot && rm -rf ~/filebot/usr
sed -i 's|/usr/share/|'$HOME/'|g' ~/filebot/bin/filebot.sh
~~~

Now to run filebot you would do this, which will also show you the `-help` page to:

### FileBot CLI - usage

~~~
~/filebot/bin/filebot.sh
~~~

~~~
~/filebot/bin/filebot.sh -rename path/to/episodes
~~~

Please refer to this page: [Filebot Command Line](http://www.filebot.net/cli.html) for more options.



