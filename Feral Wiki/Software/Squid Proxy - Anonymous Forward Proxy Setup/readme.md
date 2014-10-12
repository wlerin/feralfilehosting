
Squid - A forward proxy
---

Use this article to download and configure Squid as an anonymous web proxy with `basic_auth` authentication

**1:**  Create an auth file that we will use to authenticate the proxy users.

~~~
htpasswd -cm ~/.squidauth username
~~~

If the file already exists then just use:

~~~
htpasswd -m ~/.squidauth username
~~~

**2:** Install and compile Squid.

~~~
wget -qO ~/squid.tar.gz http://www.squid-cache.org/Versions/v3/3.4/squid-3.4.8.tar.gz
tar xf ~/squid.tar.gz && cd squid-3.4.8
./configure --prefix=$HOME
make && make install && cd
rm -rf squid{-3.4.8,.tar.gz}
~~~

**3:** Get the preconfigured conf file that we will have to modify a little.

~~~
wget -qO ~/etc/squid.conf http://git.io/yavZuw
~~~

**Recommended:** Make some required changes to the conf file with these commands.

~~~
sed -i "s|/media/DiskID/username|$HOME|g" ~/etc/squid.conf
sed -i "s|http_port 3128|http_port $(shuf -i 6000-50000 -n 1)|g" ~/etc/squid.conf
~~~

**4:** Personalise the conf

Ruin this command in SSH:

~~~
nano ~/etc/squid.conf
~~~

Modify this section only:

**1:** `username` needs to be changed to atch the user you created in step 1 in the `~/.squidauth` file.
**2:** Full paths should already match your slots if you ran the `sed` command. Othewise edit them to mact your slots full path.
**3:** The port should have been randomised for you  if you ran the `sed` commands so just take not of it. Otherwise change the port to something between `10000` and `50000`

**Important note:**  The helpers required for authentication are located in `~/libexec`. For example `basic_ncsa_auth`

~~~
# And finally deny all other access to this proxy
auth_param basic program /media/DiskID/username/libexec/basic_ncsa_auth /media/DiskID/username/.squidauth
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


htdigest auth:
---

Here is the format for using digest auth instead of basic.

1: Create the password file:

~~~
htdigest -c ~/.squiddigest MyRealm username
~~~

Now add these to the `~/etc/squid.cong` replacing the `basic_auth` version.

~~~
auth_param digest program /media/DiskID/username/libexec/digest_file_auth -c /media/DiskID/username/.squiddigest
auth_param digest children 5
auth_param digest realm MyRealm
~~~

Then restart the Squid server.



