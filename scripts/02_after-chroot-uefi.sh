#!/bin/sh

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc

echo "########## Setting locales..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

echo "########## Making wheel group a sudoer..."
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "########## Setting hostname and hosts file..."
echo "##### Write your desired hostname:"
read hstname
echo $hstname > /etc/hostname
echo "127.0.0.1       $hstname.localdomain       $hstname" >> /etc/hosts

echo "########## Setting root password..."
passwd

echo "########## Installing intel-ucode and grub packages..."
pacman -S intel-ucode grub

lsblk
echo "########## Installing GRUB EFI:"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "########## Creating a 2Gb swapfile on the root / dir..."
cd /
fallocate -l 2048M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile    none    swap    defaults    0 0" >> /etc/fstab

echo "########## Installing intel drivers..."
pacman -S mesa xf86-video-intel

echo "########## Installing xorg..."
pacman -S xorg

echo "########## Setting the xorg keyboard keymap..."
localectl --no-convert set-x11-keymap es pc104,pc105 ,cat terminate:ctrl_alt_bksp

echo "########## Installing i3 window manager..."
pacman -S i3

echo "########## Installing display manager..."
pacman -S lightdm lightdm-gtk-greeter

echo "########## Enabling ligthdm display manager at boot..."
systemctl enable lightdm.service

echo "########## Installing basic packages..."
pacman -S firefox weechat htop rxvt-unicode xterm rofi pcmanfm gvfs xarchiver gnome-themes-standard scrot

echo "########## Adding desired user to the wheel group..."
echo "##### Choose your username:"
read username
useradd -m -G wheel -s /bin/bash $username
echo "##### Introduce user's password:"
passwd $username

echo "########## Making wheel group a sudoer..."
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

#echo "########## Installing packages from "Packages" file on the root / dir..."
#xargs -a /Packages pacman -S --noconfirm --needed
