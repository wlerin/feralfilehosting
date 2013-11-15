These instructions will configure your ASUS RT-N66U router to use an OpenVPN tunnel provided by your Feralhosting slice. All LAN traffic passing through the router will route through the tunnel. These instructions assume you have an active Feralhosting account and a working ASUS RT-N66U router. Note that any traffic passing through your vpn will count towards your bandwidth.

Upgrade Router Firmware to modified stock
1.	Go to http://www.mediafire.com/asuswrt-merlin/, go into the RT-N66U folder and download the latest version of the file (at the time of writing it is RT-N66U_3.0.0.4_372.30_3.zip) and read the various readme files.
2.	Save this to your computer and extract the file (it will end with a .trx extension).
3.	Log into your router in your browser (by going to http://192.168.1.1/)
4.	In the router's settings pages, on the left click admin and then at the top click on the firmware upgrade tab.
5.	Next to "New Firmware File" click the "choose file" button and select the .trx file you extracted in step 2. Click upload and the modem will upload the file from the computer and will update itself when it is done. Then turn off the router and turn it back on. You will now have the ASUSWRT-Merlin build on your router.

Configure OpenVPN Client Settings
1.	Log back into the ASUS GUI setup page by going to http://192.168.1.1/ in your browser.
2.	On the left side, click the “VPN Server” link, then click the “OpenVPN Client Settings” tab.
3.	Enter the following into the various options:
Select Client Instance: Client 1
Service State: OFF (switch to ON after completing configuration)
Start with WAN: No (Yes, if you want it on after router reboot)
Interface Type: TUN
Protocol: UDP
Server Address and Port: user_name.feralhosting.com, Port 1194
Firewall: Automatic
Authorization Mode: TLS
Username/Password Authentication: No
Extra HMAC authorization: Bi-directional
Create NAT on Tunnel: Yes
Poll interval: 0
Redirect Internet Traffic: Yes
Accept DNS Configuration: Strict (or No, if router DNS preconfigured)
Encryption Cipher: Default
Compression: Adaptive
TLS Renegotiation Time: -1
Connection Retry: -1
Verify Server Certificate: Yes	[Common name: changeme]
Custom Configuration: (enter the following)
tls-auth static.key 1
remote-cert-tls server
user nobody
group nobody 
4.	Click apply at the bottom of the page.

Configure OpenVPN Keys
1.	Click the “OpenVPN Keys” tab at the top of the page.
2.	In the Select OpenVPN instance to edit drop down menu select “Client 1”
3.	If you have not already installed OpenVPN on your slice, do so now.
4.	Download the OpenVPN configuration files from your slice using WinSCP or other SFTP client (/media/sdh1/home/user_name/private/vpn)
5.	Use a text editor to copy the keys and certificates from the files to the fields as indicated below. (NOTE: Copy ONLY the part from “-----BEGIN” to end; ignore anything before “-----BEGIN”)



Filename from slice	router field
	
ca.crt	Certificate Authority
tls-auth.key	Static Key*
user_name.crt	Client Certificate*
user_name.key	Client Key**
Fig. A

6.	Click “Apply” at the bottom of the page.

Enable/Disable vpn service
Log into your router in your browser (by going to http://192.168.1.1/)
Click the “OpenVPN Client Settings” tab again. 
To enable: switch “Service state” to ON.
To disable: switch back to OFF.
