#!usr/bin/perl

use File::Find;
use File::Path;
use File::Copy;
use Cwd;

#all variables are global

#converts flac to mp3 and copies image files
#works through directory tree from base directory supplied
#creating a new directory tree appended with quality
#path must be in quotes if contains spaces


if($ARGV[1] =~ m/320|256|224|192|160|128/){$quality = '-b'.$ARGV[1];}
elsif($ARGV[1] =~ m/v0|V0|vo|VO/){$quality = '-V0';}
elsif($ARGV[1] =~ m/v2|V2/){$quality = '-V2';}
else{die "BITRATE NOT SUPPORTED\n";}

START:
#get base directory
$base = $ARGV[0];

#remove any trailing / or \
$base =~ s/\\$|\/$//;

#create base for new directory tree
$newbase = $base.' ['.$ARGV[1].']';
my $root = getcwd;
mkpath($newbase);

#work through files in directory tree
find(\&search_tree, $base);

print "\nCONVERSION COMPLETE\n\n";
# END OF PROGRAM


sub search_tree{
       
       next if(-d $_);

       $sourcefile = $File::Find::name;
       $dir = $File::Find::dir;
       $file = $_;
	   $sourcefile = $root.'/'.$sourcefile;
       $dir =~ s/\Q$base$/$newbase/;
       if ($sourcefile =~ m/\.flac/){&convert;}
       elsif ($sourcefile =~ m/\.jpg$|\.jpeg$|\.png$|\.gif$/){&copyfile;}}

sub copyfile{
	unless (-e $dir){ mkpath ( $dir);}
	$newfile = $dir . '/' . $file;
	copy($sourcefile , $newfile);}

sub convert{
	unless (-e $root.'/'.$newbase.'/'.$dir)	{ mkpath ($root.'/'.$newbase.'/'.$dir); }

	#remove .flac extension
	$file =~ s/\.flac$//;
	
	#flac destination filename
	$flac_dest = $root.'/'.$newbase . '/'.$dir.'/' . $file;
	
	# get tags for lame	
	$track="";	if ($track = `metaflac --show-tag tracknumber "$sourcefile"`){ chomp $track; $track =~ s/.*=//;}
	$title="";	if ($title = `metaflac --show-tag title "$sourcefile"`){ chomp $title; $title =~ s/.*=//;}
	$artist="";	if ($artist = `metaflac --show-tag artist "$sourcefile"`){ chomp $artist; $artist =~ s/.*=//;}
	$album="";	if ($album = `metaflac --show-tag album "$sourcefile"`){ chomp $album; $album =~ s/.*=//;}
	$date="";	if ($date = `metaflac --show-tag date "$sourcefile"`){ chomp $date; $date =~ s/.*=//;}
	$genre="";	if ($genre = `metaflac --show-tag genre "$sourcefile"`){ chomp $genre; $genre =~ s/.*=//;}

	$track =~ s/\"/\"\"/g;
	$title =~ s/\"/\"\"/g;
	$artist =~ s/\"/\"\"/g;
	$album =~ s/\"/\"\"/g;
	$date =~ s/\"/\"\"/g;
	$genre =~ s/\"/\"\"/g;
	
	# decode flac to wav - overwrite existing
	# to decode through errors add -F to options
	# specifying destination filename to avoid .wav extension
	system ("flac -d -f -o \"$flac_dest\" \"$sourcefile\""); 

	#lame command for mp3 conversion
	system ("lame $quality --noreplaygain --add-id3v2 --pad-id3v2 --ignore-tag-errors --tn $track --tt \"$title\" --ta \"$artist\" --tl \"$album\" --ty \"$date\" --tg \"$genre\" \"$flac_dest\"");

	# delete temporary wav file
	unlink($flac_dest);}