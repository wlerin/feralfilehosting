
ffmpeg

~~~
wget -qO ~/ffmpeg.tar.gz http://ffmpeg.gusari.org/static/64bit/ffmpeg.static.64bit.2013-09-16.tar.gz
mkdir -p ~/ffmpeg && tar -xzf ~/ffmpeg.tar.gz -C ~/ffmpeg
echo 'PATH=~/ffmpeg:$PATH' >> ~/.bashrc && source ~/.bashrc
ffmpeg -version
~~~