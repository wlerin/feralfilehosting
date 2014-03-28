
~~~
mkdir -p ~/programs
wget -qO ~/atheme-services.tar.bz2 http://www.atheme.net/downloads/atheme-services-7.0.6.tar.bz2
tar xf ~/atheme-services.tar.bz2
cd ~/atheme-services-7.0.6
./configure --prefix=$HOME/programs
make && make install
~~~

Edit the config file.


Create a copy of the included example.

~~~
cp -f ~/~/programs/etc/atheme.conf.example ~/programs/etc/atheme.conf
~~~

Now edit the file:

~~~
nano -w ~/programs/etc/atheme.conf
~~~

~~~
uplink "irc.example.net" {
	// The server name of the ircd you're linking to goes above.

	// host
	// The hostname to connect to.
	host = "0.0.0.0";

	// vhost
	// The source IP to connect from, used on machines with multiple interfaces.
	#vhost = "202.119.187.31";

	// password
	// The password used for linking.
	password = "linkage";

	// port
	// The port to connect to.
	port =34562;
};
~~~

~~~
httpd {
	/* host
	 * The host that the HTTP server will listen on.
	 * Use 0.0.0.0 if you want to listen on all available hosts.
	 */
	host = "0.0.0.0";

	/* host (ipv6)
	 * If you want, you can have Atheme listen on an IPv6 host too.
	 * Use :: if you want to listen on all available IPv6 hosts.
	 */
	#host = "::";

	/* www_root
	 * The directory that contains the files that should be served by the httpd.
	 */
	www_root = "/var/www";

	/* port
	 * The port that the HTTP server will listen on.
	 */
	port = 23463;
};
~~~

### Web GUI

~~~
wget -qO ~/atheme.tar.bz2 http://www.atheme.net/downloads/atheme-web-0.2.0.tar.bz2
tar xf ~/atheme.tar.bz2
easy_install --user paste
~~~