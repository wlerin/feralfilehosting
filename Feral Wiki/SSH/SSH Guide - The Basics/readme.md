
Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

Kitty SSH Client
---

[Kitty SSH client](http://www.9bis.net/kitty/?page=Download)

[Main Kitty Download Page](http://www.fosshub.com/KiTTY.html)

> **Important note:** You can rename `kitty.exe` to `putty.exe` and use it wherever an application has putty integration. For example, Bitkinex and WinSCP.

Basic Connection
---

We need to force the `UTF-8` language option to avoid some visual issues when connecting. If you are having Unicode character issues it is because you forgot to set this here before connecting.

**1:** Navigate to the `Window` panel.

**2:** Select the `Translation` panel.

**3:** Select `UTF-8` in the drop down menu.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/1.png)

> **Important note:** This optional but recommended step will save your Feral username and SSH password for the session to connect without requiring you to enter this information.

**1:** Navigate to the `Connection` panel.

**2:** Select the `Data` panel.

**3:** Enter your Feral username in the `Auto-login username` field.

**4:** Enter your Feral FTP / SFTP / SSH Access password found in the slots details pages for the relevant slot into the `Auto-login password` field.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/2.png)

**1:** Navigate to the `Session` panel if not already there.

**2:** Enter the hostname of the Feral server that hosts your slot.

**3:** The SSH port is always `22`.

**4:** Make sure the `SSH` radio option is selected (it should be selected by default).

**5:** Give this session a name for when we save so you can identify and load it after.

**6:** Save this session with all the information you have provided and settings you have configured.

> **Important note:** Make sure you have saved your session once you have provided all the core details.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/3.png)

Once you have saved your  new session then you would normally follow this process when opening KiTTY to work with saved sessions:

**1:** Navigate to the `Session` panel if not already there (this panel is the default when opening KiTTY)

**2:** Select the session you want to load

**3:** Click on `Load` to load this session and all configurations associated with it.

**4:** Click `Open` to start the connection.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/4.png)

> **Important note:** Check you are connecting to the right host before accepting. If you connecting to the correct host and are asked to save the server's host Key say `yes` and check and box that says to remember/always do this.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/5.png)

> **Important note:** Don't forget to save this session after making any new changes.

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

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/3.png)

Now we enter the SSH command to connect to the slot, where `username` is your Feral username and `server` is the name of the server you wish to SSH into:

~~~
ssh username@server.feralhosting.com
~~~

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/4.png)

If this is the first time connecting to this host you will see something like this.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/5.png)

Type `yes` to save the host's key.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/6.png)

Now enter your Feral SSH/SFTP password at the prompt found on your slot details page for the relevant slot:

**Do not type it in** — copy it (be careful not too introduce extra white spaces) paste it by pressing: 

**command-v** or a **middle-click on a 3-button mouse** to paste it in.

**There will be no visual response when you paste in your password** — this is a security measure so that your password cannot be stolen by someone looking over your shoulder. Simply paste it and press **enter** to send the password to the server.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/7.png)

At this point you should be logged into your Feral server and ready to execute commands in shell.

After you have saved the host key and use the command shown in this FAQ it will look like this when connecting.

![](https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Guide%20-%20The%20Basics/OS%20X/8.png)

You have now successfully connected to your slot via SSH using terminal on OS X.



