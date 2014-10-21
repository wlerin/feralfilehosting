
What is an SSH Tunnel?
---

Unlike using OpenVPN that encrypts **all** network traffic at the driver level for that device, creating SSH tunnels enables you to route your for traffic/applications selectively, providing they have a proxy option.

For example: You could open a tunnel only for browsing or another just for an application, letting the rest of your traffic go through your ISP directly, unencrypted. This can prevent a lot of problems for casual usage, like using an imap application such as Thunderbird or using personal websites like Paypal where a VPN might trigger a security alert regarding your location.

You can create and have open as many tunnels as you need per device which is more suited to on demand usage, while offering pretty much the same level of privacy as OpenVPN.

### Using MyEnTunnel

MyEnTunnel is a tiny, portable piece of software that will allow you to easily set up a secure, encrypted SSH tunnel to your Feral box and use it as a local SOCKS5 proxy.

It's easier to set up and configure than the [PuTTY method](https://www.feralhosting.com/faq/view?question=37). Another advantage of this set-up is that MyEnTunnel runs quietly in your system tray not clattering your desktop as PuTTY would. MyEnTunnel will also re-establish the tunnel automatically if connection to the server was dropped.

**Step 1 Downloads:**

All downloads are from this site, go here if you want the installer.

[http://nemesis2.qx.net/pages/MyEnTunnel](http://nemesis2.qx.net/pages/MyEnTunnel)

**Important note:** MyEnTunnel Version `3.6.1` use plink `0.63`

A direct link to the installer [3.6.1 installer Unicode x86 and x64](https://github.com/feralhosting/feralfilehosting/raw/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/myentunnel_setup-3.6.1.exe)

Custom downloads:

What are these? The installer contains both the x86 and x64 Unicode installers and will automatically detect and install the correct version for you. You can install it anywhere and use the files portably. This had been done for you and you have the extracted and portable files ready to use.

[MyEnTunnel x86 3.6.1 Unicode](https://github.com/feralhosting/feralfilehosting/raw/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/MyEnTunnelx86.zip)

[MyEnTunnel x64 3.6.1 Unicode](https://github.com/feralhosting/feralfilehosting/raw/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/MyEnTunnelx64.zip)

Older version:

 [MyEnTunnel 3.5.2 and plink 0.62](https://github.com/feralhosting/feralfilehosting/raw/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/myentunnel-unicode.3.5.2.plink.0.62.zip) This is a prezipped version that includes plink `0.62` for convenience.

**Important note:** Myentunnel `3.5.2` only works with plink.exe `0.62` and not `0.63`. Use version `3.6.1` for plink `0.63`

**Step 2 Optional:**

Make a copy of your existing [private key](https://www.feralhosting.com/faq/view?question=13), rename it to `keyfile.ppk`, **You must put this `.ppk` file in the same directory where your MyEnTunnel.exe was extracted to**

Make sure your private key works before your proceed to the next step.

**Important note:** If your keyfile requires a passphrase use [PAGEANT](https://www.feralhosting.com/faq/view?question=241) to load the key into memory. This file comes as part of the PuTTy bundle or as a stand alone exe. MyEnTunnel does not support passing keyfile passphrases to the server. PAGEANT MUST BE USED or you will need to use a keyfile with no passphrase.

If you installed putty using the putty installer then you can either double click on a keyfile to load it or find PAGEANT, located here `Program files (x86)/PuTTy/`, for creating a custom short cut as shown in the PAGEANT guide.

**Step 3**

Launch `myentunnel.exe`, go to the `Settings` tab and fill out the fields according to the screen shot below:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/1.png)

Substitute `server` with your the name of the Feral server, and `username` with your actual Feral username. You can find this information on the [Slot Details](https://www.feralhosting.com/manager/) page of your Account Manager.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/2.png)

**If you using a private key file use these steps instead:**

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/3.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/4.png)

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20tunnels%20-%20MyEnTunnel/5.png)

**Step 4**

Press `connect`.

If your private key is function able and you filled out the connection details correctly, MyEnTunnel should establish a tunnel to your Feral box and listen for connections the local port you selected.

**Basic usage of tunnels in applications**

See this FAQ for more info.

[SSH Tunnels - How to use them with your applications](https://www.feralhosting.com/faq/view?question=242)



