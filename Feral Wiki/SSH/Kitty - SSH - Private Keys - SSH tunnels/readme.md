
Kitty SSH Client
---

[Kitty SSH client](http://www.9bis.net/kitty/?page=Download)

[Main Kitty Download Page](http://www.fosshub.com/KiTTY.html)

> **Important note:** You can rename `kitty.exe` to `putty.exe` and use it wherever an application has putty integration. For example, Bitkinex and WinSCP.

Information
---

Completing the whole guide is not Required. To use Kitty to connect to your slot you only need to complete the steps in Part 1 of this FAQ. This will use Kitty to connect in the traditional way you would when using putty.

Part 1: Basic Connection
---

We need to force the `UTF-8` language option to avoid some visual issues when connecting. If you are having Unicode character issues it is because you forgot to set this here before connecting.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/1.png)

> **Important note:** This optional step will save your Feral username and SSH password for the session to connect without requiring you to enter this information.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/2.png)

Save your session once you have provided all the core details.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/3.png)

> **Important note:** If you are asked to save the HOSTs Key say `yes` and check and box that says to remember/always do this.

Part 2: Using a  putty format ppk keyfile.
---

This guide assumes you have created a private key according to this **Guide :** [Setting up Public Key Authentication for Password-less Login](https://www.feralhosting.com/faq/view?question=13)

Navigate to the `Connection` > `SSH` > `Auth` panel and then click browse to find and load a ppk keyfile.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/4.png)

Once loaded into kitty the path to the keyfile will be shown.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/5.png)

> **Important note:** Don't forget to save this session after making any new changes.

Part 3: Creating an SSH Tunnel to use as a local SOCKS proxy.
---

Navigate to the `Connection` > `SSH` > `Tunnels` panel. This is what you will see:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/6.png)

**1:** Select the `Auto` radio (this should already be selected by default)
**2:** Select the `Dynamic` radio
**3:** Select and enter a port between the range of `10001` to `49999`
**4:** Click `Add` to add this SSH tunnel.
**5:** Once added you will see the tunnel listed in the `Forwarded ports` window.

You can add and create more than one tunnel per session if needed.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/7.png)

> **Important note:** Don't forget to save this session after making any new changes.



