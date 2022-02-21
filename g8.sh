#!/bin/bash
#Script to scan storage for music and create a playlist and play it using mplayer

#Check if mplayer is installed
if [ ! -f /usr/bin/mplayer ];
then
	echo "Mplayer isn't installed, installing..";
	sudo apt install mplayer;
fi;

echo "Mplayer found!, scanning storage for mp3s";

#Scan /home for mp3s and output it to playlist,m3u
find /home -iname '*.mp3' > playlist.m3u;

#Play the playlist using mplayer
mplayer -playlist playlist.m3u
exit 0
