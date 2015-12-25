
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

**Important Note:** Do not install Python manually without a good reason. It will most likely cause more problems than is solves.

**Python 2.7.9 is already installed on your slot**

Type to show the current version:

~~~
python -V
~~~

`pip` is installed on all servers ready to be used. You do no need to install `pip` locally first. To use it do this:

~~~
pip install --user modulename
~~~

For example:

~~~
pip install --user requests
~~~

Installing Modules locally and/or overriding installed modules
---

This step is required otherwise you'll get an error.

~~~
pip install --user --ignore-installed pip
~~~

Now you can overwrite modules locally using this command:

~~~
pip install --user --ignore-installed modulename
~~~

Installing Python locally:
---

You **do not** need to follow this FAQ to use python or python scripts. If you have a missing module you can open a ticket and ask staff to install it or use the above section to install it locally.

This is a basic guide to installing Python to your home directory . You will also be able to use `easy_install` to install mods.

Installing Python 2.7 from source:
---

In SSH do these commands. Use this FAQ if you do not know how to SSH into your slot: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

**Important note:** We do not recommend you install directly to `$HOME` or use this installation in the `PATH` over the existing version.  There will be problems if you do. Do something like this instead:

~~~
--prefix=$HOME/python/python.2.7
~~~

~~~
mkdir -p ~/python/python2
wget -qO ~/Python.tgz https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar xf ~/Python.tgz && cd ~/Python-2.7.10
./configure --prefix=$HOME/python/python2 && make && make install
~~~

The configuration and installation can take some time to be patient.

When it is finished installing, do some clean up with this command.

~~~
cd && rm -rf ~/Python{-2.7.10,.tgz}
~~~

Python has been installed. Now check which version is in use:

~~~
~/python/python2/bin/python -V
~~~

Using `easy_install` from the command line to install mods:

~~~
~/python/python2/bin/easy_install pip
~~~

~~~
~/python/python2/bin/pip install virtualenv
~~~

~~~
~/python/python2/bin/pip install flexget
~~~

Python 3
---

~~~
mkdir -p ~/python/python3
wget -qO ~/python.tar.xz  https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tar.xz
tar xf ~/python.tar.xz && cd ~/Python-3.5.0
./configure --prefix=$HOME/python/python3 && make && make install
~~~

The configuration and installation can take some time to be patient.

When it is finished installing, do some clean up with this command.

~~~
cd && rm -rf ~/python{-3.5.0,.tar.xz}
~~~

Python has been installed. Now check which version is in use:

~~~
~/python/python3/bin/python3 -V
~~~

Using `easy_install` from the command line to install mods:

~~~
~/python/python3/bin/pip3 install virtualenv
~~~






