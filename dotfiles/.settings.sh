#! bash

shopt -s extglob        # enables extended globbing
shopt -s cdspell        # automatically corrects small typos in directory names and jumps to the best guess of existing directories
shopt -s checkwinsize   # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
#stty -ixon # ctrl+s = forward search bash history

# PATH
pathprepend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}
pathappend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
	fi
}
pathremove() {
    if [[ ":$PATH:" == *":$1:"* ]]; then
		PATH=$(echo $PATH | tr ':' '\n' | grep -v -x $1 | paste -sd: -)
    fi
}

# CDPATH
# curr : parent : home : projects : git
CDPATH=:..:~:~/projects:~/git

# HISTORY
shopt -s histappend                     # append new history items to .bash_history
export HISTCONTROL=ignoreboth:erasedups # prevent history duplicates and don't record lines starting with space in the history
export HISTFILESIZE=100000000           # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}         # increase history size (default is 500)

# hh https://github.com/dvorka/hstr
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
type hh >/dev/null 2>&1 && if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi
export HH_CONFIG=hicolor,keywords,rawhistory # get more colors

# history location - used to keep .bash_history and long term history
if [ -z "$HISTORY_DIR" ]; then historyLogPath=~/.history; else historyLogPath="$HISTORY_DIR"; fi
historyLogPath="$historyLogPath/$(hostname -f)"
mkdir -p "$historyLogPath"
export HISTFILE="$historyLogPath/.bash_history"



# enable color support of ls and also add handy aliases
dircolors="$(which dircolors)"
if [ -n "$dircolors" ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
unset dircolors

# colored "man"
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

# default editor
export VISUAL=micro
export EDITOR="$VISUAL"

export TAB='\t'

export LC_ALL=C
