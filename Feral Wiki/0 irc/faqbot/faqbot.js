// a modified version of benbot
var irc = require("irc");
// https://github.com/martynsmith/node-irc/issues/160 -- creds = { rejectUnauthorized: !self.opt.secure };
// var http= require('http');

var config = {
	channels: ["#feral"],
	server: "irc.what-network.net",
	botName: "faqbot",
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

/*
infobot.addListener('message', function(from, to, message) {
	if ( message.substring(0,4) == '%faq' ) {

		if ( message.length < 5 ) {
			infobot.say(to, "work in progress, use the triggers for now, see %help");
			return;
		}
        
        what is this? an example of how to use trigger words with the prefix %faq.
        
        if ( message.indexOf('newuser') >= 0 ) {
          infobot.say(to, "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
         return;
        }  
    }
    
}); 
*/
    
// Start of triggers

// How to use these triggers. Here is a template:

/*
if ( message == '%trigger' || message == '%trigger' + result ) {
    if ( result !== '' ) { var result = result + ': '; }

    infobot.say(to, result + "FAQ name -- FAQ URL");
    return;
}
*/

infobot.addListener('message', function(from, to, message) {

    if (message.match(/^%(.*)\s(.*)?/)) { var result = message.match(/^%(.*)\s(.*)/)[2]; } else { var result = ''; }
    if ( result !== '' ) { var result =  ' ' + result; }
    
    // No triggers above here
    
    // General

    if ( message == '%activated' || message == '%activated' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
        return;
    }

    if ( message == '%newuser' || message == '%newuser' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Your Feral slot is active - Part 1 - The Account Manager -- https://www.feralhosting.com/faq/view?question=134");
        infobot.say(to, result + "Your Feral slot is active - Part 2 - Using your slot -- https://www.feralhosting.com/faq/view?question=225");
        return;
    }

    if ( message == '%common' || message == '%common' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Using your account - common questions -- https://www.feralhosting.com/faq/view?question=14");
        return;
    }

    if ( message == '%pwchange' || message == '%pwchange' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Changing passwords -- https://www.feralhosting.com/faq/view?question=17");
        return;
    }

    if ( message == '%upgrade' || message == '%upgrade' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Slot Upgrades -- https://www.feralhosting.com/faq/view?question=33");
        infobot.say(to, result + "Completing a data transfer -- https://www.feralhosting.com/faq/view?question=122");
        return;
    }

    if ( message == '%late' || message == '%late' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Late payments -- https://www.feralhosting.com/faq/view?question=8");
        return;
    }

    // Installable Software

    if ( message == '%rtorrent' || message == '%rtorrent' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "rTorrent - troubleshooting common errors -- https://www.feralhosting.com/faq/view?question=2");
        return;
    }

    if ( message == '%rutorrent' || message == '%rutorrent' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "ruTorrent - troubleshooting -- https://www.feralhosting.com/faq/view?question=100");
        return;
    }

    if ( message == '%wtorrent' || message == '%wtorrent' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "wTorrent - Usage and Troubleshooting -- https://www.feralhosting.com/faq/view?question=3");
        return;
    }

    if ( message == '%pausing' || message == '%pausing' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "What to do with torrents added to rtorrent - rutorrent are stuck on Pausing -- https://www.feralhosting.com/faq/view?question=133");
        return;
    }

    if ( message == '%deluge' || message == '%deluge' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Deluge - troubleshooting -- https://www.feralhosting.com/faq/view?question=62");
        infobot.say(to, result + "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }

    if ( message == '%transmission' || message == '%transmission' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        infobot.say(to, result + "Transmission and Transmission Remote GUI -- https://www.feralhosting.com/faq/view?question=4");
        return;
    }

    if ( message == '%vpn' || message == '%vpn' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "OpenVPN - How to connect to your vpn -- https://www.feralhosting.com/faq/view?question=5");
        return;
    }

    if ( message == '%mysql' || message == '%mysql' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "MySQL - how to install and use -- https://www.feralhosting.com/faq/view?question=9");
        infobot.say(to, result + "Adminer - MySQL administration -- https://www.feralhosting.com/faq/view?question=116");
        return;
    }

    if ( message == '%restart' || message == '%restart' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        return;
    }

    if ( message == '%delugethin' || message == '%delugethin' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }

    if ( message == '%changeclient' || message == '%changeclient' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "How to change torrent clients with active torrents -- https://www.feralhosting.com/faq/view?question=30");
        return;
    }

    // SSH

    if ( message == '%ssh' || message == '%ssh' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "SSH guide basics - PuTTy -- https://www.feralhosting.com/faq/view?question=12");
        infobot.say(to, result + "SSH guide basics - Mac - https://www.feralhosting.com/faq/view?question=217");
        return;
    }

    if ( message == '%xshell' || message == '%xshell' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "XShell - SSH - SSH tunnels - Private Keys -- https://www.feralhosting.com/faq/view?question=238");
        return;
    }

    if ( message == '%kitty' || message == '%kitty' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Kitty - SSH - Private Keys - SSH tunnels -- https://www.feralhosting.com/faq/view?question=240");
        return;
    }

    if ( message == '%sshfs' || message == '%sshfs' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Mount Your Server as a Local Filesystem - Windows - Dokan - win-sshfs -- https://www.feralhosting.com/faq/view?question=136");
        infobot.say(to, result + "Mount Your Server as a Local Filesystem - Linux -- https://www.feralhosting.com/faq/view?question=24");
        return;
    }

    if ( message == '%quota' || message == '%quota' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Check your disk quota in SSH -- https://www.feralhosting.com/faq/view?question=221");
        return;
    }

    if ( message == '%publickey' || message == '%publickey' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Public Key Authentication for password-less login -- https://www.feralhosting.com/faq/view?question=13");
        return;
    }

    if ( message == '%tunnel' || message == '%tunnel' + result || message == '%sshtunnel' || message == '%tunnels' || message == '%socks' || message == '%proxy' || message == '%socksproxy' ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "SSH tunnels basics - Putty and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=37");
        infobot.say(to, result + "SSH Tunnels - How to use them with your applications -- https://www.feralhosting.com/faq/view?question=242");
        return;
    }

    // SFTP and FTP

    if ( message == '%slowftp' || message == '%slowftp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "What to do if FTP speeds are slow -- https://www.feralhosting.com/faq/view?question=28");
        infobot.say(to, result + "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    if ( message == '%winscp' || message == '%winscp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "WinSCP - usage - performing common tasks - creating torrents - unrar - symlinks and more -- https://www.feralhosting.com/faq/view?question=27");
        return;
    }

    if ( message == '%lftp' || message == '%lftp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "LFTP - Automated sync from seedbox to home -- https://www.feralhosting.com/faq/view?question=153");
        return;
    }

    // HTTP

    if ( message == '%nginx' || message == '%nginx' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Updating Apache to nginx -- https://www.feralhosting.com/faq/view?question=231");
        return;
    }

    if ( message == '%www' || message == '%www' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Putting your WWW folder to use -- https://www.feralhosting.com/faq/view?question=20");
        infobot.say(to, result + "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        return;
    }
    
    if ( message == '%pwprotect' || message == '%pwprotect' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        return;
    }
    
    if ( message == '%vhost' || message == '%vhost' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Host a virtual host on your Feral slot -- https://www.feralhosting.com/faq/view?question=52");
        return;
    }

    if ( message == '%webapps' || message == '%webapps' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Owncloud - Basic setup - https://www.feralhosting.com/faq/view?question=249");
        infobot.say(to, result + "Ajaxplorer 5 - Basic setup -- https://www.feralhosting.com/faq/view?question=222");
        return;
    }

    if ( message == '%apache' || message == '%apache' + result || message == '%Apache' || message == '%Apache' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Apache - basics -- https://www.feralhosting.com/faq/view?question=214");
        return;
    }

    if ( message == '%phpmyadmin' || message == '%phpmyadmin' + result || message == '%pma' || message == '%pma' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "phpmyadmin - MySQL Administration -- https://www.feralhosting.com/faq/view?question=230");
        return;
    }

    if ( message == '%php' || message == '%php' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "PHP - modify settings -- https://www.feralhosting.com/faq/view?question=213");
        return;
    }

    // Other Software

    if ( message == '%xbmc' || message == '%xbmc' + result || message == '%XBMC' || message == '%XBMC' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "XBMC - connecting to shares -- https://www.feralhosting.com/faq/view?question=215");
        return;
    }

    if ( message == '%aria2c' || message == '%aria2c' + result || message == '%aria2' || message == '%aria2' + result || message == '%aria' || message == '%aria' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "aria2c -- https://www.feralhosting.com/faq/view?question=236");
        return;
    }

    if ( message == '%cygwin' || message == '%cygwin' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Cygwin - Linux tools on Windows -- https://www.feralhosting.com/faq/view?question=235");
        return;
    }

    if ( message == '%tor' || message == '%tor' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Can I run a Tor node on my slot? -- https://www.feralhosting.com/faq/view?question=246");
        return;
    }

    if ( message == '%remoteadder' || message == '%remoteadder' + result || message == '%rta' || message == '%rta' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Remote Torrent Adder - Adding torrents to your slot from Chrome -- https://www.feralhosting.com/faq/view?question=146");
        return;
    }

    // Slot Plans

    if ( message == '%speedtest' || message == '%speedtest' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    // Software
    
    if ( message == '%multirtorrent' || message == '%multirtorrent' + result || message == '%multirutorrent' || message == '%multirutorrent' + result || message == '%multiru' || message == '%multiru' + result || message == '%multirt' || message == '%multirt' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Multiple instances - rtorrent and rutorrent -- https://www.feralhosting.com/faq/view?question=244");
        return;
    }
    
    if ( message == '%multideluge' || message == '%multideluge' + result || message == '%multid' || message == '%multid' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Deluge - Running more than one Deluge webUI -- https://www.feralhosting.com/faq/view?question=216");
        infobot.say(to, result + "Deluge - Running more than one instance -- https://www.feralhosting.com/faq/view?question=197");
        return;
    }

    if ( message == '%subsonic' || message == '%subsonic' + result || message == '%Subsonic' || message == '%Subsonic' + result || message == '%madsonic' || message == '%madsonic' + result || message == '%Madsonic' || message == '%Madsonic' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Subsonic 4.8 or Madsonic 5.0 -- https://www.feralhosting.com/faq/view?question=159");
        return;
    }

    if ( message == '%ampache' || message == '%ampache' + result || message == '%Ampache' || message == '%Ampache' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Ampache - web based audio video streaming -- https://www.feralhosting.com/faq/view?question=152");
        return;
    }

    if ( message == '%icecast' || message == '%icecast' + result || message == '%Icecast' || message == '%Icecast' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Icecast - streaming media server -- https://www.feralhosting.com/faq/view?question=155");
        return;
    }

    if ( message == '%proftpd' || message == '%proftpd' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "proftpd - Installing an FTP daemon for extra accounts -- https://www.feralhosting.com/faq/view?question=193");            
        return;
    }

    if ( message == '%autodl' || message == '%autodl' + result || message == '%auto-dl' || message == '%auto-dl' + result || message == '%autodl-irssi' || message == '%autodl-irssi' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Install it: wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh");
        infobot.say(to, result + "Fix it: wget -qO ~/autodlrutorrentfix.sh http://git.io/BBUryw && bash ~/autodlrutorrentfix.sh");
        return;
    }

    if ( message == '%java' || message == '%Java' + result || message == '%Java' || message == '%java' + result || message == '%jre' || message == '%jre' + result || message == '%JRE' || message == '%JRE' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Java 1.7 -- https://www.feralhosting.com/faq/view?question=183");            
        return;
    }

    if ( message == '%dropbox' || message == '%dropbox' + result || message == '%Dropbox' || message == '%Dropbox' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Dropbox - How to install -- https://www.feralhosting.com/faq/view?question=205");            
        return;
    }

    if ( message == '%p7zip' || message == '%p7zip' + result || message == '%7za' || message == '%7za' + result || message == '%7z' || message == '%7z' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "p7zip - basic installation -- https://www.feralhosting.com/faq/view?question=245");            
        return;
    }

    if ( message == '%btsync' || message == '%btsync' + result || message == '%BTsync' || message == '%BTsync' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "BitTorrent Sync btsync - basic setup -- https://www.feralhosting.com/faq/view?question=224");            
        return;
    }

    if ( message == '%software' || message == '%software' + result || message == '%Software' || message == '%Software' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Generic software install guide - ZNC as an example -- https://www.feralhosting.com/faq/view?question=195");            
        return;
    }

    if ( message == '%Yoink!' || message == '%Yoink!' + result || message == '%Yoink' || message == '%Yoink' + result || message == '%yoink!' || message == '%yoink!' + result || message == '%yoink' || message == '%yoink' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Yoink! The What.cd Freeleech Torrent Grabber -- https://www.feralhosting.com/faq/view?question=251");            
        return;
    }
    
    if ( message == '%weechat' || message == '%weechat' + result || message == '%WeeChat' || message == '%WeeChat' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "WeeChat - an IRC Client - Basic Setup -- https://www.feralhosting.com/faq/view?question=250");            
        return;
    }

    if ( message == '%node' || message == '%node' + result || message == '%node.js' || message == '%node.js' + result || message == '%nodejs' || message == '%nodejs' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "node.js - How to install -- https://www.feralhosting.com/faq/view?question=199");            
        return;
    }

    if ( message == '%spideroak' || message == '%spideroak' + result || message == '%Spideroak' || message == '%Spideroak' + result || message == '%SpiderOak' || message == '%SpiderOak' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "SpiderOak -- https://www.feralhosting.com/faq/view?question=203");            
        return;
    }
    
    // Linux

    if ( message == '%rsync' || message == '%rsync' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "rsync - Transferring data from slot to slot -- https://www.feralhosting.com/faq/view?question=117");
        return;
    }

    if ( message == '%irssi' || message == '%irssi' + result || message == '%Irssi' || message == '%Irssi' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "irssi - connect to the Feral IRC from your slot -- https://www.feralhosting.com/faq/view?question=232");
        return;
    }

    if ( message == '%ip' || message == '%ip' + result || message == '%IP' || message == '%IP' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Find your IP address in the Shell -- https://www.feralhosting.com/faq/view?question=74");
        return;
    }

    if ( message == '%timezone' || message == '%timezone' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Timezone - How to configure -- https://www.feralhosting.com/faq/view?question=77");
        return;
    }

    if ( message == '%screen' || message == '%screen' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Using the Screen Command -- https://www.feralhosting.com/faq/view?question=16");
        return;
    }

    // other

    if ( message == '%email' || message == '%email' + result  || message == '%Interxion' || message == '%Interxion' + result || message == '%interxion' || message == '%interxion' + result || message == '%moving' || message == '%moving' + result || message == '%fibre' || message == '%fibre' + result || message == '%fiber' || message == '%fiber' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        infobot.say(to, result + "Moving to Interxion -- https://www.feralhosting.com/email/moving-to-interxion.html");
        return;
    }

    if ( message == '%twitter' || message == '%twitter' + result || message == '%Twitter' || message == '%Twitter' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        infobot.say(to, result + "Feralhosting on Twitter -- https://twitter.com/feralstatus");
        return;
    }
}); 

// End of triggers

// Help section

infobot.addListener('message', function(from, to, message) {

	if ( message.substring(0,5) == '%help' ) {
    
		if ( message.length < 6 ) {
			infobot.say(to, "Use %help with one of these: general installable ssh ftp http other slots software linux generic ");
			return;
		}
        
        if ( message.indexOf('general') >= 0 ) {
          infobot.say(to, "%activated %newuser %common %pwchange %upgrade %late ");
          return;
        }
        
        if ( message.indexOf('installable') >= 0 ) {
          infobot.say(to, "%rtorrent %rutorrent %wtorrent %pausing %deluge %transmission %vpn %mysql %restart %delugethin %changeclient");
          return;
        }
        
        if ( message.indexOf('ssh') >= 0 ) {
          infobot.say(to, "%ssh %xshell %kitty %sshfs %quota %publickey %tunnels ");
          return;
        }
        
        if ( message.indexOf('ftp') >= 0 ) {
          infobot.say(to, "%slowftp %winscp %lftp ");
          return;
        }
        
        if ( message.indexOf('http') >= 0 ) {
          infobot.say(to, "%nginx %www %vhost %webapps %apache %phpmyadmin %php ");
          return;
        }
        
        if ( message.indexOf('other') >= 0 ) {
          infobot.say(to, "%xbmc %aria2c %cygwin %tor %remoteadder");
          return;
        }
        
        if ( message.indexOf('slots') >= 0 ) {
          infobot.say(to, "%speedtest");
          return;
        }
        
        if ( message.indexOf('software') >= 0 ) {
          infobot.say(to, "%subsonic %ampache %icecast %proftpd %autodl %java %dropbox %p7zip %btsync %software %yoink! %weechat %node %spideroak &multideluge &multirtorrent");
          return;
        }
        
        if ( message.indexOf('linux') >= 0 ) {
          infobot.say(to, "%rsync %irssi %ip timezone %screen ");
          return;
        }
        
        if ( message.indexOf('generic') >= 0 ) {
          infobot.say(to, "%email %twitter");
          return;
        }
    }
});

// End of help section

// Console stuff and error reporting

infobot.addListener('message', function (from, to, message) {
    console.log(from + ' => ' + to + ': ' + message);
});
infobot.addListener('error', function(message) {
    console.log('error: ', message);
});
infobot.addListener('netError', function(error) {
  console.log('netError: ' + error);
});