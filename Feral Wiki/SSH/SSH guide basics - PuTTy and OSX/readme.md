
### puTTY - Connecting with SSH on Windows:

**Option 1:** Get PuTTy installer; Download PuTTY Installer from [here](http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.64-installer.exe)

**Option 2:** Get PuTTy zip (portable); Download PuTTY Zip from [Get PuTTy zip (portable)](http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip)

**Option 3:** Get Portable PuTTY; Compiled by PortableApps.com and is available [here](http://portableapps.com/apps/internet/putty_portable).

### Step 1: 

**Option 1 continued:** Install PuTTY. Most programs that rely on PuTTy use the default installation location such as WinSCP

**Option 2 continued:** Extract the putty.zip and navigate to inside the extracted zip folder. This just means that certain apps that might have a dependency or relationship with putty will need to be told where the putty files are located

**Option 3 continued:** Install the PortableApps version and locate the shortcut in the PortableApps menu.

### Step 2 Run PuTTY - Whichever version you have chosen

Find and use the login information provided to you in the Slot Detail page for the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot%20detail.png)

### Step 3 Enter your server information:

Type or copy & paste the hostname of your server, for example: `aphrodite.feralhosting.com`

Leave the port on default 22, optionally type in a name for the session if you want to save it for later use (recommended!), then click `Open`. This will connect you to the host.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty1.png)

**Optional Step 3.2:** To have PuTTy automatically pass your username then enter it as shown in the image

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty2.png)

**Optional Step 3.3: Private Keyfile usage**

If you have a `.ppk` keyfile you would like to use instead of the default password or you have followed this guide for [Setting up Public Key Authentication for Password-less Login](https://www.feralhosting.com/faq/view?question=13) you can load it here like this.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty3.png)

**Step 3.4: Saving your Sessions expanded**

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty3.5.png)

**Step 4:** If your connection is successful, you will see a login prompt such as "login as: " on the screen. Type in your Feral username and press 'enter' to confirm.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty4.png)

You will see something similar to this as you proceed to after you username has been passed to the server:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty5.png)

Copy your shell access password from the Software Status page and paste it by right-clicking in the Putty window after you have highlighted it, or pressing and holding **SHIFT** then pressing **INS**. 

A single right click in the mouse is **PASTE** in putty
Highlighting text is **COPY**

Your password will not be displayed when you do this, so do not right click more than once before confirming. Press enter to confirm, and you should be logged into the shell.

**Important Note:** If you are having problems copying and pasting your password, try copying and pasting the password in a simple text editor such as Notepad, to see if you have copied any unwanted whitespaces at the start or end of the password. Once you are sure you are only copying the correct password then try again.

You will see something like this upon successfully connecting:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/puTTY/putty6.png)

(You will be disconnected by the server after an incorrect password, or if 30 seconds passes.)

You can now execute commands in the shell - what and how is beyond the scope of this tutorial.

To exit the session, type in exit or press and hold `ctrl` then press `d`, and Putty will disconnect and close the window.

The shell is a very powerful tool that in the right hands can be more useful than any GUI.

For information on how to use Public Key Authentication in Putty, please see [this FAQ](https://www.feralhosting.com/faq/view?question=13). It allows you to log in without having to type in your password every time.

OS X - Connecting with Terminal
---

Mac OS X comes with its own implementation of OpenSSH, so you don't need to install any third-party software to take advantage of the extra security SSH offers — just open a terminal window and jump in.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/macterminal1.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/macterminal2.png)

If you haven't already created a dock icon for "Terminal" then  go to the Applications folder, then Utilities from within that. Terminal is in the Utilities folder. Just drag it on to the Dock, and it'll make a permanent Dock icon.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/terminalicon.png)

OS X Built-in SSH Client
---

When you open the terminal you will see something like this:

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/3.png)

Now we enter the SSH command to connect to the slot, where `username` is your Feral username and `server` is the name of the server you wish to SSH into:

~~~
ssh username@server.feralhosting.com
~~~

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/4.png)

If this is the first time connecting to this host you will see something like this.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/5.png)

Type `yes` to save the host's key.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/6.png)

Now enter your Feral SSH/SFTP password at the prompt found on your slot details page for the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

**Do not type it in** — copy it (be careful not too introduce extra white spaces) paste it by pressing: 

**command-v** or a **middle-click on a 3-button mouse** to paste it in.

**There will be no visual response when you paste in your password** — this is a security measure so that your password cannot be stolen by someone looking over your shoulder. Simply paste it and press **enter** to send the password to the server.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/7.png)

At this point you should be logged into your Feral server and ready to execute commands in shell.

After you have saved the host key and use the command shown in this FAQ it will look like this when connecting.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20guide%20basics%20-%20PuTTy%20and%20OSX/OS%20X/8.png)

You have now successfully connected to your slot via SSH using terminal on OS X.



