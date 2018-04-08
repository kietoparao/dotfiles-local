#!/bin/sh
echo "########## Installing alsa-utils package..."
pacman -S alsa-utils

echo "########## Unmuting system..."
amixer sset Master unmute

echo "########## Set volume to  100%..."
amixer sset 'Master' 100%

echo "########## Channels setup (use 'm' to mute/unmute the channels..."
alsamixer
