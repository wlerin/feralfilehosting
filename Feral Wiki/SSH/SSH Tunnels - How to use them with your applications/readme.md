
### Using SSH Tunnels with your applications:

Once you have created and opened your tunnels in your SSH client you need to configure you applications to use them. This guide cannot possibly cover each and every program. Also your program needs to support proxying in some way. This will usually be in the settings or preferences somewhere under the title of `Proxy`  / `Network Settings` / `Connection Settings`. Possibly as a subcategory of a section in the settings or options.

With most programs you can either proxy directly using built in settings or with add-ons or plugins of some type like foxyproxy in Firefox and ProxyOmega in Chrome. We will look at the most common options that will be an applicable template to most other scenarios.

### FireFox's Connection settings

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/settings.png)

### Filezilla proxy settings

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/filezilla.png)

### Firefox

[Firefox Foxy Proxy](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/)

This is the best method for firefox. A very customizable proxy addon. 

**1:** Make sure the Proxies tab is selected.

**2:** Click on the Add New Proxy button.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/foxyproxy1.png)

**1:** Make sure the Proxy Details tab is selected.

**2:** Select `Manual Proxy Configuration`

**3:**  Enter `127.0.0.1` as the Host or IP address.

**4:** Select the port you configured when creating the SSH tunnel.

**5:** Select the `SOCKS v5` option

**6:** Click OK or optionally configure some settings in the other tabs described below.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/foxyproxy2.png)

**1:** Select the `URLS patterns` tab.

**2:** Check the box to not use this proxy on local connections.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/foxyproxy3.png)

**1:** Select the `General` tab.

**2:** Give your proxy a name.

**3:** Optional: You can change the colour of the proxy profile here.

**4:** Optional: Configure browser cache settings in relation to the proxy.

**5:** Optional: Configure browser cookie settings in relation to the proxy.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/foxyproxy4.png)

### Chrome

[Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif)

Chrome does not give the user any useful built in network/proxy options. The plugin below is the best choice to do this (it is a good plugin)

Once you have installed the plugins, click on it's icon and click on `Options` and create a new profile.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/proxyomega1.png)

Now give create a new profile and select the  Proxy profile.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/proxyomega2.png)

After you have saved, you can click on the icon to select from any configured proxies.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/proxyomega3.png)

Now:

**1:** Select `SOCKS5`

**2:** Enter `127.0.0.1`

**3:** Select a port between the range of `10001` to `32001`

**4:** Apply the changes

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/proxyomega4.png)

Once saved, you can select the icon again to see and select your new proxy connections.

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SSH/SSH%20Tunnels%20-%20How%20to%20use%20them%20with%20your%20applications/proxyomega5.png)


