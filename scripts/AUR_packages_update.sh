#!/bin/sh
if [[ -z "$(auracle sync -q)" ]];
then 
	echo "No updates available. Try later."
else
	echo "Updates available!"
	for pkg in `auracle sync -q`
	do
		echo "===> Installing $pkg..."
		cd $pkg && git pull && makepkg -risc && cd ..
	done
fi
