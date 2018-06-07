#!/bin/sh
file=computer_report.txt
echo "====================" > $file
echo "sudo inxi -b output:" >> $file
echo "====================" >> $file
sudo inxi -b >> $file
echo "====================" >> $file
echo " sudo lspci output:" >> $file
echo "====================" >> $file
sudo lspci >> $file
echo "====================" >> $file
echo " sudo lscpu output:" >> $file
echo "====================" >> $file
sudo lscpu >> $file
echo "====================" >> $file
echo " sudo lsblk output:" >> $file
echo "====================" >> $file
sudo lsblk >> $file
echo "===> Finished."
echo "File $file generated."
