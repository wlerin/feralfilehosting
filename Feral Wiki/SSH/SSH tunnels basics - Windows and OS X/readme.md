
Unlike using OpenVPN that encrypts **all** network traffic at the driver level for that device, creating SSH tunnels enables you to route your for traffic/applications selectively. 

For example: You could open a tunnel only for browsing or an application, letting the rest of your traffic go through your ISP directly, unencrypted. This can prevent a lot of problems for casual usage, such as using an imap application such as Thunderbird or using Personal websites like Paypal.

You can create and have open as many tunnels as you need per device which is more suited to on demand usage, while offering pretty much the same level of privacy as OpenVPN.

**You do not need OpenVPN installed for running an SSH tunnel to your Feral server.**

This FAQ when applied to and used with [Portable Firefox](http://portableapps.com/apps/internet/firefox_portable) along with [Portable PuTTY](http://portableapps.com/apps/internet/putty_portable) on your USB thumb drive, will give you a portable navigation suite for using just about anywhere, including the corporate network in your office.

**Important note:** Putty cannot save passwords for sessions, so to get around this. For saving your passwords for a session use KiTTy or Xshell:

[XShell - SSH - SSH tunnels - Private Keys](https://www.feralhosting.com/faq/view?question=238)

[Kitty - SSH - Private Keys - SSH tunnels](https://www.feralhosting.com/faq/view?question=240)

You can also follow our tutorial on [Setting up Public Key Authentication on Windows](https://www.feralhosting.com/faq/view?question=13). 
This way you will not have to type in your password each time you initiate a session (unless a keyfile passphrase is used).
**Configuring PuTTY**

[SSH guide basics - PuTTy](https://www.feralhosting.com/faq/view?question=12) is a prerequisite of this guide. Please follow the steps there to SSH before using these next steps.

When you start PuTTY you should see a window that looks like this:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20Putty%20and%20setting%20a%20Socks%20proxy/1.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20Putty%20and%20setting%20a%20Socks%20proxy/2.png)

In the navigation tree on the left select the `Tunnels` item. If this item isn't already visible, you can find it by clicking the `Connection` node in the tree, then `SSH`, and then `Tunnels`:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20Putty%20and%20setting%20a%20Socks%20proxy/3.png)

Under the section labeled `Add a new forwarded port` type in a port like 55000 for the source port. Use a port within the range `6000` - `55000`. Leave the Destination field blank, then select the `Dynamic` and `Auto` radio buttons. Then click the `Add` button, and you should see the text `D55000` show up in the textarea just above the `Add a new forwarded port`.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20Putty%20and%20setting%20a%20Socks%20proxy/4.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20Putty%20and%20setting%20a%20Socks%20proxy/5.png)

In the PuTTY navigation tree on the left click on the `Session` node (at the top of the tree), then select `Your Currently loaded Session` (or any other session name you configured previously) and click the `Save` button on the right side of the screen to save this configuration.

**Please note that you have to keep your PuTTY session open for the SSH tunnel to remain functional.**

**Basic usage of tunnels in applications**

See this FAQ for more info.

[SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242)

OS X Built-in SSH Client using private/public key pair
---

SSH is the built-in OS X SSH client and is very powerful and simple to use if you follow the instructions in this guide.

**Connecting Via SSH using the default password and using private key files.**

**1:** In terminal on mac run

~~~
ssh-keygen -t rsa
~~~

- enter for default file save location
- enter when prompted for passphrase (no passphrase)
   
**2:** Then run:

~~~
cat ~/.ssh/id_rsa.pub | pbcopy
~~~

to copy the key to your clipboard

**3:** Then run:

**Important note:** This is NOT a number 1. It is a non-capitalised letter `L`

~~~
ssh -l username server.feralhosting.com
~~~

For example:

~~~
ssh -l peterpan aphrodite.feralhosting.com
~~~

Replace `username` and  `server` with your own details provided to by Feral. Use the SSH password from your feral Manager Slot details page for the relevant slot.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

**4:** Once logged into your feral slot via ssh run:

~~~
nano ~/.ssh/authorized_keys
~~~

**5:** Paste your clipboard contents into the file, ensuring that the contents are all on one line (remove line breaks)
**6:** Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.
**7:** Type `exit` to leave ssh session on feral slot

Creating SSH tunnels:
---

**1:** In terminal, type 

~~~
ssh -D 45555 -l username server.feralhosting.com
~~~

- replace `username` and `server` with your own details.
- you can change `45555` to another port number if you wish. Use a port between the range of `6000` to `50000`.

**2:** You have now created an Socks proxy on port 55555. See instructions later in this article for instructions on how to use this proxy.

Creating SSH tunnels in background
---

You can semi-automate the above process by creating an alias for the tunnel command and setting it up to run in a screen session in the background

**1:** in terminal type 

~~~
nano ~/.bash_profile
~~~

**2:** In the resulting  editor window type 

~~~
alias feraltun="screen ssh -D 55555 -l username server.feralhosting.com"
~~~

- replace `username` and `server` with your own details.
- you can change `45555` to another port number if you wish. Use a port between the range of `6000` to `50000`.

**3:** Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

**To use your new alias:**

**1:** Start a new terminal session (type exit to leave the old one if still open)

**2:** Type:

~~~
feraltun
~~~
 
- your SSH tunnel is now active

**3:** Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

**4:** You can now close terminal and use your tunnel

**Important note:** If you have any questions about this procedure for OS X or suggestions on improving the instructions, please contact liriel in IRC.





