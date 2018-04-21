#!/bin/sh

# Guide for broadcom chip https://wiki.archlinux.org/index.php/Broadcom_wireless
# Another guide https://wiki.archlinux.org/index.php/Netctl

echo "########## SETUP OF WIRELESS NETWORK ##########"
echo "########## Installing required packages..."
pacman -S dialog wpa_supplicant ifplugd
echo "########## Installing broadcom-wl-dkms for the Broadcom Wireless Chipset on the MBP..."
pacman -S broadcom-wl-dkms

echo "########## Removing conflicting kernel modules and loading wl module..."
echo "########## (these steps can be omitted if you just reboot the computer)"
sudo rmmod b43 b43legacy bcm43xx bcma brcm80211 brcmfmac brcmsmac ssb wl
sudo modprobe wl

echo "########## Checking the name of the wireless and wired interfaces..."
ip link    # OR 'lspci -vnn -d 14e4:'
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
sudo wpa_passphrase $myssid $passphrase >> /etc/wpa_supplicant/wpa_supplicant-$wlint.conf
echo "########## Protecting config file..."
sudo chmod 700 /etc/wpa_supplicant//wpa_supplicant-$wlint.conf

echo "########## Enabling systemd service to start at boot..."
echo "########## Guide at https://wiki.archlinux.org/index.php/WPA_supplicant#At_boot_.28systemd.29"
sudo systemctl enable wpa_supplicant@$wlint.service
echo "########## Starting wifi connection..."
sudo systemctl start wpa_supplicant@$wlint.service

echo "########## Enabling the ifplugd service for wired interface..."
systemctl enable netctl-ifplugd@$wdint.service
