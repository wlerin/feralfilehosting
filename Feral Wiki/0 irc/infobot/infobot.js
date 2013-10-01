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
//    port: 6697,
//    secure: true,
//   selfSigned: true,
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
    
    if ( message == '%newuser' ) {
        infobot.say(to, "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
        infobot.say(to, "Your Feral slot is active - Part 1 - The Account Manager -- https://www.feralhosting.com/faq/view?question=134");
        infobot.say(to, "Your Feral slot is active - Part 2 - Using your slot -- https://www.feralhosting.com/faq/view?question=225");
        infobot.say(to, "Using your account - common questions -- https://www.feralhosting.com/faq/view?question=14");
        return;
    }
    
    // Installable Software
    
   if ( message == '%rtorrent' ) {
        infobot.say(to, "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        infobot.say(to, "ruTorrent - troubleshooting -- https://www.feralhosting.com/faq/view?question=100");
        infobot.say(to, "rTorrent - troubleshooting common errors -- https://www.feralhosting.com/faq/view?question=2");
        return;
    }
    
   if ( message == '%deluge' ) {
        infobot.say(to, "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        infobot.say(to, "Deluge - troubleshooting -- https://www.feralhosting.com/faq/view?question=62");
        infobot.say(to, "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }
    
   if ( message == '%transmission' ) {
        infobot.say(to, "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        infobot.say(to, "Transmission and Transmission Remote GUI -- https://www.feralhosting.com/faq/view?question=4");
        return;
    }
    
   if ( message == '%vpn' ) {
        infobot.say(to, "OpenVPN - How to connect to your vpn -- https://www.feralhosting.com/faq/view?question=5");
        return;
    }
    
   if ( message == '%mysql' ) {
        infobot.say(to, "MySQL - how to install and use -- https://www.feralhosting.com/faq/view?question=9");
        infobot.say(to, "phpmyadmin - MySQL Administration -- https://www.feralhosting.com/faq/view?question=230");
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
    
    if ( message == '%tunnels' ) {
        infobot.say(to, "SSH tunnels basics - Putty and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=37");
        infobot.say(to, "SSH tunnels - MyEnTunnel 3.5 using Plink and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=79");
        infobot.say(to, "SSH Tunnels - How to use them with your applications -- https://www.feralhosting.com/faq/view?question=242");
        return;
    }
  
    // SFTP and FTP

    if ( message == '%slowftp' ) {
        infobot.say(to, "What is multisegmented downloading - how does it help -- https://www.feralhosting.com/faq/view?question=182");
        infobot.say(to, "What to do if FTP speeds are slow -- https://www.feralhosting.com/faq/view?question=28");
        infobot.say(to, "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }
    
    // HTTP
    
    if ( message == '%nginx' ) {
        infobot.say(to, "Updating Apache to nginx -- https://www.feralhosting.com/faq/view?question=231");
        return;
    }
    
    if ( message == '%WWW' ) {
        infobot.say(to, "Putting your WWW folder to use -- https://www.feralhosting.com/faq/view?question=20");
        infobot.say(to, "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        infobot.say(to, "Redirecting HTTP to HTTPS -- https://www.feralhosting.com/faq/view?question=161");
        infobot.say(to, "Host a virtual host on your Feral slot -- https://www.feralhosting.com/faq/view?question=52");
        return;
    }
    
    if ( message == '%webapps' ) {
        infobot.say(to, "Owncloud - Basic setup - https://www.feralhosting.com/faq/view?question=249");
        infobot.say(to, "Ajaxplorer 5 - Basic setup -- https://www.feralhosting.com/faq/view?question=222");
        infobot.say(to, "Wordpress - Basic setup -- https://www.feralhosting.com/faq/view?question=211");
        return;
    }
    
    // Other Software
    
    if ( message == '%media' ) {
        infobot.say(to, "XBMC - connecting to shares -- https://www.feralhosting.com/faq/view?question=215");
        infobot.say(to, "Subsonic 4.8 or Madsonic 5.0 -- https://www.feralhosting.com/faq/view?question=159");
        infobot.say(to, "Ampache - web based audio video streaming -- https://www.feralhosting.com/faq/view?question=152");
        infobot.say(to, "Icecast - streaming media server -- https://www.feralhosting.com/faq/view?question=155");
        return;
    }
    
    // Slot Plans
        
    if ( message == '%upgrade' ) {
        infobot.say(to, "Slot Upgrades -- https://www.feralhosting.com/faq/view?question=33");
        infobot.say(to, "Completing a data transfer -- https://www.feralhosting.com/faq/view?question=122");
        infobot.say(to, "Late payments -- https://www.feralhosting.com/faq/view?question=8");
        return;
    }
    
    if ( message == '%late' ) {
        infobot.say(to, "Late payments -- https://www.feralhosting.com/faq/view?question=8");
        return;
    }
    
    // Software
    
    if ( message == '%proftpd' ) {
        infobot.say(to, "proftpd - Installing an FTP daemon for extra accounts -- https://www.feralhosting.com/faq/view?question=193");            
        return;
    }
    
    if ( message == '%autodl' ) {
        infobot.say(to, "Autodl-irssi and rutorrent plugin - community edition -- https://www.feralhosting.com/faq/view?question=142");
        infobot.say(to, "Install it -- wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh");
        infobot.say(to, "Fix it -- wget -qO ~/autodlrutorrentfix.sh http://git.io/BBUryw && bash ~/autodlrutorrentfix.sh");
        infobot.say(to, "Change Port and password -- wget -qO ~/autodlport.sh http://git.io/vCft_Q && bash ~/autodlport.sh");
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
    
    // help
    
    if ( message == '%help' ) {
        infobot.say(to, "Available triggers: %newuser %rtorrent %deluge %transmission %vpn %mysql %restart %delugethin %changeclient %ssh %xshell %kitty %sshfs %quota %publickey %tunnels %slowftp %nginx %WWW %webapps %media %upgrade %late %proftpd %autodl %rsync %irssi %ip %timezone");
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