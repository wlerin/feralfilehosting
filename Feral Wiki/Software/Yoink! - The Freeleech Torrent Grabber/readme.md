
### Yoink! The Freeleech Torrent Grabber

[Yoink!](https://github.com/phracker/yoink)

In SSH do these commands. Use this faq if you do not know how to SSH into your slot: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

**Important note:** Only run the echo command below if you have not already done so in this FAQ or another. You can check first using this command:

~~~
grep "~/.local/bin" ~/.bashrc
~~~

No result means you have not used it. More than one result means you have used the command more than you needed. Remove extra entries.

Add the location to your PATH using this command.

~~~
echo 'PATH=~/.local/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
~~~

### Download and prepare Yoink!

~~~
wget -qO ~/yoink.py https://raw.github.com/phracker/yoink/master/yoink.py
easy_install --user pip
pip install --user requests HTMLParser
python ~/yoink.py
~~~

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Yoink!%20-%20The%20Freeleech%20Torrent%20Grabber/1.png)

Now you will need to configure the `~/.yoinkrc` file:

Run this command to edit it with nano in SSH:

~~~
nano ~/.yoinkrc
~~~

Then Make these edits:

~~~
user:What.CDusername
password:What.CDWebsitePass
target:FullPathToRtorrentWatchFolder
~~~

For example:

~~~
user:peterpan
password:sds32tsekjfsd893
target:/media/DiskID/username/home/private/rtorrent/watch
~~~

Now run the script again:

~~~
python ~/yoink.py
~~~

Wait fort it to finish Yoinking.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Yoink!%20-%20The%20Freeleech%20Torrent%20Grabber/2.png)

### crontab

~~~
crontab -e
~~~

Add this line for it to run every hour, edit as you see fit:

~~~
00 * * * * python ~/yoink.py
~~~

Press and hold `CTRL` then press `x` to save. Press `y` to confirm and exit.