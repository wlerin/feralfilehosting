
Information:
---

Unlike using OpenVPN that encrypts *all* network traffic at the driver level for that device, creating SSH tunnels enables you to route your for traffic/applications selectively. 

For example: You could open a tunnel only for browsing or an application, letting the rest of your traffic go through your ISP directly, unencrypted. This can prevent a lot of problems for casual usage, such as using an imap application such as Thunderbird or using Personal websites like Paypal.

You can create and have open as many tunnels as you need per device which is more suited to on demand usage, while offering pretty much the same level of privacy as OpenVPN.

> **Important note:** You do not need OpenVPN installed for creating ans using an SSH tunnel with your Feral slot. You can also create multiple SSH tunnels on different ports.

You can also follow our tutorial on [Setting up Public Key Authentication on Windows](https://www.feralhosting.com/faq/view?question=13). This way you will not have to type in your password each time you initiate a session (unless a keyfile passphrase is used).

> **Important note:** KiTTY cannot save pass phrases for protected keyfiles (you must use [PAGEANT](https://www.feralhosting.com/faq/view?question=241) for this). For saving your pass phrases for a session use [XShell](https://www.feralhosting.com/faq/view?question=238)

Creating an SSH Tunnel to use as a local SOCKS proxy with KiTTY.
---

[SSH Guide - The Basics](https://www.feralhosting.com/faq/view?question=12) is a prerequisite of this guide. Please follow the steps there to SSH before using these next steps.

> **Important note:** You can add and create more than one tunnel per session if needed.

**1:** Navigate to the `Session` panel if not already there (this panel is the default when opening KiTTY)
**2:** Select the session you want to load
**3:** Click on `Load` to load this session and all configurations associated with it.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/10.png)

**1:** Navigate to the `Connection` panel.
**2:** Navigate down to the `SSH Panel.
**3:** Select the `Tunnels` panel.
**4:** Configure the new dynamic forwarded port that will act as a local SOCKS proxy (see next image for details)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/11.png)

**1:** Select the `Auto` radio (this should already be selected by default)
**2:** Select the `Dynamic` radio
**3:** Select and enter a port between the range of `10001` to `32001`
**4:** Click `Add` to add this SSH tunnel.
**5:** Once added you will see the tunnel listed in the `Forwarded ports` window.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/12.png)

> **Important note:** Don't forget to save this session after making any new changes.

**1:** Navigate back to the `Session` panel.
**2:** Select the session you want to save and merge the new configuration settings with.
**3:** Click on `Save` to have these new settings saved to the selected session.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/13.png)

OS X Built-in SSH Client using private/public key pair
---

SSH is the built-in OS X SSH client and is very powerful and simple to use if you follow the instructions in this guide.

Connecting Via SSH using the default password and using private key files.
---

**1:** In terminal on mac run

~~~
ssh-keygen -t rsa
~~~

Press enter for the default file save location

Press enter when prompted for passphrase (no passphrase simplifies the process)
   
**2:** Then run:

~~~
cat ~/.ssh/id_rsa.pub | pbcopy
~~~

to copy the key to your clipboard so we can save it to our slot.

**3:** Then run this command (don't copy it or you will lose the key info in the clipboard:

> **Important note:**  This is NOT a number 1. It is a non-capitalised letter `L`

~~~
ssh -l username server.feralhosting.com
~~~

Replace `username` and  `server` with your own details provided to by Feral. Use the SSH password from your feral Manager Slot details page for the relevant slot.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

**4:** Once logged into your feral slot via SSH run:

~~~
nano ~/.ssh/authorized_keys
~~~

**5:** Paste your clipboard contents into the file, ensuring that the contents are all on one line (remove line breaks)
**6:** Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.
**7:** Type `exit` to leave SSH session on feral slot

Creating SSH tunnels:
---

**1:** In terminal, type 

~~~
ssh -D 12345 -l username server.feralhosting.com
~~~

Replace `username` and `server` with your own details.

**Important note:** You must change `12345` to another port number if you wish. Use a port between the range of `10001` to `32001`.

**2:** You have now created an Socks proxy on port your selected port. See instructions later in this article for instructions on how to use this proxy.

Creating SSH tunnels in background
---

You can semi-automate the above process by creating an alias for the tunnel command and setting it up to run in a screen session in the background

**1:** in terminal type 

~~~
nano ~/.bash_rc
~~~

**2:** In the resulting  editor window type 

~~~
alias feraltun="screen ssh -D 12345 -l username server.feralhosting.com"
~~~

Replace `username` and `server` with your own details.

**Important note:** You must change `12345` to another port number if you wish. Use a port between the range of `10001` to `32001`.

**3:** Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

**To use your new alias:**

**1:** Start a new terminal session (type exit to leave the old one if still open)

**2:** Type:

~~~
feraltun
~~~

Your SSH tunnel is now active.

**3:** Then press and hold `CTRL` and `a` then press `d` to detach from the screen. This leaves it running in the background.

**4:** You can now close terminal and use your tunnel

> **Important note:**  If you have any questions about this procedure for OS X or suggestions on improving the instructions, please contact liriel in IRC.

Basic usage of tunnels in applications
---

See this FAQ for more info.

[SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242)



