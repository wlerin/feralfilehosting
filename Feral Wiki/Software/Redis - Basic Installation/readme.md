
### Redis

~~~
wget -qO ~/redis-2.6.16.tar.gz http://download.redis.io/releases/redis-2.6.16.tar.gz
tar xzf ~/redis-2.6.16.tar.gz
mv -f ~/redis-2.6.16 ~/redis
cd ~/redis && make
~~~

Then edit the conf to your needs, located here:

~~~
~/redis/redis.conf
~~~

Then start redis using this command:

~~~
~/redis/src/./redis-server ~/redis/redis.conf
~~~



