#!/bin/sh
echo "########## Installing ufw Firewall..."
pacman -S ufw
ufw default deny
ufw allow from 192.168.0.0/24
ufw allow Transmission
ufw allow Dropbox
ufw allow SSH
ufw limit SSH
ufw enable
echo "########## Enabling ufw at startup..."
systemctl enable ufw.service
echo "########## Checking ufw status..."
ufw status
