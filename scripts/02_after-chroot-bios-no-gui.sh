#!/bin/sh
set -euo pipefail

echo "########## Start and enable dhcpcd at startup..."
systemctl enable dhcpcd.service
systemctl start dhcpcd.service

echo "########## Setting time zone and clock..."
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc

echo "########## Setting locales..."
sed -i "/^#en_US.UTF-8 UTF-8/ s/# *//" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf

echo "########## Making wheel group a sudoer..."
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "########## Setting hostname and hosts file..."
echo "##### Write your desired hostname:"
read hstname
echo $hstname > /etc/hostname
echo "127.0.0.1       $hstname" >> /etc/hosts
echo "::1             $hstname" >> /etc/hosts
echo "127.0.0.1       $hstname.localdomain       $hstname" >> /etc/hosts

echo "########## Setting root password..."
passwd

lsblk
echo "########## Choose the '/dev/sdX' to install GRUB (e.g. '/dev/sda'):"
read grubdir
grub-install --target=i386-pc $grubdir
grub-mkconfig -o /boot/grub/grub.cfg

echo "########## Adding desired user to the wheel group..."
echo "##### Choose your username:"
read username
useradd -m -G wheel -s /bin/bash $username
echo "##### Introduce password for user '$username':"
passwd $username

echo "FINISHED! Exit chroot with Ctrl+D or typing 'exit', and then 'reboot'"
