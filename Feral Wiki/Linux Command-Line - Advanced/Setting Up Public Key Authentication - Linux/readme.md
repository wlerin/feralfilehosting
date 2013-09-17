
This guide is for **GNU Linux users** who wish to use Public/Private Key Authentication to quickly access their shell with Feral Hosting. It is primarily for Ubuntu Linux, but most commands apply to most other distributions.

**Generate your own public and private key pair**

Issue this command. It will ask you specify where you want to store the keys, just hit the [Enter] key to use the default. Specifying a password is not mandatory, but in the interests of security it's really necessary. Most modern Linux distributions will allow you to automate the logging of this key so you won't have to type it in at boot.

~~~
ssh-keygen
~~~

[img=http://i30.tinypic.com/2lwrk07.png] [/img]

**Send Public key to server and add to authorized_keys**

**i:** Securely send public key to remote server

~~~
scp ~/.ssh/id_rsa.pub username@server.feralhosting.com:~/
~~~

**ii:** Login to remote server

~~~
ssh username@server.feralhosting.com
~~~

**iii:** Add the key you sent to the authorized_keys list of the server (Note: If you get the message "No such file or directory", it means that your SSH directory doesn't exist.  Type **mkdir ~/.ssh** and then retry the following command.)

~~~
cat id_rsa.pub >> ~/.ssh/authorized_keys
~~~

**vi:** Remove public key file

~~~
rm id_rsa.pub
~~~

**Test that it works**

Log out of a SSH session you already have and try logging into the server with 

~~~
ssh username@server.feralhosting.com
~~~

You should now be automatically logged in using Public Key Authentication.



