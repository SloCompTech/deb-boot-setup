#!/bin/bash

#
#	Update your device
#	File: update
#

FLAG_FILE=$BOOTSETUP_ROOT/upgrade

# Chech if flag file exists
if [ ! -f "$FLAG_FILE" ]; then
	exit 0
fi

# Remove flag file
rm $FLAG_FILE

apt update
apt upgrade -y
