
In SSH do these commands. Use this FAQ if you do not know how to SSH into your slot: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

These commands will download the linked version of node.js and set it up inside your `~/private` directory.

This downloads the `node-v0.10.20-linux-x64.tar.gz` and then saves it as `node.tar.gz` in your  `~/private` directory.

~~~
wget -qO ~/node.js.tar.gz http://nodejs.org/dist/v0.10.20/node-v0.10.20-linux-x64.tar.gz
~~~

This unpacks the folder archived inside the node.tar.gz.

~~~
tar xf ~/node.js.tar.gz
~~~

This moves and renames the recently unpacked folder to `~/node`

~~~
cp -rf ~/node-v0.10.*-linux-x64/. ~/programs
~~~

This deletes the tar archive and unpacked folder we no longer need.

~~~
rm -rf ~/node.js.tar.gz  ~/node-v0.10.*-linux-x64
~~~

This command appends the path to the bottom of the `~/.bashrc` for you. As long as you have not changed the paths in the previous commands. If you have, for example, decided to store the main directory in the root, you need to edit the path in the echo.

~~~
[[][/[][ ! "$(grep '~/programs/bin' ~/.bashrc)" ]] && echo 'PATH=~/programs/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc
~~~

Tries to call `node.js` to check the version:

~~~
node -v
~~~

Which should return:

~~~
v0.10.20
~~~

If you see the version then it is ready to use.

Once you have done this, you are ready to start writing and running your `node.js` apps from anywhere in your account. I personally put all my apps in `~/node/apps/` to keep things tidy though.



