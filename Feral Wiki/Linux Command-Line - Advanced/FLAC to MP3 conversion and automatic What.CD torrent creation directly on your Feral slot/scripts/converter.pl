#!/usr/bin/perl -w
use strict;
use warnings;
use File::Basename;
use Getopt::Long;

#########################################################
# Flac to Mp3 Perl Converter - Terminal Edition
# Created by: Somnorific
# Based on: Scripts by Falkano and Nick Sklaventitis
# Date: June 26, 2008
# Edited by: mlapaglia
# Format Selection & m3u Output by: Gravey
# Date: June 1, 2009
#
# Requires: perl, zenity, flac, lame, and rsync
# Tested on: Ubuntu (Hardy x86 and Intrepid x64)
#########################################################
# Configuration
# 1 = true, 0 = false
#########################################################
# Do you always want to move additional files (.jpg, .log, etc)? (disables the prompt)
my $move_other = 1;
#
# If you want a different default folder, enter it in quotes. ("/home/mlapaglia/Desktop/")
my $defaultOutput_folder = "";
#
# Do you want to use FLAC tags for naming the output files? (please note that conversion will fail if tags are not present in the original .flac files you're converting from)
my $fileName_choice = 1;
#
# Do you want to create an m3u file?  (requires FLAC tags)
my $make_m3u = 0;
#
# Do you want track numbers (in the filenames and tags) to be 01, 02, 03, 04 instead of 1, 2, 3, 4?
my $numberName_choice = 1;
#
# Do you want to generate a .torrent file? (requires mktorrent 0.9.9)
# Place passkey in quotes, and the output directory for the .torrent file in quotes ("/home/username/converted_files/")
my $torrent_passkey = "qi3t5dwsdsdfewwesdfwqq33i7oa5odsy8";
my $torrent_output_directory = "/home/YOUR_USERNAME/private/rtorrent/data/";
#
# List of default encoding options, add to this list if you want more
my %lameOptions = (
	"320" => ["-b 320 --ignore-tag-errors", ''],
	"V0"  => ["-V 0 --vbr-new --ignore-tag-errors", ''],
	"V2"  => ["-V 2 --vbr-new --ignore-tag-errors", '']
);
#########################################################
#End of configuration
#########################################################
my $use_320 = 0;
my $use_v0 = 0;
my $use_v2 = 0;

# Retrieve command line arguments
GetOptions('320' => \$use_320, 'v0' => \$use_v0, 'v2' => \$use_v2);

# Check if specific formats were selected
if ($use_320 || $use_v0 || $use_v2) {
	
	# clear default encoder settings
	%lameOptions = ();
	
	# add specified settings to array
	if ($use_320) {
		$lameOptions{320} = ["-b 320 --ignore-tag-errors", ''];
	}
	if ($use_v0) {
		$lameOptions{V0} = ["-V 0 --vbr-new --ignore-tag-errors", ''];
	}
	if ($use_v2) {
		$lameOptions{V2} = ["-V 2 --vbr-new --ignore-tag-errors", ''];
	}
}

my $numArgs = $#ARGV;
my $flac_dir = '';
if ($numArgs == -1) {
	print "Need FLAC file parameter\n";
	exit 0;
}
foreach $numArgs ($#ARGV) {
	$flac_dir = $ARGV[$numArgs];
}
# get rid of trailing slash if present
$flac_dir =~ s/\/$//;
# create folders, either using default output folder, or user chosen
foreach my $lame_option (keys %lameOptions) {
	my $mp3_dir = '';
	my $flac_dir_proper = $flac_dir;
	# Try and remove ([{FLAC}]) and ([{what.cd}]) variations
	$flac_dir_proper =~ s/[\||\(|\[|\{| \|| \(| \[| \{]+[what.cd|FLAC]+[\}|\]|\)]//gi;
	if ($defaultOutput_folder eq '') {
		$mp3_dir = $flac_dir_proper . " ($lame_option)";
	} else {
		$mp3_dir = $defaultOutput_folder . fileparse($flac_dir_proper) . " ($lame_option)";
	}
	`mkdir "$mp3_dir"`;
	$lameOptions{ $lame_option }[1] = $mp3_dir;
}

# Gather all of the flac files
print "$flac_dir\n";
opendir(DIR, $flac_dir);
my @files = grep(/\.flac$/,readdir(DIR));
closedir(DIR);

my $output_name = "";
# Loop through each of the encodings chosen
for my $lame_option ( keys %lameOptions ) {
	print "\nEncoding with $lame_option started...\n";

	# Pull out the directories and flags from the array
	my @mp3_arry = @{$lameOptions{$lame_option}};
	my $mp3_dir = $mp3_arry[1];
	my $lame_flags = $mp3_arry[0];

	# Loop through each of the FLAC files
	foreach my $file (@files) {
		# Grab the tag info from the FLAC, if configured
		my %flac_tags = ('TITLE','','ALBUM','','ARTIST','','TRACKNUMBER','','GENRE','','COMMENT','','DATE','');
		for my $tag ( keys %flac_tags ) {
			$flac_tags{ $tag } = `metaflac --show-tag=$tag "$flac_dir/$file" | awk -F = '{ printf(\$2) }'`;
			# Remove :'s and ?'s
			$flac_tags{ $tag } =~ s/[:,?,\/]/-/g;
		}
	
		# Add a '0' to the track number if needed, if configured
		if ($numberName_choice && $flac_tags{'TRACKNUMBER'} && $flac_tags{'TRACKNUMBER'} < 10 && substr($flac_tags{'TRACKNUMBER'}, 0, 1) != 0) {
			$flac_tags{'TRACKNUMBER'} = "0$flac_tags{'TRACKNUMBER'}";
		}

		# Create the destination mp3 filename using the FLAC tags, if configured
		# exit if the FLAC tags are not populated
		my $mp3_filename = '';
		if ($fileName_choice && $flac_tags{'TRACKNUMBER'} && $flac_tags{'TITLE'}) {
			$mp3_filename = `basename "$flac_tags{'TRACKNUMBER'} - $flac_tags{'TITLE'}" .flac`;
		} else {
			print "\n****FLAC TAG ERROR: NO TAGS DETECTED****";
			print "\nEither the files are incomplete or they are missing tags";
			print "\nTag the FLAC music correctly then re-attempt transcoding\n";
			exit 0;
		}
		chomp($mp3_filename);
		$mp3_filename = $mp3_dir."/".$mp3_filename.".mp3";
		# Build the conversion script and do the actual conversion
		my $flac_command = "flac -dc \"$flac_dir/$file\" | lame $lame_flags " .
			"--tt \"" . $flac_tags{'TITLE'} . "\" " .
			"--tl \"" . $flac_tags{'ALBUM'} . "\" " .
			"--ta \"" . $flac_tags{'ARTIST'} . "\" " .
			"--tn \"" . $flac_tags{'TRACKNUMBER'} . "\" " .
			"--tg \"" . $flac_tags{'GENRE'} . "\" " .
			"--ty \"" . $flac_tags{'DATE'} . "\" " .
			"--add-id3v2 - \"$mp3_filename\" 2>&1";
		`$flac_command`;
		$output_name = "$flac_tags{'ARTIST'} - $flac_tags{'ALBUM'}";
	}

	# Create m3u file, if configured
	if ($make_m3u) {
		print "\nCreating m3u file...\n";
		my $playlist = "$mp3_dir/$output_name.m3u";
		open(FILE,'>',$playlist);
		opendir(DIR,"$mp3_dir");
		my @files = grep(/\.mp3$/,readdir(DIR));
		closedir(DIR);
		select(FILE);
		foreach my $file (@files) {
			print "$file\n";
		}
		select(STDOUT);
		close(FILE);
	}
	
	print "\nEncoding with $lame_option finished...\n";

	# Move over any other files using rsync
	if ($move_other) {
		my $rsync_comm = "rsync -a --exclude \"*.flac\" --exclude \"*.log\" \"$flac_dir/\" \"$mp3_dir/\"";
		`$rsync_comm`;
	}

	# Create .torrent file with what.cd parameters, if tags are present, if configured by user
	if($torrent_output_directory ne '') {
		print "\nCreating torrent...\n";
		my $torrent_create = "mktorrent -a http://tracker.what.cd:34000/$torrent_passkey/announce -p -o \"$torrent_output_directory$output_name ($lame_option).torrent\" \"$mp3_dir\"";
		`$torrent_create`;
		print "'$torrent_create'";
	}
}
print "\nAll Done...\n";