
[h2]Titles[/h2]
For titling your FAQ you can use - [url=http://titlecapitalization.com/]titlecapitalization.com[/url]

[h2]How do I create a FAQ?[/h2]
Click on this link: [url=https://www.feralhosting.com/faq/add]Add a Question[/url] and paste in your formatted text as the answer. Your question is the Title of the FAQ or guide. Open a ticket as outlined below to inform staff of the new FAQ.

[b]Important note:[/b] After you have created the guide please submit a ticket using the title format [code single]New FAQ - FAQ name - Category[/code]

[b]Title:[/b] New FAQ - How To Use SSH - SSH

[b]Body:[/b] Can you please review my new FAQ

[h2]How do I edit a FAQ?[/h2]
Simply [b]click on edit at the bottom of the FAQ[/b] and submit your edited version along with reason for the change.

[b]Important note:[/b] After you have edited the guide please submit a ticket using the title format [code single]FAQ Edit - FAQ name - Category[/code]

In the body submit a link to the FAQ you edited. So for example:

[b]Title:[/b] FAQ Edit - SSH Guide Basics - PuTTy - SSH

[b]Body:[/b] https://www.feralhosting.com/faq/view?question=12 I fixed a broken link.

[h2]Formatting[/h2]
You can use Markdown to edit or create a FAQ if you wish. You will have to convert it to Feral BBCode using this tool:

[url=http://feralhosting.github.io/convert/m2b/index.html]Markdown to BBCode[/url]

[b]Important note:[/b] Please use fenced code blocks and in-line URLs (not the type linked at the bottom of the page). See formatting guidelines below for more info

Here are some good on-line Markdown editors.

[url=http://markable.in/editor/]markable.in[/url] 

[url=http://dillinger.io/]dillinger.io[/url]

There is also a BBCode to Markdown tool for porting an existing FAQ so it can be edited or updated in Markdown and then converted back.

[url=http://feralhosting.github.io/convert/b2m/index.html]BBCode to Markdown[/url]

Copy and paste the returned text into a new FAQ or an edit. The layout and formatting will be correct, there is no need to change it.

Please don't get too creative with the tags. These tools are very specific to the tags used here at Feral, which are documented below.

These are some Tags that work for formatting. They all need to be properly closed using [code single][[][/[]/tag][/code].
For example you would close code like this: [code single][[][/[]/code][/code]

[h2]Title tags[/h2]
h1

[code][[][/[]h1]Title h1[[][/[]/h1][/code]
Here is the markdown equivalent:

[code]Markdown Title h1
===[/code]
h2

[code][[][/[]h2]Title h2[[][/[]/h2][/code]
Here is the markdown equivalent:

[code]Markdown Title h2
---[/code]
h3

[code][[][/[]h3]Title h3[[][/[]/h3][/code]
Here is the markdown equivalent:

[code]### Markdown Title h3[/code]
h4

[code][[][/[]h4]Title h4[[][/[]/h4][/code]
Here is the markdown equivalent:

[code]#### Markdown Title h4[/code]
h5

[code][[][/[]h5]Title h5[[][/[]/h5][/code]
Here is the markdown equivalent:

[code]##### Markdown Title h5[/code]
h6

[code][[][/[]h6]Title h6[[][/[]/h6][/code]
Here is the markdown equivalent:

[code]###### Markdown Title h6[/code]
[h2]Code blocks[/h2]
For single lines:

[code][[][/[]code]Standard code blocks with a single line[[][/[]/code][/code]
For multiple lines:

[code][[][/[]code]Standard
code 
blocks
with
multiple
lines[[][/[]/code][/code]
Here is the markdown equivalent:

For single lines:

[code]~~~
Standard code blocks with a single line
~~~[/code]
For multiple lines:

[code]~~~
Standard
code 
blocks
with
multiple
lines
~~~[/code]

In-line code blocks:

[code][[][/[]code single]in-line code[[][/[]/code][/code]
Here is the markdown equivalent:

[code]`in-line code`[/code]
[h2]CODE blocks specifics[/h2]
For formatted code blocks follow this rule below:

When using the code tag use this rule for formatting regarding new lines please.

[code]Blank line above

[[][/[]code]Some code wrapped in code tags[[][/[]/code]
No new/blank line below.[/code]
This rule also applies for tags that also apply formatting above and below the line like 
the [code single]H2[/code] and [code single]H3[/code] tag do, but not the Bold tag for example. You can leave a blank line below
the [code single]b[/code],[code single]i[/code],[code single]img[/code],[code single]url[/code] tags.

[h2]Bold and Italic tags[/h2]
Bold:

[code][[][/[]b]bold[[][/[]/b][/code]
Here is the markdown equivalent:

[code]**bold**[/code]
Strong:

[code][[][/[]strong]strong (can/will be manually replaced by italic)[[][/[]/strong][/code]
Here is the markdown equivalent:

[code]**strong**[/code]
Italic:

[code][[][/[]i]italic[[][/[]/i][/code]
Here is the markdown equivalent:

[code]*italic*[/code]
Emphasis:

[code][[][/[]em]emphasis (can/will be manually replaced by italic)[[][/[]/em][/code]
Here is the markdown equivalent:

[code]*emphasis*[/code]
[h2]Image tags[/h2]
Use this opening and closing tag for direct links to images.

This example tag usages will give us:

[code][[][/[]img]http://i.imgur.com/pRfcyAi.jpg[/img][/code]
This result:

[img]http://i.imgur.com/pRfcyAi.jpg[/img]

Here is the markdown equivalent:

[code]![](http://i.imgur.com/pRfcyAi.jpg)[/code]
[h3]URL and URL tags[/h3]
URLs are automatically detected and do not need a tag, so this:

[code]http://i.imgur.com/pRfcyAi.jpg[/code]
This URL will be automatically detected and give you a click-able link, for example:

http://i.imgur.com/pRfcyAi.jpg

[b]URLs with a description[/b] - should be used in a specific way using the URL tag.

[code][[][/[]url=http://i.imgur.com/pRfcyAi.jpg]Link description[/url][/code]
Will give us this result:

[url=http://i.imgur.com/pRfcyAi.jpg]Link description[/url]

Here is the markdown equivalent:

[code][Link description](http://i.imgur.com/pRfcyAi.jpg)[/code]
[h2]Custom Software[/h2]
Custom software installations that have a typical directory structures, such as [code single]~/bin[/code] should be installed to [code single]$HOME[/code], like this:

[code]configure --prefix=$HOME[/code]
This will use the [code single]~/bin[/code] folder for binaries and this location will automatically be added to the [code single]PATH[/code] via the [code single]~/.profile[/code] file once the user has logged out of their SSH session and logs back in.

You can ask them to log out and log into a new SSH session or optionally use this command at the start of the FAQ to create the directory and to reload the shell for the change to take effect:

[code]mkdir -p ~/bin && bash[/code]
Exceptions to the rule?

1: Programs like AeroFS,Spideroak and Filebot that do not have a conventional directory structure that would work with the [code single]~/bin[/code] location, or for other self contained applications.

2: Programs that might conflict with slot operations such as Python or where you want multiple versions of an application. Then use a custom location for this software. Try not to use a very complex or needlessly deep directory structure where possible. In these cases it is advised you do not add the locations to the PATH and provide full paths to the binaries for use when needed instead.

[h2]Python and user mods.[/h2]
When a [code single]--user[/code] mod is installed using the slot's included Python, it will always go to the location:

[code]~/.local/bin[/code]
Python will detect this location for any required dependencies a script might have, but if you need to call an installed module directly in your terminal you can use this command to add the [code single]~/.local/bin[/code] to the [code single]~/.bashrc[/code].

[code][ ! "$(grep '~/.local/bin' ~/.bashrc)" ] && echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc ; source ~/.bashrc[/code]
[h2]File Hosting[/h2]
[b]IMAGES[/b]

When needed some images will be re-hosted, so use whatever you need/can when editing the faq.

[url=http://imgur.com/]http://imgur.com/[/url] is a popular choice.

[b]FILES[/b]

Important files will be re-hosted on a more permanent platform when needed. If this is important include this info in the ticket.

[url=http://www.mediafire.com/]http://www.mediafire.com/[/url] is a good choice.

[h2]Closing: At the end of the FAQ[/h2]
Please leave 4 blank lines at the end of any question you edit or submit. This is a visual thing.

[h2]Feral FAQ Cheat Sheet[/h2]
What is this? this is a list of preferred formatting when adding certain info. Feel free to add to this.

Use [code single]$(whoami)[/code] and [code single]$(hostname)[/code] to automatically insert a users info.

[code]cd ~/www/$(whoami).$(hostname)/public_html/[/code]
The following command in SSH to see the [code single]hostname[/code] and IP:

[code]host $(hostname)[/code]
The following command in SSH to see the IP only:

[code]hostname -i[/code]
The following command to get your external IP:

[code]curl -s icanhazip.com[/code]
[url=http://linux.die.net/man/1/wget]wget[/url]

[code single]-q[/code] quiet
[code single]-N[/code] Overwrite if newer or different (timestamps)
[code single]-O[/code] Save to file.
[code single]-P[/code] Set directory prefix to prefix. Is the directory where all other files and subdirectories will be saved to

[code]wget -q www.somelink.com/script.sh -O thisfile.sh[/code]
You will see most FAQs use this format:

[code]wget -qO ~/thisfile.sh www.somelink.com/script.sh[/code]
This basically just puts the file in the slot root with the use of [code single]~/[/code] using the filename specified.

[url=http://linux.die.net/man/1/tar]tar[/url]

[code single]-c[/code] create
[code single]-x[/code] extract
[code single]-z[/code] .gz or .tgz
[code single]-j[/code] .bz2
[code single]-f[/code] file
[code single]-v[/code] verbose
[code single]-C[/code] to directory

[b]Important note:[/b] [code single]tar[/code] can detect the compression used so it is not actually required to specify it. This means the use of [code single]z[/code] and [code single]j[/code] are optional.

[code]tar xf archive.tar.gz[/code]
[code]tar xf archive.tar.gz -C some/directory/[/code]
[url=http://linux.die.net/man/1/unzip]unzip[/url]

[code single]-q[/code] quiet
[code single]-o[/code] overwrite
[code single]-d[/code] extract to directory 

[code]unzip -qo archive.zip[/code]
[code]unzip -qo archive.zip -d some/directory/[/code]
[h3]screen[/h3]
Send a command to a running screen and window of choice.

[code]screen -S screen-name -p 0 -X exec your-command-goes-here[/code]
[code single]-S[/code] screen-name you want to match
[code single]-p[/code] number of the screen window, 0 in this case sends it to the first.
[code single]exec[/code] some-command

When using [b]screen[/b] give the window a name by using [b]-S[/b] for easier management. The word after the [b]-S[/b] is the name of the window, in this case rtorrent.

This will attach to a screen with this name:

[code]screen -S rtorrent rtorrent[/code]
This will attach to a screen with this name or create it if it doesn't:

[code]screen -R rtorrent rtorrent[/code]
Will start the selected process in the background as a daemon and detach from it immediately:

[code]screen -dmS rtorrent rtorrent[/code]
[url=http://linux.die.net/man/1/kill]kill[/url]

[code]kill -9 PID[/code]
[url=http://linux.die.net/man/1/killall]killall[/url]

[code]killall -9 -u $(whoami) processname[/code]
[h3]TAB autocomplete[/h3]
Use [code single]TAB[/code] to autocomplete parts of your SSH commands.

For example: if I am in my home folder and I wish to go to my 

[code]~/private/rtorrent[/code]
I can do this

[code]cd ~/p TAB[/code]
Which will give me this:

[code]~/private/[/code]
Unless I have more than one folder starting with [b]p[/b]. then I must give a second or third letter depending on how they conflict. In this case I do not have a conflicting folder name.

Then if I do:

[code]cd ~/private/r TAB[/code]
I will end up with this:

[code]cd ~/private/rtorrent/[/code]
So now I press enter. I have now used TAB to auto-complete parts of my [b]cd[/b] command.

[h3]github url shortening[/h3]
[url=http://git.io/]http://git.io/[/url]

[url=https://github.com/blog/985-git-io-github-url-shortener]git-io-github-url-shortener[/url]

You can do it in SSH using this command.

[code]curl -i http://git.io -F "url=YOU.URL.HERE"[/code]
[h3]Chaining Commands[/h3]
The use of [code single]&&[/code] will move to the next command if the previous command was successful.

[code]cd ~/private && mkdir test && cd test[/code]
So if the directory [code single]~/private[/code] did not exist the command would stop at the point where a single command did not execute successfully.

The use is [code single];[/code] will just chain a series of commands. 

[code]cd ~/private; mkdir test; cd test[/code]
Here it will just do command one then execute the next until it reaches the end. So if [code single]~/private[/code] did not exist the command would create the [code single]test[/code] folder in the wrong place.

[b]Run a process and send it to the background.[/b]

if you add a [code single]&[/code] to the end of your command it will be sent to the background as your run it.

[code]./some/path/to/a/binary &[/code]
[h3]Crontab[/h3]
[b]Important note:[/b] It is generally best practice to use full paths to the programs you wish to execute. To get the full path do this in SSH:

Use the [code single]whereis[/code] command to find the binary locations:

[code]whereis cp[/code]
Will return something like this:

[code]cp: /bin/cp /usr/share/man/man1/cp.1.gz[/code]
Here the path we need is:

[code]/bin/cp[/code]
To edit your crontab:

[code]crontab -e[/code]
To execute a bash script from crontab you need to use this command:

[code]bash -l[/code]
For example:

[code]@reboot bash -l ~/myscript.sh[/code]



