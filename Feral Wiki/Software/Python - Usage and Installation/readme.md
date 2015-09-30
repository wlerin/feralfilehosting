
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

You may see this for a module you require a newer or local version of.

~~~
Requirement already satisfied (use --upgrade to upgrade): distribute in /usr/lib/python2.7/dist-packages
~~~

In this case you will need to use certain commands in order to override this and install the required module locally:

**Important note:** To override a system module you will need to either:

1: Use` easy_install` with a the arguments `-U --prefix=$HOME/.local` providing you have created the `~/.local/lib/python2.7/site-packages` directory prior to using the command or you will get an error.

2: Use a locally installed `~/.local/bin/easy_install` with `-U --prefix=$HOME/.local` and/or a locally installed `~/.local/bin/pip` with the arguments `--user --ignore-installed`

See below for in depth usage and examples of this:

### easy_install

**Important note:** The Debian `easy_install` does not work with `--user`.  You must install it locally to use this, see the next section.

~~~
mkdir -p ~/.local/lib/python2.7/site-packages
~~~

**Important note:** The `-U` is required to get a full module installation in some cases where a system wide module was already installed.

~~~
easy_install -U --prefix=$HOME/.local somemodule
~~~

For example:

~~~
easy_install -U --prefix=$HOME/.local pip
~~~

### easy_install locally

~~~
wget https://bootstrap.pypa.io/ez_setup.py -O - | python - --user
~~~

Now you can use `easy_install` to install modules locally using the `--user` argument, for example:

~~~
~/.local/bin/easy_install -U --user somemodule
~~~

For example let's install `pip` and then use pip to install some modules:

~~~
~/.local/bin/easy_install -U --user pip
~~~

Here we install locally and override a very common module installed system wide.

~~~
~/.local/bin/pip install --user --ignore-installed requests
~~~

Now we install a few other modules, less likely to be installed system wide, so we can skip the `--ignore-installed`:

~~~
~/.local/bin/pip install --user HTMLParser
~/.local/bin/pip install --user virtualenv
~/.local/bin/pip install --user flexget
~~~

An example of installing and upgrading a module:

~~~
 ~/.local/bin/pip install --user distribute
 ~/.local/bin/pip install -U --user distribute
~~~

Installing Python locally:
---

You **do not** need to follow this FAQ to use python or python scripts. If you have a missing module you can open a ticket and ask staff to install it or use the above section to install it locally.

This is a basic guide to installing Python to your home directory . You will also be able to use `easy_install` to install mods.

### Python Active State:

Includes lots of things such as VirtualENV, distribute, PIP and more. Super simple to install.

~~~
wget -qO ~/ActivePython.tar.gz http://downloads.activestate.com/ActivePython/releases/2.7.8.10/ActivePython-2.7.8.10-linux-x86.tar.gz
tar xf ActivePython.tar.gz
bash ~/ActivePython-2.7.8.10-linux-x86_64/install.sh
~~~

Select a path to install to. This will create the path if it does not exist.

**Important note:** We do not recommend you install directly to `$HOME` or use this installation in the `PATH` over the existing version.  There will be problems if you do. Do something like this instead:

~~~
Install directory: ~/activestate
~~~

If you make an mistake while typing press and hold `CTRL` and press `backspace` to delete characters.

Read the information displayed, it will tell you what `PATH` to add and where.

Optional: To remove the installation files.

~~~
cd && rm -f ActivePython{-2.7.8.10-linux-x86_64.tar.gz,-2.7.8.10-linux-x86_64}
~~~

Type this command to reload the shell:

~~~
bash
~~~

To use `easy_install` with this installation use the full path to your installation.

~~~
~/activestate/bin/easy_install
~~~

Done.

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
wget -qO ~/Python.tar.xz  https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tar.xz
tar xf ~/Python.tgz && cd ~/Python-3.5.0
./configure --prefix=$HOME/python/python3 && make && make install
~~~

The configuration and installation can take some time to be patient.

When it is finished installing, do some clean up with this command.

~~~
cd && rm -rf ~/Python{-3.5.0,.tgz}
~~~

Python has been installed. Now check which version is in use:

~~~
~/python/python3/bin/python -V
~~~

Using `easy_install` from the command line to install mods:

~~~
~/python/python3/bin/pip install virtualenv
~~~

~~~
~/python/python3/bin/pip install flexget
~~~



