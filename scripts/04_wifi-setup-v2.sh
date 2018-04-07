#!/bin/sh

#======================================================
# b43 this is working better than broadcom-wl-dkms
#======================================================

# Guide for broadcom chip on laptop https://wiki.archlinux.org/index.php/Broadcom_wireless
# Another guide https://wiki.archlinux.org/index.php/Netctl
# Another guide https://wiki.archlinux.org/index.php/WPA_supplicant

echo "########## SETUP OF WIRELESS NETWORK ##########"
echo "########## Installing required packages..."
pacman -S dialog wpa_supplicant ifplugd
echo "########## Installing AUR package b43-firmware for the Broadcom Wireless Chipset on the MBP..."
git clone https://aur.archlinux.org/b43-firmware.git
cd b43-firmware
makepkg -sci

echo "########## Checking the name of the wireless and wired interfaces..."
ip link
echo "########## Write the wireless interface:"
read wlint
echo "########## Write the wired interface:"
read wdint

echo "########## Setup of wireless access point..."
echo "########## Introduce your SSID (wifi name):"
read myssid
echo "########## Introduce your wifi password:"
read passphrase
echo "########## Creating config files with wpa_passphrase..."
sudo wpa_passphrase $myssid $passphrase > /etc/wpa_supplicant/wpa_supplicant-$wlint.conf
echo "########## Protecting config file..."
sudo chmod 700 /etc/wpa_supplicant//wpa_supplicant-$wlint.conf

echo "########## Enabling systemd service to start at boot..."
echo "########## Guide at https://wiki.archlinux.org/index.php/WPA_supplicant#At_boot_.28systemd.29"
sudo systemctl enable wpa_supplicant@$wlint.service
echo "########## Starting wifi connection..."
sudo systemctl start wpa_supplicant@$wlint.service

echo "########## Enabling the ifplugd service for wired interface..."
systemctl enable netctl-ifplugd@$wdint.service
