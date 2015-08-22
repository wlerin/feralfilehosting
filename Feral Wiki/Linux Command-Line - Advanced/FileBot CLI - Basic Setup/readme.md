
**Important note:** You will need to have Java 1.8 installed locally to use this program - [Java 1.8](https://www.feralhosting.com/faq/view?question=183)

From the [Filebot FAQ](https://www.filebot.net/forums/viewtopic.php?f=3&t=7#p7)

**Q:** When I try to start filebot it crashes immediately with an UnsupportedClassVersionError. What does that mean?

**A:** If you get an error like Exception in thread "main" java.lang.UnsupportedClassVersionError: net/filebot/Main : Unsupported major.minor version 52.0 it means that you're running Java 6 or 7 but Java 8 is required for running FileBot.

Filebot:
---

Filebot basic installation to use the command line options (no GUI) on your Feral slot.

FileBot is the ultimate tool for organizing and renaming your movies, tv shows or anime, and music well as downloading subtitles and artwork. It's smart and just works.

Powerful and full-featured cmdline interface and scripting interface for any kind of automation

[Filebot Command Line](http://www.filebot.net/cli.html)

FileBot CLI setup
---

The download, unpacking and editing.

~~~
wget -qO ~/filebot.zip http://downloads.sourceforge.net/project/filebot/filebot/FileBot_4.6/FileBot_4.6-portable.zip
unzip -qo ~/filebot.zip -d ~/filebot && rm -f ~/filebot.zip
~~~

Now to run filebot you would do this, which will also show you the `-help` page to:

FileBot CLI - usage
---

~~~
~/filebot/filebot.sh
~~~

~~~
~/filebot/bin/filebot.sh -rename "$HOME/path/to/episodes"
~~~

Use `" "` around paths. Use `$HOME` in paths instead of `~`. Filebot gets confused about the `~`

Please refer to this page: [Filebot Command Line](http://www.filebot.net/cli.html) for more options.



