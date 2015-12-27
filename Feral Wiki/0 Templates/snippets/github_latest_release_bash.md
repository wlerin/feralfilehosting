Get the latest github release version number from the github api using a simple command line in bash.
---

The start to this is to get the api json result via a command. curl or wget both work. Where `username` is the Github username and `reponame` is the repositary name in the example commands below.

curl -s https://api.github.com/repos/username/reponame/releases/latest
wget -q -O - https://api.github.com/repos/username/reponame/releases/latest

For example, using the constantly changing version number fro [Syncthing](https://github.com/syncthing/syncthing)

~~~
curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest
wget -q -O - https://api.github.com/repos/syncthing/syncthing/releases/latest
~~~

So now that we have the json result what do we do with it? We can do whatever we want. I chose to simply pipe it to `sed` in order to get the non repeating `tag_name` like this:

~~~
sed -rn 's/(.*)"tag_name": "(.*)",/\2/p'
~~~

With the full commands being:

~~~
curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | sed -rn 's/(.*)"tag_name": "(.*)",/\2/p'
wget -q -O - https://api.github.com/repos/syncthing/syncthing/releases/latest | sed -rn 's/(.*)"tag_name": "(.*)",/\2/p'
~~~

With the result being something like:

~~~
v0.12.10
~~~

Now the problematic part is that the tag is not always entirely useful and we only want part of it. 

In the example of Syncthing I want the version number and not the `v` preceding it. So I customise the reg-ex inside the tag to exclude the `v`:

~~~
sed -rn 's/(.*)"tag_name": "v(.*)",/\2/p'
~~~

So now I only get:

~~~
0.12.10
~~~

You will have to customise it on a case by case basis if you only need part of the result.

jq
---

We could also pipe it to `jq` https://stedolan.github.io/jq/

> jq is like sed for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.

We first need to download the linux binary.

~~~
wget -qO ~/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
chmod +x ~/jq
~~~

Now we can pipe it or use it to parse json via the shell.















Using curl

~~~
curl -s https://api.github.com/repos/username/reponame/releases/latest | sed -rn 's/(.*)"tag_name": "(.*)",/\2/p'
~~~

Using wget

~~~
wget -q -O - https://api.github.com/repos/username/reponame/releases/latest | sed -rn 's/(.*)"tag_name": "(.*)",/\2/p'
~~~

Used like this in a ssh script

~~~
latestrelease="$(curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | sed -rn 's/(.*)"tag_name": "v(.*)",/\2/p')"
latestrelease="$(wget -q -O - https://api.github.com/repos/syncthing/syncthing/releases/latest | sed -rn 's/(.*)"tag_name": "v(.*)",/\2/p')"
~~~


autodllatest="$(curl -s https://api.github.com/repos/autodl-community/autodl-irssi/releases/latest | sed -rn 's/(.*)"tag_name": "community-v(.*)",/\2/p')"
trackerslatest="$(curl -s https://api.github.com/repos/autodl-community/autodl-trackers/releases/latest | sed -rn 's/(.*)"tag_name": "community-v(.*)",/\2/p')"