#!/bin/bash
# Script name
scriptversion="1.0.0"
scriptname="updateinfobot"

wget -qO $HOME/infobot.js https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20irc/infobot/infobot.js

if ! diff -q $HOME/infobot.js $HOME/nodeapps/infobot.js > /dev/null 2>&1 ; then
    cp -f $HOME/infobot.js $HOME/nodeapps/infobot.js
    rm -f $HOME/infobot.js
    exit 1
fi
