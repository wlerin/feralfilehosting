#!/bin/bash
# randomessence
# wget -qO ~/rutnginx.sh http://git.io/9vlcyw && bash ~/rutnginx.sh
echo 'location /rutorrent {
    auth_basic '$(whoami)';
    auth_basic_user_file '$HOME'/www/'$(whoami)'.'$(hostname -f)'/public_html/rutorrent/.htpasswd;
}

location /rutorrent/conf { deny all; }
location /rutorrent/share { deny all; }' > ~/.nginx/conf.d/000-default-server.d/rutorrent.conf
/usr/sbin/nginx -s reload -c ~/.nginx/nginx.conf > /dev/null 2>&1
echo "Done, reload rutorrent in your browser to see if it worked."
echo
