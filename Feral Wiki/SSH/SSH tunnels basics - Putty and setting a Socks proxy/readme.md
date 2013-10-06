
Unlike using OpenVPN that encrypts `all` network traffic at the driver level for that device, creating SSH tunnels enables you to route your for traffic/applications selectively. 

For example: You could open a tunnel only for browsing or an application, letting the rest of your traffic go through your ISP directly, unencrypted. This can prevent a lot of problems for casual usage, such as using an imap application such as Thunderbird or using Personal websites like Paypal.

You can create and have open as many tunnels as you need per device which is more suited to on demand usage, while offering pretty much the same level of privacy as OpenVPN.

**You do not need OpenVPN installed for running an SSH tunnel to your Feral server.**

This FAQ when applied to and used with [Portable Firefox](http://portableapps.com/apps/internet/firefox_portable) along with [Portable PuTTY](http://portableapps.com/apps/internet/putty_portable) on your USB thumb drive, will give you a portable navigation suite for using just about anywhere, including the corporate network in your office.

NOTE: Putty cannot save passwords for sessions, so to get around this:

You can use KiTTy instead of PuTTy since KiTTy can save passwords for sessions.

For saving your passwords for a session using KiTTy please see the KiTTy - ktssh section of this 
more comprehensive guide - [SSH Guide Super](https://www.feralhosting.com/faq/view?question=165)

KiTTy is an upgraded version of PuTTy. It can also be used as a direct replacement for the putty.exe by simply
renaming kitty.exe to putty.exe

You can also follow our tutorial on [Setting up Public Key Authentication on Windows](https://www.feralhosting.com/faq/view?question=13). 
This way you will not have to type in your password each time you initiate a session (unless a keyfile passphrase is used).
**Configuring PuTTY**

[SSH Guide Basic - How to SSH Into Your Feral Slot](https://www.feralhosting.com/faq/view?question=12) is a prerequisite of this guide. Please follow the steps there to SSH before using these next steps.

When you start PuTTY you should see a window that looks like this:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20PuTTy/1.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20PuTTy/2.png)

In the navigation tree on the left select the `Tunnels` item. If this item isn't already visible, you can find it by clicking the `Connection` node in the tree, then `SSH`, and then `Tunnels`:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20PuTTy/3.png)

Under the section labeled `Add a new forwarded port` type in a port like 55000 for the source port. Leave the Destination field blank, then select the `Dynamic` and `Auto` radio buttons. Then click the `Add` button, and you should see the text `D55000` show up in the textarea just above the `Add a new forwarded port`.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20PuTTy/4.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20basics%20-%20PuTTy/5.png)

In the PuTTY navigation tree on the left click on the `Session` node (at the top of the tree), then select `Your Currently loaded Sessin` (or any other session name you configured previously) and click the `Save` button on the right side of the screen to save this configuration.

**Please note that you have to keep your PuTTY session open for the SSH tunnel to remain functional.**

**Basic usage of tunnels in applications**

See this FAQ for more info.

[SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242)

