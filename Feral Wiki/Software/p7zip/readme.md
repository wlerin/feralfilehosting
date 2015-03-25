
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

You can ask for this to be installed on your slot by opening a ticket.

Download and unpack pz7ip
---

Download the binaries and extract them using these commands:

~~~
wget -qO ~/p7zip.tar.bz2 http://sourceforge.net/projects/p7zip/files/p7zip/9.38.1/p7zip_9.38.1_src_all.tar.bz2
tar xf ~/p7zip.tar.bz2 && cd ~/p7zip_9.38.1
make && make install DEST_HOME=$HOME
cd && rm -f ~/p7zip.tar.bz2
~~~

Using p7zip
---

Now you can use the binary by using this command:

~~~
~/bin/7za
~~~

For example how to extract an iso:

~~~
~/bin/7za x ~/Your.iso -oWhere/You/Want/It/Extracted/To
~~~

`-o` cannot use `~` in the path or have a space after it. It must be relative from you are in the shell.



