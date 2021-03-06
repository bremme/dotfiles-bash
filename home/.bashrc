#!/bin/bash

echo "Loading .bashrc";

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# CUSTOM #######################################################################

### PATH #######################################################################

MY_BIN_PATH="/media/bremme/samevo/ssd-data/bin";
MY_SCRIPTS_PATH="/media/bremme/samevo/ssd-data/scripts";
NODEJS_BIN_PATH="/home/bremme/.node/bin";

export PATH=$HOME/bin:$NODEJS_BIN_PATH:$MY_BIN_PATH:$MY_SCRIPTS_PATH:$PATH;

### KEYMAPPINGS ################################################################

# auto complete history search (pageup pagedown)
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

### COLORS #####################################################################

# DIRCOLORS="~/.dircolors";
DIRCOLORS="$HOME/.dircolors.monokai.echelon";
#DIRCOLORS="$HOME/.dircolors.monokai.jtheoof";

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $DIRCOLORS && eval "$(dircolors -b $DIRCOLORS)" || eval "$(dircolors -b)";
fi

### FUNCTIONS ##################################################################
install_z () {
	printf "Do you want to install z? [Y/n]:"
	read confirm;
	if [ $confirm == "Y" ]; then
		if [ -x /usr/bin/wget ]; then
			printf "Install z to ['$HOME']?"
			read response;
			if [ -n "$response" ]; then
				if [ -d "$response" ]; then
					z_install_path="$response";
				else
					printf "Directory $reponse does not exist, create [Y/n]?";
					read confirm;
					if [ $confirm == "Y" ]; then
						mkdir -p $response;
						z_install_path = "$response";
					else
						printf "Cancelled, installing z.sh to '$HOME'\n";
					fi 
				fi
			else
				z_install_path="$HOME";
			fi
			if [ -f "$z_install_path/z.sh" ]; then
				printf "Already exists '$z_install_path/z.sh',overwrite? [Y/n]"
				read confirm;
				if [ $confirm != "Y" ]; then
					printf "Exit installing z.sh.\n";
					exit 0;							
				fi 
			fi
			printf "Installing z.sh to '$z_install_path/z.sh'\n";
			wget -q https://raw.githubusercontent.com/rupa/z/master/z.sh -O "$z_install_path/z.sh";
			if [ $? -eq 0 ]; then
				printf "Installed z.sh\n";
				source z.sh
			else
				printf "Failed to install z.sh\n";
				printf "Exit code wget: $?";
			fi
		else
			printf "Failed to install z.sh since wget is not installed\n";
		fi
	fi
}

gitlazy () {
	git add .
	git commit -a -m $1
	git push
}

gedit() { command gedit "$@" > /dev/null 2>&1 & }


### OTHER SOURCE ###############################################################
source "$HOME/.bash_colors"
source "$HOME/.bash_prompt"

source "$HOME/.oh-my-git/prompt.sh"

for f in "$HOME/.bash_completion.d/*"; do source $f; done

# Bash completion
if [ -f /etc/bash_completion ]; then
	source  /etc/bash_completion
fi

if [ -d "$HOME/.homesick" ]; then
	source "$HOME/.homesick/repos/homeshick/homeshick.sh"
	source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
fi

if [ -x "$(type -P z.sh)" ]; then
	echo "Loading z.sh";
	source z.sh;
else
	install_z;
fi
