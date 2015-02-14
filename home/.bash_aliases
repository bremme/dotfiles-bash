#!/bin/bash

echo "Loading .bash_aliases";


if [ -x /usr/bin/pygmentize ]; then
	alias cat="pygmentize -g";
	alias catb="/bin/cat";
else
  echo "pygmentize not installed, using regular cat"
fi

if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
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

# apt-get commands
alias agi="sudo apt-get install"
alias agr="sudo apt-get remove"
alias agp="sudo apt-get purge"

# sudo commands
alias snano="sudo nano"
alias sgedit="sudo gedit"

# ssh commands
alias sshx="ssh -X"

# reload bash
alias rlb="source ~/.bashrc"

# grep process
alias proc="ps aux | grep"
