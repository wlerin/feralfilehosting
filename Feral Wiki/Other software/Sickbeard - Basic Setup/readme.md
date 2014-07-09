
Installing Sick-Beard on a Feral slot should be quick and easy with some basic command-line know how.

SSH to your slot and pull Sickbeard:

~~~
git clone https://github.com/midgetspy/Sick-Beard ~/Sick-Beard
~~~

Alternatively:

SickRage - https://github.com/echel0n/SickRage

~~~
git clone https://github.com/echel0n/SickRage ~/SickRage
~~~

Pick a port between `10000` and `50000`.  Remember this port!  Then let's start up the Sickbeard daemon on that port.

~~~
python ~/Sick-Beard/SickBeard.py -d -p XXXXX
~~~

where `XXXXX` is the port you picked.  If `XXXXX` does not work or errors out, it's probably in use, so pick something else.

Then connect to your Sickbeard Web GUI on your slot by pointing your browser to: 

~~~
http://server.feralhosting.com:XXXXX
~~~

Click Config->General Configuration

Set `HTTP Username` to your desired username.
Set `HTTP Password` to your desired password.
Click `Save Changes`.

If SickBeard goes down, restart it with:

~~~
python ~/Sick-Beard/SickBeard.py -d -p XXXXX
~~~



