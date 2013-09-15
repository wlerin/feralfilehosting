If you are finding that your FTP speeds have become slower than usual, there is a workaround that can be applied by increasing the number of concurrent connections that your FTP client will use when connecting to your Feral box.

**In Filezilla (and similar clients)** 

Locate your Site Manager and go to your Feral box entry. Click on the **Transfer Settings** tab and increase this number to 7. Experiment with the number and your speeds should increase somewhat.

These are parallel (concurrent) downloads and not multi segmented. Filezilla does not support multiple segments. Please see this FAQ for more info [What is multisegmented downloading - how does it help](https://www.feralhosting.com/faq/view?question=182)

**Bitkinex multi segmented downloads**

[BitKinex 3.2.3 (windows platform)](http://www.bitkinex.com/ftp/client/bitkinex323.exe) you can use up to 50 segments, locate your feral server entry in the Control window. Right-click on the feral server and select:

`Properties > Connections > Total number of connections used by this data source:`

https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SFTP%20and%20FTP/What%20to%20do%20if%20FTP%20speeds%20are%20slow/bit-1.png
https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SFTP%20and%20FTP/What%20to%20do%20if%20FTP%20speeds%20are%20slow/bit-2.png
https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/SFTP%20and%20FTP/What%20to%20do%20if%20FTP%20speeds%20are%20slow/bit-3.png

Increase this number to 50 connections (default is 5 connections, you can experiment with this number later). First uncheck in the same window: `"Inherit properties from the parent node (SFTP/SSH)"`, otherwise the options stay greyed out.

**In CuteFTP Pro** 

You can use Multi-Part. When using this mode, the file you are downloading is split into several chunks in the background which are then transferred in several threads simultaneously, and then reassembled, once complete, on your local computer. This is the fastest method of transferring large files.

Go to **Tools** > **Global Options** > **Transfer** > **When selecting MAX in multi-part transfer, use...**

When selecting a file to download, right-click on **File** > **Download Advanced** > **Multi-part Download** > **MAX (7 parts)**

**In lftp (*nix)** 

You can use the command **pget** to transfer a file with several connections (specify **-n <maxcon>**). You can also use **mirror** to transfer a folder but specify:

[http://pastebin.com/ny2kNQU7](http://pastebin.com/ny2kNQU7)

or 

[http://pastebin.com/pYTf7Uaf](http://pastebin.com/pYTf7Uaf)

The former uses **pget** to transfer each file, the latter specifies to transfer multiple files at once. You can set whatever default combination you like in your **~/.lftp/rc** file, such as the following:

~~~
set pget:default-n 10
set mirror:use-pget-n 10
set mirror:parallel-transfer-count 2
set mirror:parallel-directories true
~~~

**[Progressive Downloader for OSX](http://www.macpsd.net/)**

You can max out your connection with progressive downloader as an alternative to FTP by playing around with the thread count in **Progressive downloader -> Preferences -> Maximum thread count**: try 10-15. I was having problems with slow FTP speeds but after some experimenting this solution worked for me and i'm now able to max out my connection with no problems. For this to work you will need to put your public_html folder to use, you can do that by following the guide in the wiki located [here](https://www.feralhosting.com/faq/view?question=20)

**Further Problems**

If you continue to have problems then it is likely out of our direct control and down to network issues. We will need to collect data about your connection: 

** Bug in lftp's mirror-over-sftp **

If you use sftp with lftp and "mirror" freezes, it's a known bug in lftp-4.4, upgrade to version >= 4.4.8 
or downgrade to 4.3 - discussion and fix is [here](https://github.com/lavv17/lftp/issues/39)



