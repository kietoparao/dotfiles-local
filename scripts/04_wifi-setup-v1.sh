#!/bin/sh

# Guide for broadcom chip on laptop https://wiki.archlinux.org/index.php/Broadcom_wireless

# Another guide https://wiki.archlinux.org/index.php/Netctl
echo "########## SETUP OF WIRELESS NETWORK ##########"
echo "########## Installing required packages..."
pacman -S dialog wpa_supplicant ifplugd
echo "########## Installing broadcom-wl-dkms for the Broadcom Wireless Chipset on the MBP..."
pacman -S broadcom-wl-dkms

echo "########## Checking the name of the wireless and wired interfaces..."
ip link
echo "########## Write the wireless interface:"
read wlint
echo "########## Write the wired interface:"
read wdint

echo "########## Setup of wireless access point..."
wifi-menu -o
echo "########## Write the name you just saved as a profile:"
read wifiprofile
ip link set $wlint down
echo "########## Starting the wifi..."
netctl start $wifiprofile

echo "########## Enabling the ifplugd service for wired interface..."
systemctl enable netctl-ifplugd@$wdint.service
