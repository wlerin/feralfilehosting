Air Video HD
Air Video HD is an iOS app that allows you to watch videos streamed instantly from your computer on your iPhone, iPad, iPod Touch or Apple TV.
No need to worry about converting or transferring files.  Even videos not natively supported by iOS will play fine and they can be downloaded to your device for watching later/offline!

It can be configured to stream videos from your Feral slot, instead of your local computer.

Before proceeding, you must do two things:

1) Raise a support ticket with Feral staff and ask them to install the VLC libraries on your slot
2) Download the Air Video iOS app using the App Store on your device

Having done 1 and 2 above, first of all, ssh into your slot using Terminal on your Mac (or Windows equivalent), using the following command:

ssh <username>@<slot>.feralhosting.com, where <username> is your Feral username and <slot> is the name of your Feral slot.

Once in an ssh session, use the mkdir command to create a directory for AirVideo:

mkdir AirVideo

Now navigate to this new directory using the CD command:

cd AirVideo

Now enter the following command to download Air Video HD Server:

wget https://s3.amazonaws.com/AirVideoHD/Download/AirVideoServerHD-2.1.3.tar.bz2

Now unzip using the following command:

bzip2 -d filename.bz2

Now run the following command to extract the tar file:

tar -xvf AirVideoServerHD-2.1.3.tar

Now we need to edit the Server.properties file to add the path containing the videos we wish to share.  The following command opens the file in a text editor, ready for editing:

nano Server.properties

Scroll down to the Sharing settings section and set sharedFolders1.path (and sharedFolders2.path if you want to share a second folder) accordingly - set it to the path of a folder on your slot that contains videos you wish to make available in the Air Video app.

You can look through this file and change any other settings you see fit by amending their entry.

Once you’ve set the folder paths, press Ctrl + O (letter O, not number zero) to save the file, press Return to overwrite the existing settings, then press Ctrl + X to exit the text editor.

Next we need to start the server, using:

screen bash start.sh

Now, open Air Video on your iOS device.  Click the + icon to add a server, then choose Specify Manually.

Enter the host as:

<username>.<slot>.feralhosting.com (where <username> is your Feral username and <slot> is the name of your Feral slot)

For the port number, use the default 45633 (unless you changed it in the Server.properties file above).

That's it - all being well you should now be able to browse the folder(s) specified in Server.properties above and stream any video files in these folders directly to your iOS device, even if they are in a format not natively supported by iOS.  You can even download the videos to your device for watching whilst offline! 