# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/kieto/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  archlinux
  git
  history
  pass
  sudo
  web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshrc="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# =====================================================================
# Lines configured by zsh-newuser-install
# ---------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=50000
setopt appendhistory autocd HIST_IGNORE_SPACE
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kieto/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# =====================================================================

#GENERAL SHORTCUTS
alias systate="echo; lsblk ; echo; df -h; echo"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
#alias hgrep='history | grep --color=auto'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'

#PACMAN SHORTCUTS
alias pacup="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syu"     # ranks mirrors and updates pacman
alias pacinfo="pacman -Si" #shows info about a specific package
alias pacinst="sudo pacman -S" #installs a package
alias pacrem="sudo pacman -Rs" #Removes a package and its dependencies which are not required by any other installed package
alias paclist="sudo pacman -Qqet" #Lists all packages explicitly installed and not required as dependencies
alias paccache="paccache -r" #remove old package cache files except for the latest three package versions
alias pacorph="pacman -Qdt" # lists orphaned packages
alias aurlist="pacman -Qm" #List AUR installed packages
alias pacedit="sudo vim /etc/pacman.conf" #edit pacman config file to enable/disable repos

#FSTAB
alias fstab="sudo vim /etc/fstab" #edits fstab file

#PING ONLY THREE TIMES
alias ping="ping -c 3"

# VIDEO CAPTURE (SCREENCASTING)
# You can change the values -video_size and -framerate to lose some quality on the video file.
alias videocapture="ffmpeg -f x11grab -video_size 1280x1024 -framerate 60 -i $DISPLAY -f alsa -i default -c:v ffvhuff -c:a flac test.mkv"

# PASTEBINS
alias ptpb='curl -F c=@- https://ptpb.pw/'

# Enable conda commands
export PATH="$PATH:$HOME/miniconda3/bin"
. /home/kieto/miniconda3/etc/profile.d/conda.sh

