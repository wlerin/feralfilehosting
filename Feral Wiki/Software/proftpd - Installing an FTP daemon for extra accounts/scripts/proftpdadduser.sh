#!/bin/bash
# made by finesse for feral hosting faq
# use as you like
# no warranties
passwdfile="$HOME/proftpd/etc/ftpd.passwd"
groupdfile="$HOME/proftpd/etc/ftpd.group"
binarycmd="$HOME/proftpd/bin/ftpasswd"
idcount=5001
exec 6<&0
exec 0<"$passwdfile"
while read line1
do
    foundid="$(echo $line1 |grep -o $idcount)"
    if [ -n "$foundid" ]
        then
            idcount="$(expr $idcount + 1)"
    fi
done
exec 0<&6
echo
echo -e "Using" "\033[31m""$idcount""\e[0m" "for id's."
echo
if [ -n "$1" ]
    then
        echo "Using $1 for name."
        name="$1"
    else
        read -ep "Please input username: " name
        echo
fi
echo -e "\033[32m""Do not include the""\e[0m" "\033[31m""~/""\e[0m" "\033[32m""in the path. Use paths that match existing Jails, relative to your Root directory, for example:""\e[0m"
echo
echo -e "\033[36m""private/rtorrent/data""\e[0m"
echo
echo -e "\033[33m""Use TAB to auto complete the path.""\e[0m"
echo
read -ep "Please specify a relative path to the users home/jail directory: ~/" -i "private/rtorrent/data" jailpath
echo
"$binarycmd" --passwd --name="$name" --file="$passwdfile" --uid="$idcount" --gid="$idcount" --home="$HOME/$jailpath" --shell="/bin/false"
"$binarycmd" --group --name="$name" --file="$groupdfile" --gid="$idcount" --member="$name"