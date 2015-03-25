
Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

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

> **Important note:** Check you are connecting to the right host before accepting. If you connecting to the correct host and are asked to save the HOSTs Key say `yes` and check and box that says to remember/always do this.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/5.png)

> **Important note:** Don't forget to save this session after making any new changes.

Part 2: Using a  putty format ppk keyfile.
---

This guide assumes you have created a private key according to this **Guide :** [Setting up Public Key Authentication for Password-less Login](https://www.feralhosting.com/faq/view?question=13)

**1:** Navigate to the `Session` panel if not already there (this panel is the default when opening KiTTY)
**2:** Select the session you want to load
**3:** Click on `Load` to load this session and all configurations associated with it.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/6.png)

**1:** Navigate to the `Connection` panel.
**2:** Navigate down to the `SSH Panel.
**3:** Select the `Auth` panel.
**4:** Click on `Browse` to look for and load a `ppk` format keyfile.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/7.png)

Once loaded into kitty the path to the keyfile will be shown.

**1:** Once loaded into kitty the path to the keyfile will be shown in the field.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/8.png)

> **Important note:** Don't forget to save this session after making any new changes.

**1:** Navigate back to the `Session` panel.
**2:** Select the session you want to save and merge the new configuration settings with.
**3:** Click on `Save` to have these new settings saved to the selected session.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/9.png)

Part 3: Creating an SSH Tunnel to use as a local SOCKS proxy.
---

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
**3:** Select and enter a port between the range of `10001` to `49999`
**4:** Click `Add` to add this SSH tunnel.
**5:** Once added you will see the tunnel listed in the `Forwarded ports` window.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/12.png)

> **Important note:** Don't forget to save this session after making any new changes.

**1:** Navigate back to the `Session` panel.
**2:** Select the session you want to save and merge the new configuration settings with.
**3:** Click on `Save` to have these new settings saved to the selected session.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/Kitty%20-%20SSH%20-%20Private%20Keys%20-%20SSH%20tunnels/13.png)



