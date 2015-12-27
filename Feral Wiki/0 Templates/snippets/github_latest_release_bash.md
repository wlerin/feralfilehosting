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

For example:

Here we can just prettify the data:

~~~
curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq
~~~
Here we use a basic filter:

~~~
curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq .tag_name
~~~

Here we use the `-r` argument to get the raw result.

~~~
curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest | jq -r .tag_name
~~~

https://stedolan.github.io/jq/manual/

~~~
jq - commandline JSON processor [version 1.5]
Usage: jq [options] <jq filter> [file...]

	jq is a tool for processing JSON inputs, applying the
	given filter to its JSON text inputs and producing the
	filter's results as JSON on standard output.
	The simplest filter is ., which is the identity filter,
	copying jq's input to its output unmodified (except for
	formatting).
	For more advanced filters see the jq(1) manpage ("man jq")
	and/or https://stedolan.github.io/jq

	Some of the options include:
	 -c		compact instead of pretty-printed output;
	 -n		use `null` as the single input value;
	 -e		set the exit status code based on the output;
	 -s		read (slurp) all inputs into an array; apply filter to it;
	 -r		output raw strings, not JSON texts;
	 -R		read raw strings, not JSON texts;
	 -C		colorize JSON;
	 -M		monochrome (don't colorize JSON);
	 -S		sort keys of objects on output;
	 --tab	use tabs for indentation;
	 --arg a v	set variable $a to value <v>;
	 --argjson a v	set variable $a to JSON value <v>;
	 --slurpfile a f	set variable $a to an array of JSON texts read from <f>;
	See the manpage for more options.
~~~



