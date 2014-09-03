
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

ruTorrent plug-ins
---

To install any plug-in you require you will need to install it from the [ruTorrent github repo](https://github.com/Novik/ruTorrent).

First we use this command in SSH to move us to the correct location of your default rutorrent installation:

~~~
cd ~/www/$(whoami).$(hostname -f)/public_html/rutorrent/plugins/
~~~

Then we will need to modify and use this command, where `someplugin` is the name of the plug-in you require.

~~~
svn checkout https://github.com/Novik/ruTorrent/trunk/plugins/someplugin
~~~

So if you want to install the `unpack` plug-in we would use this command:

~~~
svn checkout https://github.com/Novik/ruTorrent/trunk/plugins/unpack
~~~

If you had already loaded rutorrent in your browser you will need to refresh the page to see the changes.



