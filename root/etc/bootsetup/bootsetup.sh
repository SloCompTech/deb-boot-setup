#!/bin/bash

#
#		Main bootsetup script
#
export BOOTSETUP_ROOT=/boot/bootsetup
export BOOTSETUP_BIN=/etc/bootsetup

# Check if boot partition exists
if [ ! -d "/boot" ]; then
	echo "Bootsetup: No boot partition"
	exit 0
fi

# Check if bootsetup folder exists
if [ ! -d "$BOOTSETUP_ROOT" ]; then
	echo "Bootsetup: No bootsetup folder"
	exit 0
fi

# Check for disable file
if [ -f "$BOOTSETUP_ROOT/disable" ]; then
	echo "Bootsetup: DISABLED"
	exit 0
fi

# Check if scripts folder exists
if [ ! -d "$BOOTSETUP_BIN/scripts" ]; then
	echo "Bootsetup: No scripts"
	exit 0
fi

# Run scripts
for script in $BOOTSETUP_BIN/scripts/*.sh
do
	([ -f "$script" ] && [ -x "$script" ]) || continue # Skip non-executable scripts

	# Execute script
	$script
done
