#!/bin/bash
# This script outputs the available quota in a nice format.
#
# requirements: a file called .quotaspace in home directory
# which contains the available diskspace in MB's, for example: 750000 for 750 GB
#
# Credits:
# Written by: mcviruss
# Contributions:
# https://github.com/feralhosting/feralfilehosting/pull/5
#
# Pad a string so that it is the specified number of characters long
# adds padding to the left, default path string is a space " "
function pad_left() {
	input="$1";
	length="$2";
	pad_str="$3";
	if [ "$pad_str" == "" ]; then
		pad_str=" ";
	fi;
	if [ "${#input}" -lt "$length" ]; then
		for i in $(seq 1 $[length-${#input}]); do
			echo -n "$pad_str";
		done;
	fi;
	echo -n "$input";
}

# Format a filesize
# Input: number which represents MB's
# Output: formatted filesize with 2 decimals, example: 10.50 MB
function format_filesize() {
    if [ "$1" == "" ]; then
            awk '{x=$1;split("MB GB TB PB",type);for(i=5;y < 1;i--) { y = x / (10^(3*i)) }; printf "%.2f %s\n",y,type[i+2]; }';
    else
            echo "$1" | awk '{x=$1;split("MB GB TB PB",type);for(i=5;y < 1;i--) { y = x / (10^(3*i)) }; printf "%.2f %s\n",y,type[i+2]; }';
    fi;
}

# Lookup used diskspace and available diskspace
used=$(du -s --si -B 1MB $HOME/ | cut -f 1);
quota=$(cat ~/.quotaspace);
available=$(echo "$quota-$used" | bc );
exceeded=$(echo "$used-$quota" | bc );

# Format results
quota_fmt=$(echo "$quota" | format_filesize );
used_fmt=$(echo "$used" | format_filesize );
available_fmt=$(echo "$available" | format_filesize);
if [ "$available" -lt "0" ]; then
        exceeded_fmt=$(echo "$exceeded" | format_filesize );
else
        available_fmt=$(echo "$available" | format_filesize);
fi;

# Output results

# Format header in purple with bold and underlined text
echo -e "\033[1;35;4mDisk usage for user $(whoami)@$(hostname -f)\e[0m";

# Format first part as bold with cyan text
echo -e "\033[36;1mHome:\e[00m       $HOME";
echo -e "\033[36;1mQuota:\e[00m $(pad_left "$quota_fmt" 17)";
echo -e "\033[36;1mUsed:\e[00m $(pad_left "$used_fmt" 18)";

# Check if you are under or over your available diskspace
if [ "$available" -lt "0" ]; then
	# Format amount in red
	echo -e "\033[36;1mExceeded by:\e[00m \e[00;31m$(pad_left "$exceeded_fmt" 11)\e[00m";
else
	# Format amount in green
	echo -e "\033[36;1mAvailable:\e[00m \e[00;32m$(pad_left "$available_fmt" 13)\e[00m";
fi;
