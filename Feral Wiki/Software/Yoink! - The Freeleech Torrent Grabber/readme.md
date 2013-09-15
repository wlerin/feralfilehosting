
### Yoink! The Freeleech Torrent Grabber

[Yoink!](https://github.com/phracker/yoink)

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

Configure the `~/.yoinkrc` file

~~~
nano ~/.yoinkrc
~~~

Then Make these edits:

~~~
user:What.CDusername
password:What.CDWebsitePass
target:FullPathToRtorrentWatchFolder
~~~

Now run the script again:

~~~
python ~/yoink.py
~~~

Wait fort it to finish Yoinking.