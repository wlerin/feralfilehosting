#!/bin/bash
# Add a cronjob to run a script called ~/delugecron and won't duplicate the entry.
# wget -qO ~/delugecron.sh http://git.io/1emsaw && bash ~/delugecron.sh
# 0 0 * * 0 bash -l ~/delugecron.sh
crontab -l | sed -rn 's/(.*)(bash -l ~\/delugecron)/\2/p' > ~/000delugedummy.txt
tmpfile=$(grep -m 1 'bash\ -l\ ~/delugecron' ~/000delugedummy.txt)
resultcnt=$(grep -c 'bash\ -l\ ~/delugecron' ~/000delugedummy.txt)
#
if [[ "$resultcnt" -gt "1" ]]
then
    (crontab -l | sed -u "/bash -l ~\/delugecron/d") | crontab -
    crontab -l | sed -rn 's/(.*)(bash -l ~\/delugecron)/\2/p' > ~/000delugedummy.txt
    tmpfile=$(grep -m 1 'bash\ -l\ ~/delugecron' ~/000delugedummy.txt)
fi
if [[ -z "$tmpfile" ]]
then
    (crontab -l; echo '0 */5 * * * bash -l ~/delugecron') |uniq - | crontab -
fi
#
echo "$(date +"%H:%M on the %d.%m.%y")" >> ~/delugecron.log
echo "Killing Deluged and the Web Gui"
killall -9  -u $(whoami) deluged deluge-web
echo "Restarting Deluged and the Web Gui"
deluged && deluge-web --fork
rm -f ~/000delugedummy.txt