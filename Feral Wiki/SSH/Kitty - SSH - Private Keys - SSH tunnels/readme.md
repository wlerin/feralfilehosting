
Kitty SSH Client
---

[Kitty SSH client](http://www.9bis.net/kitty/?page=Download)

[Main Kitty Download Page](http://www.fosshub.com/KiTTY.html)

If you are asked to save the HOSTs Key say yes and check and box that says to remember/always do this.

This guide assumes you have created a private key according to this **Guide :** [Setting up Public Key Authentication for Password-less Login](https://www.feralhosting.com/faq/view?question=13)

> **Important note:** You can rename `kitty.exe` to `putty.exe` and use it wherever an application has putty integration. For example, Bitkinex and WinSCP.

Information
---

Completing the whole guide is not Required. To use Kitty to connect to your slot you only need to complete the steps in Part 1 of this FAQ to use Kitty in the traditional way you would use putty.

Part 1: Basic Connection
---

We need to force the `UTF-8` language option to avoid some visual issues when connecting. If you are having Unicode character issues it is because you forgot to set this here.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/1.png)

> **Important note:** This optional step will save your Feral username and SSH password for the session to connect without requiring you to enter this information.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/2.png)

Save your session once you have provided all the core details.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/3.png)

Part 2: Using a  putty format ppk keyfile.
---

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/4.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/5.png)

Part 3: Creating an SSH Tunnel to use as a local SOCKS proxy.
---

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/6.png)

**Don't forget to SAVE your session under the original Session page in the first image.**



