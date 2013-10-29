
NB: The scripts used in this tutorial are outdated, especially in their inability to correctly parse foreign characters. A more up-to-date script can be found at http://github.com/RecursiveForest/whatmp3 . Configuration and execution are very similar, with the exception that the word "python" should be substituted for "perl" in the instructions.

This script requires `lame`, `flac` and `metaflac` be installed on the server (perl and rsync are installed by default on all servers).

### Testing Your Server for LAME, FLAC, and METAFLAC

[SSH to your server](https://www.feralhosting.com/faq/view?question=12), and type:

~~~
lame
~~~

— and press `enter` to confirm. If you get a `command not found` message, this means LAME is not installed on the server.

Then test your server for `flac` and `metaflac` (both lowercase).

If any of them are missing, please take out a [support ticket](https://www.feralhosting.com/admin/support) requesting them to be installed on your server.

This guide assumes that you will be converting files residing in your rTorrent data dir. Converted files as well as the corresponding .torrent files for What.CD are to be found in the same location.

### Configuring the Script

Download the [script](http://pastebin.com/download.php?i=gkbqQu11) and rename it to `converter.pl`. Using a text editor of your choice (if on Windows, may we suggest the tiny portable [notepad2](http://www.flos-freeware.ch/zip/notepad2.zip)) edit the following lines:

[img=http://i37.tinypic.com/35j0b9t.jpg][/img]

As the comment in the script explains, if set to 1 (equals `yes`), conversion will fail if the original .flac files you are converting from are not properly tagged. If you plan to convert files for your own use, consider setting this value to 0 (so that you can convert both tagged and untagged .flac files). However if you plan to upload your converted files to What.CD, please note that as per [What.CD requirements](https://ssl.what.cd/rules.php?p=upload#h2.3) "file names must accurately reflect the song titles. You may not have file names like 01track.mp3, 02track.mp3, etc. File names with incorrect song titles can be trumped by properly labeled torrents."

Consider setting this value to 1 for What.CD uploads to make sure the converted MP3 files are named properly (the tradeback in this case is that you will not be able to convert untagged .flac files though).

[img=http://i38.tinypic.com/2eev9sm.jpg][/img]

Substitute the sample passkey with your actual What.CD passkey. Substitute `YOUR_USERNAME` in the path with your actual Feral username. Delete everything in between the quotes if you do not want to autocreate .torrents for the files you convert.

You do not need to edit anything else. Save changes. Upload `converter.pl` to your rTorrent data dir:

~~~
/home/YOUR_USERNAME/private/rtorrent/data
~~~

### Using the Script: Command Line

[SSH to your server](https://www.feralhosting.com/faq/view?question=12) and copy and paste the following set of commands after the command prompt:

~~~
cd ~/private/rtorrent/data
~~~

This will transfer you to your rTorrent data dir.

The script is to be run this way:

~~~
perl converter.pl --v0 --320 "NAME_OF_DIR"
~~~

where `NAME_OF_DIR` is the name of the dir with the .flac files you want to convert (please note the use of double quotes).

If the dir with your .flac files is called `Dry The River - The Chamblers & The Valves 2009`, then the command you would use is:

~~~
perl converter.pl --v0 --320 "Dry The River - The Chamblers & The Valves 2009"
~~~

The command above will convert your files to MP3 v0, MP3 320, and create a private .torrent file for What.CD with your passkey in it, all in one go.

If you want to convert to MP3 v0 only, use this command:

~~~
perl converter.pl --v0 "NAME_OF_DIR"
~~~

If you want to convert to v2, use the `--v2` switch.

Once the conversion is over, download your .torrent file to your local computer and upload it to What.CD (use the `Add format` link for that):

[img=http://i34.tinypic.com/2earnmb.jpg][/img]

Then upload the .torrent to your rTorrent watch dir — rTorrent will hash check the files, and in a few seconds you will be seeding.

**SCRIPT LIMITATIONS:**

**does not handle multiple disc albums**;

(this [alternative script](http://rusak.pastebin.com/f7f2fa9f8) can handle multiple disc albums perfectly, but doesn't always play nice with WinSCP if that part is important to you; uses the same syntax as the one for the original script in this guide. Note that this alternate script does not handle files with single quote in the name, and the args are --V0 / --V2 instead of --v0 / --v2)

- can only take 1 album at a time;

- cannot correctly label the .torrent of a Various Artist album (shouldn't be a problem as the site will rename the .torrent anyway).

### Using the Script: WinSCP Custom Command

Please see our [WinSCP Guide](https://www.feralhosting.com/faq/view?question=27) for more detailed instructions on how to configure custom commands in WinSCP.

Since conversion may take up to a few minutes, you will need to increase the timeout setting in WinSCP. In the WinSCP Login configuration dialog, click on Connection in the left pane and set the server response timeout to 600 seconds as shown in the screenshot below.

[img=http://i31.tinypic.com/2isioi1.jpg][/img]

Your custom command for converting to both v0 and 320 will be:

~~~
perl converter.pl --v0 --320 "!"
~~~

[img=http://i36.tinypic.com/xcj3pc.jpg][/img]

For converting just to v0:

~~~
perl converter.pl --v0 "!"
~~~

[img=http://i36.tinypic.com/30ubvv4.jpg][/img]



