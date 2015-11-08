
Squid Proxy - Anonymous Forward Proxy Set-up
---

Use this article to download and configure Squid as an anonymous web proxy with `basic_digest` authentication.

**1:**  Create an Auth file that we will use to authenticate the proxy users.

**Important note:** Using the `-c` flag will overwrite any existing files with the same name in the specified location. To update use the second command without the `-c` flag.

You can change the `MyRealm` and `username` arguments to meet your needs:

~~~
htdigest -c ~/.squidauth MyRealm username
~~~

If the file does exists then use this command instead to update or add users:

~~~
htdigest ~/.squidauth MyRealm username
~~~

So for example:

~~~
htdigest -c ~/.squidauth NoOrcs bilbobaggins
~~~

**2:** Install and compile Squid.

~~~
wget -qO ~/squid.tar.gz http://www.squid-cache.org/Versions/v4/squid-4.0.1.tar.gz
tar xf ~/squid.tar.gz && cd squid-*
./configure --prefix=$HOME
make && make install && cd && rm -rf squid{-*,.tar.gz}
~~~

**3:** Get the preconfigured conf file that we will have to modify a little.

~~~
wget -qO ~/etc/squid.conf http://git.io/yavZuw
~~~

**Recommended:** Make some required changes to the conf file with these commands.

~~~
sed -i "s|/media/DiskID/username|$HOME|g" ~/etc/squid.conf
sed -i "s|http_port 3128|http_port $(shuf -i 10001-32001 -n 1)|g" ~/etc/squid.conf
~~~

**4:** Personalise the conf

Run this command in SSH:

~~~
nano ~/etc/squid.conf
~~~

Modify this section only:

**1:** line `61` - Change `MyRealm` to the what was set with the `htdigest` command in Step 1.
**2:** lines `66` and `67` need `username` to be changed to match the user you created in Step 1 in the `~/.squidauth` file.
**3:** Full paths should already match your slots if you ran the `sed` command. Otherwise edit them to match your slots full path.
**4:** The port should have been randomised for you  if you ran the `sed` commands so just take not of it. Otherwise change the port to something between `10001` and `32001`

**Important note:**  The helpers required for authentication are located in `~/libexec`. For example `basic_ncsa_auth`

~~~
# And finally deny all other access to this proxy
# Basic Auth Start
# auth_param basic program /media/DiskID/username/libexec/basic_ncsa_auth /media/DiskID/username/.squidbasic
# Basic Auth End
# Digest Auth Start
auth_param digest program /media/DiskID/username/libexec/digest_file_auth -c /media/DiskID/username/.squidauth
auth_param digest children 10
auth_param digest realm MyRealm
# Digest Auth End
acl username proxy_auth REQUIRED
http_access allow username
http_access deny all

# Squid normally listens to port 3128
http_port 3128

# Uncomment and adjust the following to add a disk cache directory.
#cache_dir ufs /media/DiskID/username/var/cache/squid 100 16 256

# Leave coredumps in the first cache dir
coredump_dir /media/DiskID/username/var/cache/squid
~~~

Then press and hold `CTRL` and then press `x` to save. Press `y` to confirm.

Starting Squid:
---

Start Squid using this command:

~~~
~/sbin/./squid
~~~

Checking it is running:
---

Use this command to see related if Squid and related processes are running:

~~~
ps x | grep squid | grep -v grep
~~~

Connecting to your proxy
---

You connect to your proxy via the proxy settings of your application.

**host:** `server.feralhosting.com`

**Port:** What ever port you set on the conf file. This command will show it to you in SSH:

~~~
cat ~/etc/squid.conf | grep http_port
~~~

**Proxy options:** Use this proxy for all connections (if available).

[Firefox Foxy Proxy](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/)

[Chrome Proxy SwitchySharp](https://chrome.google.com/webstore/detail/proxy-switchysharp/dpplabbmogkhghncfbfdeeokoefdjegm)


Basic Auth instead of Digest:
---

Here is the format for using digest Auth instead of basic.

**1:** Create the password file:

~~~
htpasswd -cm ~/.squidbasic username
~~~

If the file already exists then just use:

~~~
htpasswd -m ~/.squidbasic username
~~~

**2:** Now uncomment this in these `~/etc/squid.conf`  then comment out or remove the Digest Section

~~~
# auth_param basic program /media/DiskID/username/libexec/basic_ncsa_auth /media/DiskID/username/.squidbasic
~~~

**3:** Then restart the Squid server.



