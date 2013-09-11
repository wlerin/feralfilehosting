#!/bin/bash
# The simple version
# 0 */5 * * * bash -l ~/delugecron
echo "$(date +"%H:%M on the %d.%m.%y")" >> ~/delugecron.log
echo "Killing Deluged and the Web Gui"
killall -9  -u $(whoami) deluged deluge-web
echo "Restarting Deluged and the Web Gui"
deluged && deluge-web --fork