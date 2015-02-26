#!/bin/bash

echo "Loading .bash_aliases";


if [ -x /usr/bin/pygmentize ]; then
	alias cat="pygmentize -g";
	alias catb="/bin/cat";
else
  echo "pygmentize not installed, using regular cat"
fi

if [ -x /usr/bin/dircolors ]; then
    alias ls='ls -h --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # some more ls aliases
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi
# cd commands
alias ..="cd .."
alais ...="cd ../.."
alias ....="cd ../../.."
alias chome="cd $HOME"
alias croot="cd /"
alias cetc="cd /etc"

# apt-get commands
alias sagi="sudo apt-get install"
alias sagr="sudo apt-get remove"
alias sagp="sudo apt-get purge"

# sudo commands
alias snano="sudo nano"
alias sgedit="sudo gedit"

# ssh commands
alias sshx="ssh -X"

# reload bash
alias rlb="source ~/.bashrc"

# grep process
alias proc="ps aux | grep"

# mkdir -> always make parent and verbose output
alias mkdir="mkdir -pv"
alias mkdirb="/bin/mkdir"

alias p="ping"
alias wanip="$(wget -qO- http://ipecho.net/plain)"

alias ls-packages="/bin/cat /var/log/apt/history.log | grep -Po '(?<=apt-get install ).+' | tr ' ' '\n' | sort"

alias ls-dirsize-gb="du --max-depth=1 --human-readable --threshold=1G --one-file-system | sort --general-numeric-sort"
alias ls-dirsize-mb="du --max-depth=1 --human-readable --threshold=1M --one-file-system | sort --general-numeric-sort"
alias ls-dirsize-gb-n="du --human-readable --threshold=1G --one-file-system | sort --general-numeric-sort"
alias ls-dirsize-mb-n="du --human-readable --threshold=1M --one-file-system | sort --general-numeric-sort"
