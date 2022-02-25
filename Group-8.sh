#!/bin/bash

#Script to scan storage for music and create a playlist and play it using mplayer/vlc
#Shift 1, Track 2

#Group -8: Varun Vaishnav, Vandit Prajapati, Vivek Vagheswari, Ved Bhonsle, Yash Jain, Kartheek Ikkurthi
#Shaswat Shah, Shivam Pandey


read -p "Enter 1 if to install/play using vlc media player or 2 to use mplayer" player

function scan() {
#Scan /home and /media for mp3s and output it to playlist.m3u, and redirect errors to /dev/null
find /home /media -iname '*.mp3' > playlist.m3u 2>/dev/null;
}

function installplayer() {
	#Check if selected player is installed
	if [ ! -f /usr/bin/$player ];
	then
		echo "$player isn't installed, installing..";
		sudo apt install $player;
	fi;
}

case $player in
1)
	#Assign player as vlc and call installplayer
	player=vlc;
	installplayer;

	echo "VLC found!, scanning storage for mp3s";

	scan;

	#Play the playlist using VLC
	vlc playlist.m3u;
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
