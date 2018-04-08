# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt appendhistory autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/piranski/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#GENERAL SHORTCUTS
alias la="ls -lcAh --group-directories-first --color=auto"
alias ll="ls -lch --group-directories-first --color=auto"
alias systate="echo; lsblk ; echo; df -h; echo"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias hgrep='history | grep --color=auto'

#EDIT AND RELOAD .zshrc CONFIG
alias zshrc="nano ~/.zshrc && source ~/.zshrc"

#PACMAN SHORTCUTS
alias pacup="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu"     # ranks mirrors and updates pacman
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

#PING ONLY THREE TIMES
alias ping="ping -c 3"

#ACCESS OSMC
alias osmc="ssh osmc@192.168.1.133"
alias mntosmc="sshfs osmc@192.168.1.133:/ ~/OSMC_remote/" #Mounts remote / into local OSMC folder
alias umntosmc="fusermount -u ~/OSMC_remote/" #Unmounts remote OSMC folder

#ACCESS MACBOOK PRO
alias MBPssh="sshfs arnau@192.168.1.36:/ ~/MacbookPro/"    #Mounts remote / macbook folder into local MacbookPro folder
alias MBPoff="fusermount -u ~/MacbookPro/"

# VIDEO CAPTURE (SCREENCASTING)
# You can change the values -video_size and -framerate to lose some quality on the video file.
alias videocapture="ffmpeg -f x11grab -video_size 1280x1024 -framerate 60 -i $DISPLAY -f alsa -i default -c:v ffvhuff -c:a flac test.mkv"

# ============================================================================
# PASS COMPLETION 
# https://git.zx2c4.com/password-store/tree/src/completion/pass.zsh-completion
# ============================================================================

#compdef pass
#autoload

# Copyright (C) 2012 - 2014:
#    Johan Venant <jvenant@invicem.pro>
#    Brian Mattern <rephorm@rephorm.com>
#    Jason A. Donenfeld <Jason@zx2c4.com>.
# All Rights Reserved.
# This file is licensed under the GPLv2+. Please see COPYING for more information.


# If you use multiple repositories, you can configure completion like this:
#
# compdef _pass workpass
# zstyle ':completion::complete:workpass::' prefix "$HOME/work/pass"
# workpass() {
#   PASSWORD_STORE_DIR=$HOME/work/pass pass $@
# }


_pass () {
	local cmd
	if (( CURRENT > 2)); then
		cmd=${words[2]}
		# Set the context for the subcommand.
		curcontext="${curcontext%:*:*}:pass-$cmd"
		# Narrow the range of words we are looking at to exclude `pass'
		(( CURRENT-- ))
		shift words
		# Run the completion for the subcommand
		case "${cmd}" in
			init)
				_arguments : \
					"-p[gpg-id will only be applied to this subfolder]" \
					"--path[gpg-id will only be applied to this subfolder]"
				_pass_complete_keys
				;;
			ls|list|edit)
				_pass_complete_entries_with_subdirs
				;;
			insert)
				_arguments : \
					"-e[echo password to console]" \
					"--echo[echo password to console]" \
					"-m[multiline]" \
					"--multiline[multiline]"
				_pass_complete_entries_with_subdirs
				;;
			generate)
				_arguments : \
					"-n[don't include symbols in password]" \
					"--no-symbols[don't include symbols in password]" \
					"-c[copy password to the clipboard]" \
					"--clip[copy password to the clipboard]" \
					"-f[force overwrite]" \
					"--force[force overwrite]" \
					"-i[replace first line]" \
					"--in-place[replace first line]"
				_pass_complete_entries_with_subdirs
				;;
			cp|copy|mv|rename)
				_arguments : \
					"-f[force rename]" \
					"--force[force rename]"
					_pass_complete_entries_with_subdirs
				;;
			rm)
				_arguments : \
					"-f[force deletion]" \
					"--force[force deletion]" \
					"-r[recursively delete]" \
					"--recursive[recursively delete]"
					_pass_complete_entries_with_subdirs
				;;
			git)
				local -a subcommands
				subcommands=(
					"init:Initialize git repository"
					"push:Push to remote repository"
					"pull:Pull from remote repository"
					"config:Show git config"
					"log:Show git log"
					"reflog:Show git reflog"
				)
				_describe -t commands 'pass git' subcommands
				;;
			show|*)
				_pass_cmd_show
				;;
		esac
	else
		local -a subcommands
		subcommands=(
			"init:Initialize new password storage"
			"ls:List passwords"
			"find:Find password files or directories based on pattern"
			"grep:Search inside decrypted password files for matching pattern"
			"show:Decrypt and print a password"
			"insert:Insert a new password"
			"generate:Generate a new password using pwgen"
			"edit:Edit a password with \$EDITOR"
			"mv:Rename the password"
			"cp:Copy the password"
			"rm:Remove the password"
			"git:Call git on the password store"
			"version:Output version information"
			"help:Output help message"
		)
		_describe -t commands 'pass' subcommands
		_arguments : \
			"--version[Output version information]" \
			"--help[Output help message]"
		_pass_cmd_show
	fi
}

_pass_cmd_show () {
	_arguments : \
		"-c[put it on the clipboard]" \
		"--clip[put it on the clipboard]"
	_pass_complete_entries
}
_pass_complete_entries_helper () {
	local IFS=$'\n'
	local prefix
	zstyle -s ":completion:${curcontext}:" prefix prefix || prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
	_values -C 'passwords' ${$(find -L "$prefix" \( -name .git -o -name .gpg-id \) -prune -o $@ -print 2>/dev/null | sed -e "s#${prefix}/\{0,1\}##" -e 
's#\.gpg##' -e 's#\\#\\\\#' | sort):-""}
}

_pass_complete_entries_with_subdirs () {
	_pass_complete_entries_helper
}

_pass_complete_entries () {
	_pass_complete_entries_helper -type f
}

_pass_complete_keys () {
	local IFS=$'\n'
	# Extract names and email addresses from gpg --list-keys
	_values 'gpg keys' $(gpg2 --list-secret-keys --with-colons | cut -d : -f 10 | sort -u | sed '/^$/d')
}

_pass

