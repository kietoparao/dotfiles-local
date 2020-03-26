#!/bin/sh
set -euo pipefail

echo "########## Setting the keyboard to ES..."
loadkeys es
echo "########## Setting clock..."
timedatectl set-ntp true
echo "########## Checking internet connection..."
ip link
ping -c 3 archlinux.org
lsblk
echo "########## Type the '/dev/sdX' partition you want to format (e.g. '/dev/sda'):"
read target
fdisk $target << EOF
o
n
p
1

-1000M
n
p
2


t
2
82
w
EOF
mkfs.ext4 ${target}1
mkswap ${target}2
swapon ${target}2
echo "########## Installing Arch Linux into $target..."
mount ${target}1 /mnt
echo "########## Installing base and base-devel packages..."
pacstrap /mnt \
	acpi \
	base \
	dhcpcd \
	git \
	grub \
	htop \
	intel-ucode \
	iw \
	light \
	linux \
	linux-firmware \
	man-db \
	man-pages \
	net-tools \
	openssh \
	sudo \
	texinfo \
	vi \
	vim \
	wpa_supplicant \
	xkeyboard-config \
	zsh
echo "########## Generating the fstab file with the mounted partition where arch is installed..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "########## Arch-chrooting into new installed system..."
arch-chroot /mnt
