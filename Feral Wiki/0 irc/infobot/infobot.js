// a modified version of benbot
var irc = require("irc");
// https://github.com/martynsmith/node-irc/issues/160 -- creds = { rejectUnauthorized: !self.opt.secure };
// var http= require('http');

var config = {
	channels: ["#feral"],
	server: "irc.what-network.net",
	botName: "infobot",
};

// Create the bot
var infobot = new irc.Client(config.server, config.botName, { 
    channels: config.channels,
    port: 6697,
    secure: true,
    selfSigned: true,
    autoRejoin: true,
    autoConnect: true
});

infobot.setMaxListeners(0);

infobot.addListener('message', function(from, to, message) {

	if ( message.substring(0,4) == '%faq' ) {

		if ( message.length < 5 ) {
			infobot.say(to, "work in progress, use the triggers for now, see %help");
			return;
		}
        
        // what is this? an example of hwo to use trigger words with the prefix %faq. coming back to this at some point.  
        //
        //      if ( message.indexOf('newuser') >= 0 ) {
        //          infobot.say(to, "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
        //          return;
        //      }  
    }
    
    // General

    if ( message == '%activated' ) {
        infobot.say(to, "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
        return;
    }

    if ( message == '%newuser' ) {
        infobot.say(to, "Your Feral slot is active - Part 1 - The Account Manager -- https://www.feralhosting.com/faq/view?question=134");
        infobot.say(to, "Your Feral slot is active - Part 2 - Using your slot -- https://www.feralhosting.com/faq/view?question=225");
        return;
    }

    if ( message == '%common' ) {
        infobot.say(to, "Using your account - common questions -- https://www.feralhosting.com/faq/view?question=14");
        return;
    }

    if ( message == '%pwchange' ) {
        infobot.say(to, "Changing passwords -- https://www.feralhosting.com/faq/view?question=17");
        return;
    }

    if ( message == '%upgrade' ) {
        infobot.say(to, "Slot Upgrades -- https://www.feralhosting.com/faq/view?question=33");
        infobot.say(to, "Completing a data transfer -- https://www.feralhosting.com/faq/view?question=122");
        return;
    }

    if ( message == '%late' ) {
        infobot.say(to, "Late payments -- https://www.feralhosting.com/faq/view?question=8");
        return;
    }

    // Installable Software

    if ( message == '%rtorrent' ) {
        infobot.say(to, "rTorrent - troubleshooting common errors -- https://www.feralhosting.com/faq/view?question=2");
        return;
    }

    if ( message == '%rutorrent' ) {
        infobot.say(to, "ruTorrent - troubleshooting -- https://www.feralhosting.com/faq/view?question=100");
        return;
    }

    if ( message == '%wtorrent' ) {
        infobot.say(to, "wTorrent - Usage and Troubleshooting -- https://www.feralhosting.com/faq/view?question=3");
        return;
    }

    if ( message == '%pausing' ) {
        infobot.say(to, "What to do with torrents added to rtorrent - rutorrent are stuck on Pausing -- https://www.feralhosting.com/faq/view?question=133");
        return;
    }

    if ( message == '%deluge' ) {
        infobot.say(to, "Deluge - troubleshooting -- https://www.feralhosting.com/faq/view?question=62");
        infobot.say(to, "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }

    if ( message == '%transmission' ) {
        infobot.say(to, "Transmission and Transmission Remote GUI -- https://www.feralhosting.com/faq/view?question=4");
        return;
    }

    if ( message == '%vpn' ) {
        infobot.say(to, "OpenVPN - How to connect to your vpn -- https://www.feralhosting.com/faq/view?question=5");
        return;
    }

    if ( message == '%mysql' ) {
        infobot.say(to, "MySQL - how to install and use -- https://www.feralhosting.com/faq/view?question=9");
        infobot.say(to, "Adminer - MySQL administration -- https://www.feralhosting.com/faq/view?question=116");
        return;
    }

    if ( message == '%restart' ) {
        infobot.say(to, "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        return;
    }

    if ( message == '%delugethin' ) {
        infobot.say(to, "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }

    if ( message == '%changeclient' ) {
        infobot.say(to, "How to change torrent clients with active torrents -- https://www.feralhosting.com/faq/view?question=30");
        return;
    }

    // SSH

    if ( message == '%ssh' ) {
        infobot.say(to, "SSH guide basics - PuTTy -- https://www.feralhosting.com/faq/view?question=12");
        infobot.say(to, "SSH guide basics - Mac - https://www.feralhosting.com/faq/view?question=217");
        return;
    }

    if ( message == '%xshell' ) {
        infobot.say(to, "XShell - SSH - SSH tunnels - Private Keys -- https://www.feralhosting.com/faq/view?question=238");
        return;
    }

    if ( message == '%kitty' ) {
        infobot.say(to, "Kitty - SSH - Private Keys - SSH tunnels -- https://www.feralhosting.com/faq/view?question=240");
        return;
    }

    if ( message == '%sshfs' ) {
        infobot.say(to, "Mount Your Server as a Local Filesystem - Windows - Dokan - win-sshfs -- https://www.feralhosting.com/faq/view?question=136");
        infobot.say(to, "Mount Your Server as a Local Filesystem - Linux -- https://www.feralhosting.com/faq/view?question=24");
        return;
    }

    if ( message == '%quota' ) {
        infobot.say(to, "Check your disk quota in SSH -- https://www.feralhosting.com/faq/view?question=221");
        return;
    }

    if ( message == '%publickey' ) {
        infobot.say(to, "Public Key Authentication for password-less login -- https://www.feralhosting.com/faq/view?question=13");
        return;
    }

    if ( message == '%sshtunnel' || message == '%tunnel' || message == '%tunnels' || message == '%socks' || message == '%proxy' || message == '%socksproxy' ) {
        infobot.say(to, "SSH tunnels basics - Putty and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=37");
        infobot.say(to, "SSH Tunnels - How to use them with your applications -- https://www.feralhosting.com/faq/view?question=242");
        return;
    }

    // SFTP and FTP

    if ( message == '%slowftp' ) {
        infobot.say(to, "What to do if FTP speeds are slow -- https://www.feralhosting.com/faq/view?question=28");
        infobot.say(to, "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    if ( message == '%winscp' ) {
        infobot.say(to, "WinSCP - usage - performing common tasks - creating torrents - unrar - symlinks and more -- https://www.feralhosting.com/faq/view?question=27");
        return;
    }

    if ( message == '%lftp' ) {
        infobot.say(to, "LFTP - Automated sync from seedbox to home -- https://www.feralhosting.com/faq/view?question=153");
        return;
    }

    // HTTP

    if ( message == '%nginx' ) {
        infobot.say(to, "Updating Apache to nginx -- https://www.feralhosting.com/faq/view?question=231");
        return;
    }

    if ( message == '%www' ) {
        infobot.say(to, "Putting your WWW folder to use -- https://www.feralhosting.com/faq/view?question=20");
        infobot.say(to, "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        return;
    }

    if ( message == '%vhost' ) {
        infobot.say(to, "Host a virtual host on your Feral slot -- https://www.feralhosting.com/faq/view?question=52");
        return;
    }

    if ( message == '%webapps' ) {
        infobot.say(to, "Owncloud - Basic setup - https://www.feralhosting.com/faq/view?question=249");
        infobot.say(to, "Ajaxplorer 5 - Basic setup -- https://www.feralhosting.com/faq/view?question=222");
        return;
    }

    if ( message == '%apache' ) {
        infobot.say(to, "Apache - basics -- https://www.feralhosting.com/faq/view?question=214");
        return;
    }

    if ( message == '%phpmyadmin' ) {
        infobot.say(to, "phpmyadmin - MySQL Administration -- https://www.feralhosting.com/faq/view?question=230");
        return;
    }

    if ( message == '%php' ) {
        infobot.say(to, "PHP - modify settings -- https://www.feralhosting.com/faq/view?question=213");
        return;
    }

    // Other Software

    if ( message == '%xbmc' || message == '%XBMC' ) {
        infobot.say(to, "XBMC - connecting to shares -- https://www.feralhosting.com/faq/view?question=215");
        return;
    }

    if ( message == '%aria2c' || message == '%aria2' ) {
        infobot.say(to, "aria2c -- https://www.feralhosting.com/faq/view?question=236");
        return;
    }

    if ( message == '%cygwin' ) {
        infobot.say(to, "Cygwin - Linux tools on Windows -- https://www.feralhosting.com/faq/view?question=235");
        return;
    }

    if ( message == '%tor' ) {
        infobot.say(to, "Can I run a Tor node on my slot? -- https://www.feralhosting.com/faq/view?question=246");
        return;
    }

    if ( message == '%remoteadder' ) {
        infobot.say(to, "Remote Torrent Adder - Adding torrents to your slot from Chrome -- https://www.feralhosting.com/faq/view?question=146");
        return;
    }

    // Slot Plans

    if ( message == '%speedtest' ) {
        infobot.say(to, "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    // Software
    
    if ( message == '%multirtorrent' || message == '%multirutorrent' || message == '%multiru' || message == '%multirt' ) {
        infobot.say(to, "Multiple instances - rtorrent and rutorrent -- https://www.feralhosting.com/faq/view?question=244");
        return;
    }
    
    if ( message == '%multideluge' || message == '%multid' ) {
        infobot.say(to, "Deluge - Running more than one Deluge webUI -- https://www.feralhosting.com/faq/view?question=216");
        infobot.say(to, "Deluge - Running more than one instance -- https://www.feralhosting.com/faq/view?question=197");
        return;
    }

    if ( message == '%subsonic' || message == '%madsonic' ) {
        infobot.say(to, "Subsonic 4.8 or Madsonic 5.0 -- https://www.feralhosting.com/faq/view?question=159");
        return;
    }

    if ( message == '%ampache' ) {
        infobot.say(to, "Ampache - web based audio video streaming -- https://www.feralhosting.com/faq/view?question=152");
        return;
    }

    if ( message == '%icecast' ) {
        infobot.say(to, "Icecast - streaming media server -- https://www.feralhosting.com/faq/view?question=155");
        return;
    }

    if ( message == '%proftpd' ) {
        infobot.say(to, "proftpd - Installing an FTP daemon for extra accounts -- https://www.feralhosting.com/faq/view?question=193");            
        return;
    }

    if ( message == '%autodl' || message == '%auto-dl' || message == '%auto dl' || message == '%autodl-irssi' ) {
        infobot.say(to, "Install it: wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh");
        infobot.say(to, "Fix it: wget -qO ~/autodlrutorrentfix.sh http://git.io/BBUryw && bash ~/autodlrutorrentfix.sh");
        return;
    }

    if ( message == '%java' || message == '%jre' ) {
        infobot.say(to, "proftpd - Installing an FTP daemon for extra accounts -- https://www.feralhosting.com/faq/view?question=193");            
        return;
    }

    if ( message == '%dropbox' ) {
        infobot.say(to, "Dropbox - How to install -- https://www.feralhosting.com/faq/view?question=205");            
        return;
    }

    if ( message == '%p7zip' || message == '%7za' || message == '%7z' ) {
        infobot.say(to, "p7zip - basic installation -- https://www.feralhosting.com/faq/view?question=245");            
        return;
    }

    if ( message == '%btsync' || message == '%bitorrent sync' || message == '%bt sync' ) {
        infobot.say(to, "BitTorrent Sync btsync - basic setup -- https://www.feralhosting.com/faq/view?question=224");            
        return;
    }

    if ( message == '%software' ) {
        infobot.say(to, "Generic software install guide - ZNC as an example -- https://www.feralhosting.com/faq/view?question=195");            
        return;
    }

    if ( message == '%yoink!' || message == '%yoink' ) {
        infobot.say(to, "Yoink! The What.cd Freeleech Torrent Grabber -- https://www.feralhosting.com/faq/view?question=251");            
        return;
    }
    
    if ( message == '%weechat' || message ==  '%wee chat' || message == '%WeeChat' ) {
        infobot.say(to, "WeeChat - an IRC Client - Basic Setup -- https://www.feralhosting.com/faq/view?question=250");            
        return;
    }

    if ( message == '%node' || message == '%node.js' || message == '%nodejs' ) {
        infobot.say(to, "node.js - How to install -- https://www.feralhosting.com/faq/view?question=199");            
        return;
    }

    if ( message == '%spideroak' ) {
        infobot.say(to, "SpiderOak -- https://www.feralhosting.com/faq/view?question=203");            
        return;
    }
    
    // Linux

    if ( message == '%rsync' ) {
        infobot.say(to, "rsync - Transferring data from slot to slot -- https://www.feralhosting.com/faq/view?question=117");
        return;
    }

    if ( message == '%irssi' ) {
        infobot.say(to, "irssi - connect to the Feral IRC from your slot -- https://www.feralhosting.com/faq/view?question=232");
        return;
    }

    if ( message == '%ip' ) {
        infobot.say(to, "Find your IP address in the Shell -- https://www.feralhosting.com/faq/view?question=74");
        return;
    }

    if ( message == '%timezone' ) {
        infobot.say(to, "Timezone - How to configure -- https://www.feralhosting.com/faq/view?question=77");
        return;
    }

    if ( message == '%screen' ) {
        infobot.say(to, "Using the Screen Command -- https://www.feralhosting.com/faq/view?question=16");
        return;
    }

    // other

    if ( message == '%email' ) {
        infobot.say(to, "Moving to Interxion -- https://www.feralhosting.com/email/moving-to-interxion.html");
        return;
    }

    if ( message == '%twitter' ) {
        infobot.say(to, "Feralhosting on Twitter -- https://twitter.com/feralstatus");
        return;
    }

    // help

    if ( message == '%help' ) {
        infobot.say(to, "%activated %common %pwchange %upgrade %late %rtorrent %rutorrent %wtorrent %pausing %deluge %transmission %vpn %mysql %restart %delugethin %changeclient %ssh %xshell %kitty %sshfs %quota %publickey %tunnels %slowftp %winscp %lftp %nginx %www %vhost %webapps");
        infobot.say(to, "%apache %phpmyadmin %php %xbmc %aria2c %cygwin %tor %remoteadder %speedtest %subsonic %ampache %icecast %proftpd %autodl %java %dropbox %p7zip %btsync %software %yoink! %weechat %node %spideroak %rsync %irssi %ip timezone %screen %email %twitter &multideluge &multirtorrent ");
        return;
    }
});

infobot.addListener('message', function (from, to, message) {
    console.log(from + ' => ' + to + ': ' + message);
});
infobot.addListener('error', function(message) {
    console.log('error: ', message);
});
infobot.addListener('netError', function(error) {
  console.log('netError: ' + error);
});