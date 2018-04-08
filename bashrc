#
# ~/.bashrc
# 

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#---------------------------------------------------------

#GENERAL SHORTCUTS
alias la="ls -lcAh --group-directories-first --color=auto"
alias ll="ls -lch --group-directories-first --color=auto"
alias systate="echo; lsblk ; echo; df -h; echo"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ptpb="curl -F c=@- https://ptpb.pw/"
alias hgrep="history | grep"

#DEFAULT EDITOR
export EDITOR=nano

#HISTORY CONFIG
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
export PROMPT_COMMAND="history -a"

#EDIT AND RELOAD .bashrc CONFIG
alias bashrc="nano ~/.bashrc && source ~/.bashrc" 

#PACMAN SHORTCUTS
alias pacup="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu" #updates pacman after ranking mirrors
alias pacinfo="pacman -Si" #shows info about a specific package
alias pacinst="sudo pacman -S" #installs a package
alias pacrem="sudo pacman -Rs" #Removes a package and its dependencies which are not required by any other installed package
alias paclist="sudo pacman -Qqet" #Lists all packages explicitly installed and not required as dependencies
alias paccache="paccache -r" #remove old package cache files except for the latest three package versions
alias pacorph="pacman -Qdt" # lists orphaned packages
alias aurlist="pacman -Qm" #List AUR installed packages
alias pacedit="sudo nano /etc/pacman.conf" #edit pacman config file to enable/disable repos

#FSTAB
alias fstab="sudo nano /etc/fstab" #edits fstab file

#CLAMAV
#alias virusup="sudo freshclam -v"

#PING ONLY THREE TIMES
alias ping="ping -c 3"

#ACCESS OSMC
alias osmc="ssh osmc@192.168.1.133"
alias mntosmc="sshfs osmc@192.168.1.133:/ ~/OSMC_remote/" #Mounts remote / into local OSMC folder
alias umntosmc="fusermount -u ~/OSMC_remote/" #Unmounts remote OSMC folder

# VIDEO CAPTURE (SCREENCASTING)
# You can change the values -video_size and -framerate to lose some quality on the video file.
alias videocapture="ffmpeg -f x11grab -video_size 1280x1024 -framerate 60 -i $DISPLAY -f alsa -i default -c:v ffvhuff -c:a flac test.mkv"

# NETWORK USING BROADCOM-WL
#alias wifipisito="sudo netctl start wlp3s0-Pisito"   # Connect to home wifi using wifi-menu and broadcom-wl package
#alias wifitorello="sudo netctl start wlp3s0-MOVISTAR_PLUS"
#alias wifipapes="sudo netctl start wlp3s0-WLAN_47B9"
#alias rwifipapes="sudo netctl restart wlp3s0-WLAN_47B9"
#alias wifikieto="sudo netctl start wlp3s0-kieto"
#alias pisito-wifi-off="sudo netctl stop wlp3s0-Pisito"
#alias torello-wifi-off="sudo netctl stop wlp3s0-MOVISTAR_PLUS"
#alias kieto-wifi-off="sudo netctl stop wlp3s0-kieto"

# NETWORK USING b43
alias rwifi="sudo systemctl restart wpa_supplicant@wlp3s0b1.service"
alias stopwifi="sudo systemctl stop wpa_supplicant@wlp3s0b1.service"
alias startwifi="sudo systemctl start wpa_supplicant@wlp3s0b1.service"

# NETWORK
alias ethoff="sudo ip link set enp2s0f0 down"
alias wifioff="sudo ip link set wlp3s0 down"


#====================================================================
# completion file for bash in pass package
#====================================================================

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

