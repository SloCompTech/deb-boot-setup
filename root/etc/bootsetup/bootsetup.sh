#!/bin/bash

#
#		Main bootsetup script
#

export BOOTSETUP_BIN=/etc/bootsetup
export BOOTSETUP_ROOT=/boot/bootsetup

# Check for lock file
if [ -f "$BOOTSETUP_BIN/lock" ]; then
	echo "Bootsetup: Bootsetup locked"
	exit 0
fi

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

# Check for lockfile (and lock bootsetup)
if [ -f "$BOOTSETUP_ROOT/lock" ]; then
	# Remove lockfile
	rm $BOOTSETUP_ROOT/lock

	# Create real lockfile
	touch $BOOTSETUP_BIN/lock

	echo "Bootsetup: Locked down"
fi
