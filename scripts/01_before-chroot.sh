#!/bin/sh
echo "########## Setting the keyboard to ES..."
loadkeys es
echo "########## Checking internet connection..."
ping -c 3 archlinux.org
timedatectl set-ntp true
lsblk
echo "########## Type the '/dev/sdXX' partition you want to install arch into:"
read archpartition
mount $archpartition /mnt
echo "########## Installing base and base-devel packages..."
pacstrap /mnt base base-devel
echo "########## Generating the fstab file with the mounted partition where arch is installed..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "########## Arch-chrooting into new installed system..."
arch-chroot /mnt
