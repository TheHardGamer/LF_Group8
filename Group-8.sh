#!/bin/bash

#Script to scan storage for music and create a playlist and play it using mplayer/audacious
#Shift 1, Track 2

#Group -8: Varun Vaishnav, Vandit Prajapati, Vivek Vagheswari, Ved Bhonsle, Yash Jain, Kartheek Ikkurthi
#Shaswat Shah, Shivam Pandey


read -p "Enter 1 if to install/play using audacious or 2 to use mplayer" player

function scan() {
#Scan /home and /media for mp3s and output it to playlist.m3u, and redirect errors to /dev/null
find /home /media -iname '*.mp3' -print > playlist.m3u 2>/dev/null;

#Cat the playlist
cat playlist.m3u; 
}

function installplayer() {
	#Check if selected player is installed
	if [ ! -f /usr/bin/"$player" ];
	then
		echo "$player isn't installed, installing..";
		sudo apt-get update;
		sudo apt install "$player";
	fi;
}

case $player in
1)
	#Assign player as audacious and call installplayer
	player=audacious;
	installplayer;

	echo "Audacious found!, scanning storage for mp3s";

	scan;

	#Play the playlist using audacious
	audacious --play playlist.m3u;
	exit 0;
	;;
2)
	player=mplayer
	installplayer;

	echo "Mplayer found!, scanning storage for mp3s";

	scan;

	#Play the playlist using mplayer
	mplayer -playlist playlist.m3u;
	exit 0;
	;;
esac
