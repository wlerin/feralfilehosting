
**1:** Download [pyWHATauto](https://github.com/jimrollenhagen/pywhatauto/archive/master.zip).

**2:** Extract it to any folder you want, let's say /pyWHATauto/. It can be anywhere, really.

**3:** Edit the setup.conf file. There are examples there commented out by ';'. Fill out your information and save it.

**4:** Edit the credentials.conf file. Currently only whatcd and broadcasthenet are fully functional. Each option should be self-explanatory, but just in case:

4.1: enabled: is this site enabled?
4.2: nickowner: what is the ident of the owner of the bot? For example, on what.cd mine is set to: 34038@johnnyfive.member.what.cd
4.3: chanfilter: What channels on this network should I join on connect? Multiple entries can be separated by commas.
4.4: username: The username on the website you use.
4.5: password: The password on the website you use.
4.6: botNick: The nickname of the bot which will join the IRC network.
4.7: irckey: The IRCkey set at the website.
4.8: nickServPass: The registration password for the botNick to authorize to nickserv.
4.9: watch: This is the only tricky one. This watch folder will only by used for manual downloads on this network.

**5:** Edit the filters.conf file. Woohooo here's where the fun begins!

5.1: At the top of each example filter is a list of the allowed filter options for that site.
5.2: Each tag/filter option can have multiple values, separated either by commas or newline+tab.
5.3: "site" and "filtertype" are important! Look at the examples to see how they are used.
5.4: "enabled" will toggle whether the filter is on or off.

**6:** From there, depending on your OS, you can start the program. On linux navigate to the folder that holds WHATauto.py, and type "python WHATauto.py". That's it! If you want to screen it, just do "screen python WHATauto.py".

**7:** It should be running, and connected to some networks.

**8:** Connect to said networks with your favorite IRC program. Make sure you are ident'd with Nickserv and the network bot.

**9:** Type %help in the #whatbot channel. See if it responds. If all went well, you should receive a reply in the channel.


---
an alternative guide is available on what.cd: [https://ssl.what.cd/forums](https://ssl.what.cd/forums.php?action=viewthread&threadid=88314)

