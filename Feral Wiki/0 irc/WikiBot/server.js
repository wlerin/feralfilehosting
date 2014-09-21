// a modified version of benbot by BenHarris
var irc = require("irc");
var c = require('irc-colors');
// https://github.com/martynsmith/node-irc/issues/160 -- creds = {rejectUnauthorized: !self.opt.secure};
// var http= require('http');

var config = {
	channels: ["#feral"],
	server: "irc.what-network.net",
	botName: "WikiBot",
};

// Create the bot
var WikiBot = new irc.Client(config.server, config.botName, { 
    channels: config.channels,
    port: 6697,
    secure: true,
    selfSigned: true,
    certExpired: true,
    showErrors: true,
    autoRejoin: true,
    autoConnect: true,
    retryCount: null,
    retryDelay: 2000,
    floodProtection: true,
    floodProtectionDelay: 1000
});

// https://www.feralhosting.com/manager/bandwidth

WikiBot.setMaxListeners(0);

// Start of triggers

// How to use these triggers. Here is a template:

/*
WikiBot.addListener('message', function(from, to, message) {

    if ( message == '%trigger' || message == '%trigger' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "FAQ name -- FAQ URL");
        return;
    }
}); 
*/

setInterval(function(){WikiBot.send('PONG', 'empty');}, 5*60*1000);

WikiBot.addListener('message', function(from, to, message) {

    if (message.match(/%([^\s]+)\s([^\s]+ |[^\s]+)/)) { var result = message.match(/%([^\s]+)\s([^\s]+ |[^\s]+)/)[2]; } else { var result = ''; }
    if ( result !== '' ) { var result =  ' ' + result; }
    
    // No triggers above here
    
    // General

    if ( message == '%activated' || message == '%activated' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "How long until my slot is activated -- https://www.feralhosting.com/faq/view?question=15");
        return;
    }

    if ( message == '%activated1' || message == '%activated1' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Your Feral slot is active - Part 1 - The Account Manager -- https://www.feralhosting.com/faq/view?question=134");
        return;
    }
    
    if ( message == '%activated2' || message == '%activated2' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Your Feral slot is active - Part 2 - Using your slot -- https://www.feralhosting.com/faq/view?question=225");
        return;
    }

    if ( message == '%common' || message == '%common' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Using your account - common questions -- https://www.feralhosting.com/faq/view?question=14");
        return;
    }

    if ( message == '%pwchange' || message == '%pwchange' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Changing passwords -- https://www.feralhosting.com/faq/view?question=17");
        return;
    }
    
    if ( message == '%transfer' || message == '%transfer' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Completing a data transfer -- https://www.feralhosting.com/faq/view?question=122");
        return;
    }
    
    if ( message == '%late' || message == '%late' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Late payments -- https://www.feralhosting.com/faq/view?question=8");
        return;
    }

    if ( message == '%useful' || message == '%useful' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Useful and recommended software -- https://www.feralhosting.com/faq/view?question=35");
        return;
    }
    
    if ( message == '%edit' || message == '%edit' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "I want to edit or create a FAQ or guide -- https://www.feralhosting.com/faq/view?question=167");
        return;
    }
    
    if ( message == '%upgrade' || message == '%upgrade' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Slot Upgrades -- https://www.feralhosting.com/faq/view?question=33");
        WikiBot.say(to, result + "Completing a data transfer -- https://www.feralhosting.com/faq/view?question=122");
        return;
    }
    
    // Installable Software
    
    if ( message == '%install' || message == '%install' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Installing new software -- https://www.feralhosting.com/faq/view?question=6");
        return;
    }
    
    if ( message == '%rtorrentv' || message == '%rtorrentv' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Selecting an rtorrent version -- https://www.feralhosting.com/faq/view?question=202");
        return;
    }
    
    if ( message == '%uninstall' || message == '%uninstall' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Uninstalling software -- https://www.feralhosting.com/faq/view?question=70");
        return;
    }
    
    if ( message == '%restart' || message == '%restart' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Restarting - rtorrent - Deluge - Transmission - MySQL -- https://www.feralhosting.com/faq/view?question=158");
        return;
    }
    
    if ( message == '%rutorrent' || message == '%rutorrent' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "ruTorrent - troubleshooting -- https://www.feralhosting.com/faq/view?question=100");
        return;
    }
    
    if ( message == '%deluge' || message == '%deluge' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Deluge - troubleshooting -- https://www.feralhosting.com/faq/view?question=62");
        return;
    }
    
    if ( message == '%transmission' || message == '%transmission' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        WikiBot.say(to, result + "Transmission and Transmission Remote GUI -- https://www.feralhosting.com/faq/view?question=4");
        return;
    }
    
    if ( message == '%delugethin' || message == '%delugethin' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Deluge Daemon - Remote control with the local Thin client -- https://www.feralhosting.com/faq/view?question=76");
        return;
    }
    
    if ( message == '%rtorrent' || message == '%rtorrent' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "rTorrent - troubleshooting common errors -- https://www.feralhosting.com/faq/view?question=2");
        return;
    }
    
    if ( message == '%vpn' || message == '%vpn' + result || message == '%openvpn' || message == '%openvpn' + result || message == '%OpenVPN' || message == '%OpenVPN' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "OpenVPN - How to connect to your vpn -- https://www.feralhosting.com/faq/view?question=5");
        return;
    }
    
    if ( message == '%rssfeeds' || message == '%rssfeeds' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Backing up rutorrent RSS feeds and filters -- https://www.feralhosting.com/faq/view?question=162");
        return;
    }

    if ( message == '%pausing' || message == '%pausing' + result || message == '%paused' || message == '%paused' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "What to do with torrents added to rtorrent - rutorrent are stuck on Pausing -- https://www.feralhosting.com/faq/view?question=133");
        return;
    }
    
    if ( message == '%feralstats' || message == '%feralstats' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Feralstats plugin for ruTorrent -- https://www.feralhosting.com/faq/view?question=126");
        return;
    }

    if ( message == '%mysql' || message == '%mysql' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "MySQL - how to install and use -- https://www.feralhosting.com/faq/view?question=9");
        WikiBot.say(to, result + "Adminer - MySQL administration -- https://www.feralhosting.com/faq/view?question=116");
        return;
    }

    if ( message == '%changeclient' || message == '%changeclient' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "How to change torrent clients with active torrents -- https://www.feralhosting.com/faq/view?question=30");
        return;
    }
    
    if ( message == '%delugeplugins' || message == '%delugeplugins' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Deluge - Plugins using the thin client -- https://www.feralhosting.com/faq/view?question=223");
        return;
    }

    // SSH

    if ( message == '%ssh' || message == '%ssh' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "SSH guide basics - PuTTy -- https://www.feralhosting.com/faq/view?question=12");
        WikiBot.say(to, result + "SSH guide basics - Mac - https://www.feralhosting.com/faq/view?question=217");
        return;
    }
    
    if ( message == '%sshpc' || message == '%sshpc' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "SSH guide basics - PuTTy -- https://www.feralhosting.com/faq/view?question=12");
        return;
    }
    
    if ( message == '%sshosx' || message == '%sshosx' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "SSH guide basics - Mac - https://www.feralhosting.com/faq/view?question=217");
        return;
    }
    
    if ( message == '%tunnel' || message == '%tunnel' + result || message == '%sshtunnel' || message == '%tunnels' || message == '%socks' || message == '%proxy' || message == '%socksproxy' ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "SSH tunnels basics - Putty and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=37");
        WikiBot.say(to, result + "SSH tunnels - OS X -- https://www.feralhosting.com/faq/view?question=271");
        return;
    }

    if ( message == '%tunnelpc' || message == '%tunnelpc' + result ) {
    
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "SSH tunnels basics - Putty and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=37");
        return;
    }
    
    if ( message == '%tunnelosx' || message == '%tunnelosx' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "SSH tunnels - OS X -- https://www.feralhosting.com/faq/view?question=271");
        return;
    }
    
    if ( message == '%usetunnel' || message == '%usetunnel' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "SSH Tunnels - How to use them with your applications -- https://www.feralhosting.com/faq/view?question=242");
        return;
    }
    
    if ( message == '%myentunnel' || message == '%myentunnel' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "SSH tunnels - MyEnTunnel 3.5 using Plink and setting a Socks proxy -- https://www.feralhosting.com/faq/view?question=79");
        return;
    }
    
    if ( message == '%publickey' || message == '%publickey' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Public Key Authentication for password-less login -- https://www.feralhosting.com/faq/view?question=13");
        return;
    }

    if ( message == '%pageant' || message == '%pageant' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Putty - using PAGEANT -- https://www.feralhosting.com/faq/view?question=241");
        return;
    }

    if ( message == '%xshell' || message == '%xshell' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "XShell - SSH - SSH tunnels - Private Keys -- https://www.feralhosting.com/faq/view?question=238");
        return;
    }

    if ( message == '%kitty' || message == '%kitty' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Kitty - SSH - Private Keys - SSH tunnels -- https://www.feralhosting.com/faq/view?question=240");
        return;
    }
    
    if ( message == '%bitvise' || message == '%bitvise' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Bitvise - SSH - Private Keys - SSH tunnels - FTP to SFTP Bridge -- https://www.feralhosting.com/faq/view?question=239");
        return;
    }
    
    if ( message == '%quota' || message == '%quota' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Check your disk quota in SSH -- https://www.feralhosting.com/faq/view?question=221");
        return;
    }

    if ( message == '%sshfs' || message == '%sshfs' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Mount Your Server as a Local Filesystem - Windows - Dokan - win-sshfs -- https://www.feralhosting.com/faq/view?question=136");
        WikiBot.say(to, result + "Mount Your Server as a Local Filesystem - Linux -- https://www.feralhosting.com/faq/view?question=24");
        return;
    }
    
    // SFTP and FTP

    if ( message == '%slowftp' || message == '%slowftp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "What to do if FTP speeds are slow -- https://www.feralhosting.com/faq/view?question=28");
        WikiBot.say(to, result + "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    if ( message == '%winscp' || message == '%winscp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "WinSCP - usage - performing common tasks - creating torrents - unrar - symlinks and more -- https://www.feralhosting.com/faq/view?question=27");
        return;
    }

    if ( message == '%lftp' || message == '%lftp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "LFTP - Automated sync from seedbox to home -- https://www.feralhosting.com/faq/view?question=153");
        return;
    }
    
    if ( message == '%filezilla' || message == '%filezilla' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "FTP and SFTP basics - Filezilla -- https://www.feralhosting.com/faq/view?question=187");
        return;
    }

    if ( message == '%textediting' || message == '%textediting' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Text editing - Over FTP or SFTP -- https://www.feralhosting.com/faq/view?question=219");
        return;
    }

    if ( message == '%fxp' || message == '%fxp' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "How to move data between two servers in windows -- https://www.feralhosting.com/faq/view?question=68");
        return;
    }

    // HTTP

    if ( message == '%www' || message == '%www' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Putting your WWW folder to use -- https://www.feralhosting.com/faq/view?question=20");
        WikiBot.say(to, result + "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        return;
    }
    
    if ( message == '%forcehttps' || message == '%forcehttps' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Redirecting HTTP to HTTPS -- https://www.feralhosting.com/faq/view?question=161");
        return;
    }
    
    if ( message == '%pwprotect' || message == '%pwprotect' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Password protect your WWW folder -- https://www.feralhosting.com/faq/view?question=22");
        return;
    }
    
    if ( message == '%vhost' || message == '%vhost' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Host a virtual host on your Feral slot -- https://www.feralhosting.com/faq/view?question=52");
        return;
    }
    
    if ( message == '%Wordpress' || message == '%Wordpress' + result || message == '%wordpress' || message == '%wordpress' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Wordpress - Basic setup -- https://www.feralhosting.com/faq/view?question=211");
        return;
    }
    
    if ( message == '%pydio' || message == '%pydio' + result || message == '%Pydio' || message == '%Pydio' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Pydio - Basic setup -- https://www.feralhosting.com/faq/view?question=222");
        return;
    }
    
    if ( message == '%ajaxplorer' || message == '%ajaxplorer' + result || message == '%Ajaxplorer' || message == '%Ajaxplorer' + result || message == '%AjaXplorer' || message == '%AjaXplorer' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "This program has been rebranded as Pydio. Search for Pydio instead");
        return;
    }
    
    if ( message == '%nginx' || message == '%nginx' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Updating Apache to nginx -- https://www.feralhosting.com/faq/view?question=231");
        return;
    }

    if ( message == '%phpmyadmin' || message == '%phpmyadmin' + result || message == '%pma' || message == '%pma' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "phpmyadmin - MySQL Administration -- https://www.feralhosting.com/faq/view?question=230");
        return;
    }
    
    if ( message == '%phpbb3' || message == '%phpbb3' + result || message == '%phpBB3' || message == '%phpBB3' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "phpBB3 - basic setup -- https://www.feralhosting.com/faq/view?question=228");
        return;
    }
    
    if ( message == '%apache' || message == '%apache' + result || message == '%Apache' || message == '%Apache' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Apache - basics -- https://www.feralhosting.com/faq/view?question=214");
        return;
    }

    if ( message == '%php' || message == '%php' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "PHP - modify settings -- https://www.feralhosting.com/faq/view?question=213");
        return;
    }
    
    if ( message == '%Adminer' || message == '%Adminer' + result || message == '%adminer' || message == '%adminer' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Adminer - MySQL administration -- https://www.feralhosting.com/faq/view?question=116");
        return;
    }
    
    if ( message == '%owncloud' || message == '%owncloud' + result || message == '%Owncloud' || message == '%Owncloud' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Owncloud - Basic setup -- https://www.feralhosting.com/faq/view?question=249");
        return;
    }

    // Other Software
    
    if ( message == '%fileshare' || message == '%fileshare' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Rutorrent - Installing the fileshare plugin -- https://www.feralhosting.com/faq/view?question=210");
        return;
    }
    
    if ( message == '%ratiocolor' || message == '%ratiocolor' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Rutorrent - Colored Ratio Column Plugin -- https://www.feralhosting.com/faq/view?question=184");
        return;
    }
    
    if ( message == '%mediashare' || message == '%mediashare' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Rutorrent - Installing the mediashare plugin -- https://www.feralhosting.com/faq/view?question=209");
        return;
    }
    
    if ( message == '%tor' || message == '%tor' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Can I run a Tor node on my slot? -- https://www.feralhosting.com/faq/view?question=246");
        return;
    }

    if ( message == '%aria2c' || message == '%aria2c' + result || message == '%aria2' || message == '%aria2' + result || message == '%aria' || message == '%aria' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "aria2c -- https://www.feralhosting.com/faq/view?question=236");
        return;
    }

    if ( message == '%cygwin' || message == '%cygwin' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Cygwin - Linux tools on Windows -- https://www.feralhosting.com/faq/view?question=235");
        return;
    }
    
    if ( message == '%androidvpn' || message == '%androidvpn' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "OpenVPN - Connect on Android 4.0 and up - using OpenVPN Connect -- https://www.feralhosting.com/faq/view?question=220");
        return;
    }
    
    if ( message == '%xbmc' || message == '%xbmc' + result || message == '%XBMC' || message == '%XBMC' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "XBMC - connecting to shares -- https://www.feralhosting.com/faq/view?question=215");
        return;
    }
    
    if ( message == '%transdroid' || message == '%transdroid' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Using Transdroid to Control - rTorrent - Deluge - Transmission From Your Android Phone -- https://www.feralhosting.com/faq/view?question=81");
        return;
    }
    
    if ( message == '%thumbnails' || message == '%thumbnails' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "How do I make thumbnails of video files -- https://www.feralhosting.com/faq/view?question=170");
        return;
    }
    
    if ( message == '%minecraft' || message == '%minecraft' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Can I run a minecraft or similar game server on my slot? -- https://www.feralhosting.com/faq/view?question=168");
        return;
    }

    if ( message == '%remoteadder' || message == '%remoteadder' + result || message == '%rta' || message == '%rta' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Remote Torrent Adder - Adding torrents to your slot from Chrome -- https://www.feralhosting.com/faq/view?question=146");
        return;
    }

    if ( message == '%homebrew' || message == '%homebrew' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "OSX - Homebrew -- https://www.feralhosting.com/faq/view?question=262");
        return;
    }

    // Slot Plans

    if ( message == '%speedtest' || message == '%speedtest' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Testing the Speed of Your Server -- https://www.feralhosting.com/faq/view?question=48");
        return;
    }

    if ( message == '%bandwidth' || message == '%bandwidth' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Purchase Extra Bandwidth -- https://www.feralhosting.com/manager/bandwidth");
        return;
    }

    // Software
    
    if ( message == '%multirtorrent' || message == '%multirtorrent' + result || message == '%multirutorrent' || message == '%multirutorrent' + result || message == '%multiru' || message == '%multiru' + result || message == '%multirt' || message == '%multirt' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Multiple instances - rtorrent and rutorrent -- https://www.feralhosting.com/faq/view?question=244");
        return;
    }
    
    if ( message == '%multideluge' || message == '%multideluge' + result || message == '%multid' || message == '%multid' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Deluge - Running more than one Deluge webUI -- https://www.feralhosting.com/faq/view?question=216");
        WikiBot.say(to, result + "Deluge - Running more than one instance -- https://www.feralhosting.com/faq/view?question=197");
        return;
    }

    if ( message == '%subsonic' || message == '%subsonic' + result || message == '%Subsonic' || message == '%Subsonic' + result || message == '%madsonic' || message == '%madsonic' + result || message == '%Madsonic' || message == '%Madsonic' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Subsonic 4.8 or Madsonic 5.0 -- https://www.feralhosting.com/faq/view?question=159");
        return;
    }

    if ( message == '%ampache' || message == '%ampache' + result || message == '%Ampache' || message == '%Ampache' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Ampache - web based audio video streaming -- https://www.feralhosting.com/faq/view?question=152");
        return;
    }

    if ( message == '%icecast' || message == '%icecast' + result || message == '%Icecast' || message == '%Icecast' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Icecast - streaming media server -- https://www.feralhosting.com/faq/view?question=155");
        return;
    }

    if ( message == '%proftpd' || message == '%proftpd' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "proftpd - Installing an FTP daemon for extra accounts -- https://www.feralhosting.com/faq/view?question=193");            
        return;
    }
    
    if ( message == '%autodl' || message == '%autodl' + result || message == '%auto-dl' || message == '%auto-dl' + result || message == '%autodl-irssi' || message == '%autodl-irssi' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Autodl-irssi and rutorrent plugin - community edition -- https://www.feralhosting.com/faq/view?question=142");
        return;
    }
    
    if ( message == '%autodlinstall' || message == '%autodlinstall' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Install it: wget -qO ~/installautodl.sh http://git.io/Ch0LqA && bash ~/installautodl.sh");
        return;
    }
    
    if ( message == '%autodlfix' || message == '%autodlfix' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Fix it: wget -qO ~/autodlrutorrentfix.sh http://git.io/BBUryw && bash ~/autodlrutorrentfix.sh");
        return;
    }
    
    if ( message == '%autodlport' || message == '%autodlport' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Change Port and password: wget -qO ~/autodlport.sh http://git.io/vCft_Q && bash ~/autodlport.sh");
        return;
    }

    if ( message == '%java' || message == '%Java' + result || message == '%Java' || message == '%java' + result || message == '%jre' || message == '%jre' + result || message == '%JRE' || message == '%JRE' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Java 1.7 -- https://www.feralhosting.com/faq/view?question=183");            
        return;
    }

    if ( message == '%dropbox' || message == '%dropbox' + result || message == '%Dropbox' || message == '%Dropbox' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Dropbox - How to install -- https://www.feralhosting.com/faq/view?question=205");            
        return;
    }

    if ( message == '%p7zip' || message == '%p7zip' + result || message == '%7za' || message == '%7za' + result || message == '%7z' || message == '%7z' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "p7zip - basic installation -- https://www.feralhosting.com/faq/view?question=245");            
        return;
    }

    if ( message == '%btsync' || message == '%btsync' + result || message == '%BTsync' || message == '%BTsync' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "BitTorrent Sync btsync - basic setup -- https://www.feralhosting.com/faq/view?question=224");            
        return;
    }

    if ( message == '%software' || message == '%software' + result || message == '%Software' || message == '%Software' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Generic software install guide -- https://www.feralhosting.com/faq/view?question=195");            
        return;
    }

    if ( message == '%Yoink!' || message == '%Yoink!' + result || message == '%Yoink' || message == '%Yoink' + result || message == '%yoink!' || message == '%yoink!' + result || message == '%yoink' || message == '%yoink' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Yoink! The What.cd Freeleech Torrent Grabber -- https://www.feralhosting.com/faq/view?question=251");            
        return;
    }
    
    if ( message == '%whatfreegrab' || message == '%whatfreegrab!' + result || message == '%wfg' || message == '%wfg' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "WhatFreeGrab - Basic usage -- https://www.feralhosting.com/faq/view?question=259");            
        return;
    }
    
    if ( message == '%weechat' || message == '%weechat' + result || message == '%WeeChat' || message == '%WeeChat' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "WeeChat - an IRC Client - Basic Setup -- https://www.feralhosting.com/faq/view?question=250");            
        return;
    }

    if ( message == '%node' || message == '%node' + result || message == '%node.js' || message == '%node.js' + result || message == '%nodejs' || message == '%nodejs' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "node.js - How to install -- https://www.feralhosting.com/faq/view?question=199");            
        return;
    }

    if ( message == '%spideroak' || message == '%spideroak' + result || message == '%Spideroak' || message == '%Spideroak' + result || message == '%SpiderOak' || message == '%SpiderOak' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "SpiderOak -- https://www.feralhosting.com/faq/view?question=203");            
        return;
    }
    
    if ( message == '%AeroFS' || message == '%AeroFS' + result || message == '%aerofs' || message == '%aerofs' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "AeroFS - How to install -- https://www.feralhosting.com/faq/view?question=207");            
        return;
    }
    
    if ( message == '%duplicity' || message == '%duplicity' + result || message == '%Duplicity' || message == '%Duplicity' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Duplicity - Basic Setup -- https://www.feralhosting.com/faq/view?question=255");            
        return;
    }
    
    if ( message == '%cmake' || message == '%cmake' + result || message == '%CMAKE' || message == '%CMAKE' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "CMAKE - Basic Setup -- https://www.feralhosting.com/faq/view?question=270");            
        return;
    }
    
    if ( message == '%curl' || message == '%curl' + result || message == '%Curl' || message == '%Curl' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Curl - Basic Setup -- https://www.feralhosting.com/faq/view?question=267");            
        return;
    }
    
    if ( message == '%imagegagick' || message == '%imagegagick' + result || message == '%ImageMagick' || message == '%ImageMagick' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "ImageMagick - Basic Setup -- https://www.feralhosting.com/faq/view?question=266");            
        return;
    }
    
    if ( message == '%mosh' || message == '%mosh' + result || message == '%Mosh' || message == '%Mosh' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Mosh - Basic Setup -- https://www.feralhosting.com/faq/view?question=269");            
        return;
    }
    
    if ( message == '%ruby' || message == '%ruby' + result || message == '%Ruby' || message == '%Ruby' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Ruby - Basic Setup -- https://www.feralhosting.com/faq/view?question=265");            
        return;
    }
    
    if ( message == '%znc' || message == '%znc' + result || message == '%ZNC' || message == '%ZNC' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "ZNC - Basic Setup -- https://www.feralhosting.com/faq/view?question=264");            
        return;
    }
    
    if ( message == '%ffmpeg' || message == '%ffmpeg' + result || message == '%FFmpeg' || message == '%FFmpeg' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "ffmpeg - Basic Setup -- https://www.feralhosting.com/faq/view?question=268");            
        return;
    }
	
    if ( message == '%ghost' || message == '%ghost' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Ghost Blogging Platform -- https://www.feralhosting.com/faq/view?question=276");            
        return;
    }
	
    if ( message == '%etherpad' || message == '%etherpad' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "etherpad-lite -- https://www.feralhosting.com/faq/view?question=277");            
        return;
    }
    
    if ( message == '%couchpotato' || message == '%couchpotato' + result || message == '%Couchpotato' || message == '%Couchpotato' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "CouchPotato - An automatic NZB and torrent downloader for Films -- https://www.feralhosting.com/faq/view?question=218");
        return;
    }
    
    if ( message == '%syncthing' || message == '%syncthing' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Syncthing - Basic Setup -- https://www.feralhosting.com/faq/view?question=285");            
        return;
    }
	
    // Linux

    if ( message == '%rsync' || message == '%rsync' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "rsync - Transferring data from slot to slot -- https://www.feralhosting.com/faq/view?question=117");
        return;
    }

    if ( message == '%irssi' || message == '%irssi' + result || message == '%Irssi' || message == '%Irssi' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "irssi - connect to the Feral IRC from your slot -- https://www.feralhosting.com/faq/view?question=232");
        return;
    }

    if ( message == '%ip' || message == '%ip' + result || message == '%IP' || message == '%IP' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Find your IP address in the Shell -- https://www.feralhosting.com/faq/view?question=74");
        return;
    }

    if ( message == '%timezone' || message == '%timezone' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Timezone - How to configure -- https://www.feralhosting.com/faq/view?question=77");
        return;
    }

    if ( message == '%screen' || message == '%screen' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Using the Screen Command -- https://www.feralhosting.com/faq/view?question=16");
        return;
    }
    
    if ( message == '%poweriso' || message == '%poweriso' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Extracting ISOs without mounting the image -- https://www.feralhosting.com/faq/view?question=141");
        return;
    }
    
    if ( message == '%rar' || message == '%rar' + result ||  message == '%unrar' || message == '%unrar' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Using rar and unrar in Command Line - with examples -- https://www.feralhosting.com/faq/view?question=36");
        WikiBot.say(to, result + "Unrar - How to Install a Newer Version -- https://www.feralhosting.com/faq/view?question=280");
        return;
    }
    
    if ( message == '%sfv' || message == '%sfv' + result ||  message == '%md5' || message == '%md5' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Creating and Checking SFV or MD5 Hash Files -- https://www.feralhosting.com/faq/view?question=49");
        return;
    }
    
    if ( message == '%FileBot' || message == '%FileBot' + result ||  message == '%filebot' || message == '%filebot' + result || message == '%Filebot' || message == '%Filebot' + result) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "FileBot CLI - Basic Setup -- https://www.feralhosting.com/faq/view?question=256");
        return;
    }
    
    // other

    if ( message == '%email' || message == '%email' + result  || message == '%Interxion' || message == '%Interxion' + result || message == '%interxion' || message == '%interxion' + result || message == '%moving' || message == '%moving' + result || message == '%fibre' || message == '%fibre' + result || message == '%fiber' || message == '%fiber' + result ) {
        if ( result !== '' ) { var result = result + ': '; }
        
        WikiBot.say(to, result + "Moving to Interxion -- https://www.feralhosting.com/email/moving-to-interxion.html");
        WikiBot.say(to, result + "Moving to Interxion on the 19th November 2013 -- https://www.feralhosting.com/email/moving-to-interxion-2.html");
        return;
    }

    if ( message == '%twitter' || message == '%twitter' + result || message == '%Twitter' || message == '%Twitter' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Feralhosting on Twitter -- https://twitter.com/feralstatus");
        return;
    }
    
    if ( message == '%ticket' || message == '%ticket' + result || message == '%Ticket' || message == '%Ticket' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Open a Ticket -- https://www.feralhosting.com/manager/tickets/new");
        return;
    }
    
    if ( message == '%contact' || message == '%contact' + result || message == '%Contact' || message == '%Contact' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "About us Page -- https://www.feralhosting.com/about/");
        return;
    }
    
    if ( message == '%abuse' || message == '%abuse' + result || message == '%Abuse' || message == '%Abuse' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "Report abuse to this email, we understand you might be frustrated but please be polite. -- report-abuse@feralhosting.com");
        return;
    }
    
    if ( message == '%moveslot' || message == '%moveslot' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + c.green('1: ') + 'Purchase the slot from our website. ' + c.green('2: ') + 'Wait until you receive the slot. ' + c.green('3: ') + 'Then open a ticket requesting a data transfer ' + c.olive('(optional) ') + c.green('4: ') + 'Request a refund on your current slot ' + c.olive('(optional) '));
        return;
    }
	
    if ( message == '%status' || message == '%status' + result ) {
        if ( result !== '' ) { var result = result + ': '; }

        WikiBot.say(to, result + "http://status.feral.io/");
        return;
    }
}); 

// End of triggers

// Help section

WikiBot.addListener('message', function(from, to, message) {

	if ( message.substring(0,5) == '%help' ) {
    
		if ( message.length < 6 ) {
			WikiBot.say(to, "Use %help with one of these: general installable ssh ftp http other slots software linux generic ");
			return;
		}
        
        if ( message.indexOf('general') >= 0 ) {
          WikiBot.say(to, "%activated %activated1 %activated2 %common %pwchange %transfer %useful %edit %upgrade %late ");
          return;
        }
        
        if ( message.indexOf('installable') >= 0 ) {
          WikiBot.say(to, "%install %rtorrentv %uninstall %restart %rutorrent %deluge %transmission %delugethin %rtorrent %vpn %rssfeeds %pausing %feralstats %mysql %changeclient %delugeplugins");
          return;
        }
        
        if ( message.indexOf('ssh') >= 0 ) {
          WikiBot.say(to, "%ssh %sshpc %sshosx %tunnel %tunnelpc %tunnelosx %usetunnel %xshell %kitty %sshfs %quota %publickey %tunnel %myentunnel %pageant %bitvise");
          return;
        }
        
        if ( message.indexOf('ftp') >= 0 ) {
          WikiBot.say(to, "%slowftp %winscp %lftp %filezilla %textediting %fxp");
          return;
        }
        
        if ( message.indexOf('http') >= 0 ) {
          WikiBot.say(to, "%www %forcehttps %pwprotect %vhost %Wordpress %pydio %ajaxplorer %nginx %phpmyadmin %phpbb3 %apache %php %Adminer %owncloud");
          return;
        }
        
        if ( message.indexOf('other') >= 0 ) {
          WikiBot.say(to, "%fileshare %ratiocolor %mediashare %tor %aria2c %cygwin %androidvpn %xbmc %transdroid %thumbnails %minecraft %remoteadder %homebrew %speedtest %bandwidth");
          return;
        }
        
        if ( message.indexOf('slots') >= 0 ) {
          WikiBot.say(to, "%speedtest %bandwidth");
          return;
        }
        
        if ( message.indexOf('software') >= 0 ) {
          WikiBot.say(to, "%multirtorrent %multideluge %subsonic %ampache %icecast %proftpd %autodl %autodlinstall %autodlfix %autodlport %java %dropbox %p7zip %btsync %software %yoink! %whatfreegrab %weechat %node %spideroak %aerofs %duplicity %cmake %curl %imagemagick %mosh %ruby %znc %ffmpeg %ghost %etherpad %syncthing");
          return;
        }
        
        if ( message.indexOf('linux') >= 0 ) {
          WikiBot.say(to, "%rsync %irssi %ip timezone %screen %poweriso %unrar %sfv");
          return;
        }
        
        if ( message.indexOf('generic') >= 0 ) {
          WikiBot.say(to, "%email %twitter %ticket %contact %abuse '%moveslot %status");
          return;
        }
    }
});

// End of help section

// Console stuff and error reporting

WikiBot.addListener('message', function (from, to, message) {
    console.log(from + ' => ' + to + ': ' + message);
});

WikiBot.addListener('error', function(message) {
    console.log('error: ', message);
});

WikiBot.addListener('netError', function(error) {
  console.log('netError: ' + error);
});