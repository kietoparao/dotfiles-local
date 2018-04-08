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
