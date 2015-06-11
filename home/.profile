#!/bin/bash

echo "Loading .profile";
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set MATLABPATH if matlab is installed
if [ -x /usr/bin/matlab ] || [ -x "$HOME/bin/matlab" ] ; then
	MATLABUSERPATH="$HOME/Development/matlab/lib";
	if [ -d "$MATLABUSERPATH" ]; then
		MATLABPATH="$MATLABUSERPATH";
		export MATLABPATH;
		echo "Added $MATLABUSERPATH to MATLABPATH";
	fi
fi
PATH="/usr/games:$PATH"
