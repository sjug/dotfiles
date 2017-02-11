#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PS1='[\u@\h \W]\$ '

# User specific aliases and functions
set -o vi

alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ll -A'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim'
alias wget='wget -c'
alias mutt='cd ~/downloads && mutt'
#alias mutt="torify mutt 2>/dev/null"
alias whatismyip='curl https://ip.anysrc.net'
alias workvm='ssh sebastianjug@10.12.23.173'
alias backuphome='rsync -aAX --info=progress2 --exclude={".android",".apm",".atom",".cache",".config/chromium-backup",".eclipse",".gem",".gimp-2.8",".m2",".node-gyp",".npm",".thumbnails",".tor-browser-en",".weechat/logs"} ~ /mnt/usb/'

#export TERM=xterm-256color
export VISUAL=vim
export EDITOR="$VISUAL"
export SYSTEMD_EDITOR="$VISUAL"
export LESSHISTFILE=/dev/null

# Custom functions
cla() { cd "$1"; la;}
mcd() { mkdir -p "$1"; cd "$1";} 

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
