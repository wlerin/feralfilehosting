
Common links and common phrases
---

[putty 0.63 installer](http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.63-installer.exe)

[putty 0.63 zip](http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip)

Optionally, you can edit it over FTP, please read and understand this FAQ first - [Text editing - Over FTP or SFTP](https://www.feralhosting.com/faq/view?question=219)

In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH guide basics - PuTTy](https://www.feralhosting.com/faq/view?question=12) or [SSH guide basics - OS X](https://www.feralhosting.com/faq/view?question=217)

 [SSH guide basics - PuTTy](https://www.feralhosting.com/faq/view?question=12) or [SSH guide basics - OS X](https://www.feralhosting.com/faq/view?question=217)

How to [SSH](https://www.feralhosting.com/faq/view?question=12) into your slot.

[SSH](https://www.feralhosting.com/faq/view?question=12)

[text editor](https://www.feralhosting.com/faq/view?question=219)

You can do this from the `Install Software` link in your [Account Manager](https://www.feralhosting.com/manager/)

`Install Software` link in your [Account Manager](https://www.feralhosting.com/manager/)

[Slot Detail](https://www.feralhosting.com/manager/) page for the relevant slot

[Account Manager](https://www.feralhosting.com/manager/)

[open a ticket](https://www.feralhosting.com/manager/tickets/new)

[IRC](https://www.feralhosting.com/chat)

You will need to have MySQL already installed. You can do this from the `Install Software` link in your [Account Manager](https://www.feralhosting.com/manager/)

[Installing Proftpd for extra FTP/SFTP/FTPS accounts](https://www.feralhosting.com/faq/view?question=193)

Where `username` is your Feral username and `server` is the name of the server that is hosting rutorrent.

Where `username` is your Feral username and `server` is the name of the Feral server your slot is hosted on:

Now we enter the SSH command to connect to the slot, where `username` is your Feral username and `server` is the name of the server you wish to SSH into:

**Important note:** Folder names with spaces will require that your wrap them in quotes, for example `"folder name"`.

~~~
peterpan@aphrodite.feralhosting.com
~~~

~~~
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_mysql.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/mysql_socket.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/rutorrent.slotdetails.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/deluge.slotdetails.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/transmission.slotdetails.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_software_page.png)
![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/install_software_link.png)
~~~

Then press and hold `CTRL` and then press `c` to quit.

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

where `username` if your Feral username and `server` if the name of the server that the relevant slot is hosted on.

Common Commands
---

Use this command to create the `~/bin` directory and reload your shell for this change to take effect.

~~~
mkdir -p ~/bin && bash
~~~

Add `PATHS` to the `~/.bashrc`#

Python `~/.local/bin`:

~~~
[ ! "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~
