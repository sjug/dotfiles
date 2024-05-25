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

alias sudo='sudo '
alias c='clear'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ll -A'
alias lr='la -tr'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim'
alias vim='nvim'
alias wget='wget -c'
alias mutt='cd ~/Downloads && mutt'
#alias mutt="torify mutt 2>/dev/null"
alias whatismyip='curl -s ifconfig.co/json | jq'
alias workvpn='sudo openvpn /etc/openvpn/client/rdu.conf'
alias workvm='ssh sebastianjug@10.12.23.173'
alias backuphome='rsync -aAX --info=progress2 --exclude={".android",".apm",".atom",".cache",".config/chromium-backup",".eclipse",".gem",".gimp-2.8",".m2",".node-gyp",".npm",".thumbnails",".tor-browser-en",".weechat/logs"} ~ /mnt/usb/'
alias yt-dlp-subs='yt-dlp --embed-subs --write-auto-subs'

export TERM=xterm-256color
export VISUAL=nvim
export EDITOR="$VISUAL"
export SYSTEMD_EDITOR="$VISUAL"
export LESSHISTFILE=/dev/null

# Custom functions
cla() { cd "$1"; la;}
mcd() { mkdir -p "$1"; cd "$1";} 

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash 
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX=1
bind -x '"\C-p": vim $(fzf);'

single-line() {
  awk '{printf "%s ", $0} END {print ""}' "$1"
}

