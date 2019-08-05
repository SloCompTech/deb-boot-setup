#!/bin/bash

#
#		Bootsetup docker script
#

export BOOTSETUP_BIN=/etc/bootsetup
export BOOTSETUP_ROOT=/boot/bootsetup

# Check for lock file
if [ -f "$BOOTSETUP_BIN/lock" ] && [ -f "$BOOTSETUP_BIN/lock_docker" ]; then
	echo "Bootsetup docker: Bootsetup locked"
	exit 0
fi

# Check if boot partition exists
if [ ! -d "/boot" ]; then
	echo "Bootsetup docker: No boot partition"
	exit 0
fi

# Check if bootsetup folder exists
if [ ! -d "$BOOTSETUP_ROOT" ]; then
	echo "Bootsetup docker: No bootsetup folder"
	exit 0
fi

# Check for disable file
if [ -f "$BOOTSETUP_ROOT/disable" ]; then
	echo "Bootsetup docker: DISABLED"
	exit 0
fi

# Check if scripts folder exists
if [ ! -d "$BOOTSETUP_BIN/scripts-docker" ]; then
	echo "Bootsetup docker: No scripts"
	exit 0
fi

# Check for lockfile (and lock bootsetup)
if [ -f "$BOOTSETUP_BIN/lock" ]; then
	# Create real lockfile
	touch $BOOTSETUP_BIN/lock_docker

	echo "Bootsetup docker: Locked down"
fi
