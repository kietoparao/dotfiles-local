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
echo "====================" >> $file
echo "sudo cat /etc/fstab output:" >> $file
echo "====================" >> $file
sudo cat /etc/fstab >> $file
echo "===> Finished."
echo "File $file generated."

# More info on http://www.brendangregg.com/Perf/linux_perf_tools_full.png
