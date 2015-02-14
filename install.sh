#!/bin/sh

# check root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi  

# install usefull terminal packages
sudo apt-get install -y dircolors cowsay toilet fortune python-pygments htop
