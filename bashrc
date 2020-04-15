#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#-------------------------------------------------------------------------------------

# ENABLE VIRTUALENV-WRAPPER https://flexion.org/posts/2012-12-python-and-virtualenv-on-archlinux-and-ubuntu/
#export WORKON_HOME=${HOME}/Snakepit-virtualenv
#if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#    source /usr/local/bin/virtualenvwrapper.sh
#elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
#    source /usr/bin/virtualenvwrapper.sh
#fi

#DEVTOOLS CHROOT
#https://wiki.archlinux.org/index.php/DeveloperWiki:Building_in_a_Clean_Chroot
#export CHROOT=$HOME/chroot

#GENERAL SHORTCUTS
alias la="ls -lcAh --group-directories-first --color=auto"
alias ll="ls -lch --group-directories-first --color=auto"
alias systate="echo; lsblk ; echo; df -h; echo"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias hgrep='history | grep --color=auto'

#HISTORY CONFIG
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
export PROMPT_COMMAND="history -a"

#EDIT AND RELOAD .bashrc CONFIG
alias bashrc="nano ~/.bashrc && source ~/.bashrc" 

#PACMAN SHORTCUTS
#alias pacfresh="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist" #https://wiki.archlinux.org/index.php/Reflector
#alias pacfresh="sudo ~/Scripts/armrr/armrr" #Arch Linux script that downloads a pacman ranked mirrorlist by selected country.
alias pacup="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu"     # ranks mirrors and updates pacman
alias pacinfo="pacman -Si" #shows info about a specific package
alias pacinst="sudo pacman -S" #installs a package
alias pacrem="sudo pacman -Rs" #Removes a package and its dependencies which are not required by any other installed package
alias paclist="sudo pacman -Qqet" #Lists all packages explicitly installed and not required as dependencies
alias paccache="paccache -r" #remove old package cache files except for the latest three package versions
alias pacorph="pacman -Qdt" # lists orphaned packages
alias aurlist="pacman -Qm" #List AUR installed packages
alias pacedit="sudo nano /etc/pacman.conf" #edit pacman config file to enable/disable repos

#GRUB
#alias grubup="sudo update-grub" #updates grub bootloader

#FSTAB
alias fstab="sudo nano /etc/fstab" #edits fstab file

#ALLSERVERS SCRIPT
#alias as="/usr/bin/allservers" #bring up the allservers menu

#CLAMAV
#alias virusup="sudo freshclam -v"

#PING ONLY THREE TIMES
alias ping="ping -c 3"

#ACCESS OSMC
alias osmc="ssh osmc@192.168.1.133"
alias mntosmc="sshfs osmc@192.168.1.133:/ ~/OSMC_remote/" #Mounts remote / into local OSMC folder
alias umntosmc="fusermount -u ~/OSMC_remote/" #Unmounts remote OSMC folder

#ACCESS MACBOOK PRO
alias MBPssh="sshfs arnau@192.168.1.36:/ ~/MacbookPro/"    #Mounts remote / macbook folder into local MacbookPro folder
alias MBPoff="fusermount -u ~/MacbookPro/"

# LUKS-encrypted backup on iomega hdd:
#alias mntcryp="sudo cryptsetup --type luks open /dev/sdb1 LUKS-backup && sudo mount -t ext4 /dev/mapper/LUKS-backup /mnt/"
#alias umntcryp="sudo umount /mnt/ && sudo cryptsetup close LUKS-backup"

# VIDEO CAPTURE (SCREENCASTING)
# You can change the values -video_size and -framerate to lose some quality on the video file.
alias videocapture="ffmpeg -f x11grab -video_size 1280x1024 -framerate 60 -i $DISPLAY -f alsa -i default -c:v ffvhuff -c:a flac test.mkv"



#===============================================================================
# pass completion file for bash
# https://git.zx2c4.com/password-store/tree/src/completion/pass.bash-completion
#===============================================================================

# Copyright (C) 2012 - 2014 Jason A. Donenfeld <Jason@zx2c4.com> and
# Brian Mattern <rephorm@rephorm.com>. All Rights Reserved.
# This file is licensed under the GPLv2+. Please see COPYING for more information.

_pass_complete_entries () {
	prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store/}"
	prefix="${prefix%/}/"
	suffix=".gpg"
	autoexpand=${1:-0}

	local IFS=$'\n'
	local items=($(compgen -f $prefix$cur))

	# Remember the value of the first item, to see if it is a directory. If
	# it is a directory, then don't add a space to the completion
	local firstitem=""
	# Use counter, can't use ${#items[@]} as we skip hidden directories
	local i=0

	for item in ${items[@]}; do
		[[ $item =~ /\.[^/]*$ ]] && continue

		# if there is a unique match, and it is a directory with one entry
		# autocomplete the subentry as well (recursively)
		if [[ ${#items[@]} -eq 1 && $autoexpand -eq 1 ]]; then
			while [[ -d $item ]]; do
				local subitems=($(compgen -f "$item/"))
				local filtereditems=( )
				for item2 in "${subitems[@]}"; do
					[[ $item2 =~ /\.[^/]*$ ]] && continue
					filtereditems+=( "$item2" )
				done
				if [[ ${#filtereditems[@]} -eq 1 ]]; then
					item="${filtereditems[0]}"
				else
					break
				fi
			done
		fi

		# append / to directories
		[[ -d $item ]] && item="$item/"

		item="${item%$suffix}"
		COMPREPLY+=("${item#$prefix}")
		if [[ $i -eq 0 ]]; then
			firstitem=$item
		fi
		let i+=1
	done

	# The only time we want to add a space to the end is if there is only
	# one match, and it is not a directory
	if [[ $i -gt 1 || ( $i -eq 1 && -d $firstitem ) ]]; then
		compopt -o nospace
	fi
}

_pass_complete_folders () {
	prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store/}"
	prefix="${prefix%/}/"

	local IFS=$'\n'
	local items=($(compgen -d $prefix$cur))
	for item in ${items[@]}; do
		[[ $item == $prefix.* ]] && continue
		COMPREPLY+=("${item#$prefix}/")
	done
}

_pass_complete_keys () {
	local IFS=$'\n'
	# Extract names and email addresses from gpg --list-keys
	local keys="$(gpg2 --list-secret-keys --with-colons | cut -d : -f 10 | sort -u | sed '/^$/d')"
	COMPREPLY+=($(compgen -W "${keys}" -- ${cur}))
}

_pass()
{
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local commands="init ls find grep show insert generate edit rm mv cp git help version"
	if [[ $COMP_CWORD -gt 1 ]]; then
		local lastarg="${COMP_WORDS[$COMP_CWORD-1]}"
		case "${COMP_WORDS[1]}" in
			init)
				if [[ $lastarg == "-p" || $lastarg == "--path" ]]; then
					_pass_complete_folders
					compopt -o nospace
				else
					COMPREPLY+=($(compgen -W "-p --path" -- ${cur}))
					_pass_complete_keys
				fi
				;;
			ls|list|edit)
				_pass_complete_entries
				;;
			show|-*)
				COMPREPLY+=($(compgen -W "-c --clip" -- ${cur}))
				_pass_complete_entries 1
				;;
			insert)
				COMPREPLY+=($(compgen -W "-e --echo -m --multiline -f --force" -- ${cur}))
				_pass_complete_entries
				;;
			generate)
				COMPREPLY+=($(compgen -W "-n --no-symbols -c --clip -f --force -i --in-place" -- ${cur}))
				_pass_complete_entries
				;;
			cp|copy|mv|rename)
				COMPREPLY+=($(compgen -W "-f --force" -- ${cur}))
				_pass_complete_entries
				;;
			rm|remove|delete)
				COMPREPLY+=($(compgen -W "-r --recursive -f --force" -- ${cur}))
				_pass_complete_entries
				;;
			git)
				COMPREPLY+=($(compgen -W "init push pull config log reflog rebase" -- ${cur}))
				;;
		esac
	else
		COMPREPLY+=($(compgen -W "${commands}" -- ${cur}))
		_pass_complete_entries 1
	fi
}

complete -o filenames -F _pass pass

