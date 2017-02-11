#
# ~/.bash_profile
#

# Get the aliases and functions
[[ -f ~/.bashrc ]] && . ~/.bashrc

# User specific environment and startup programs
export GOPATH=~/go
PATH="$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin"
export PATH
