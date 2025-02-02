#!/bin/bash

#
#		Main bootsetup script
#
source /etc/bootsetup/config

# Check for lock file
if [ -f "$BOOTSETUP_LOCK_FILE_DEST" ]; then
	echo "Bootsetup: Bootsetup locked"
	exit 0
fi

# Check if bootsetup folder exists
if [ ! -d "$BOOTSETUP_ROOT" ]; then
	echo "Bootsetup: No bootsetup folder"
	exit 0
fi

# Check for disable file
if [ -f "$BOOTSETUP_DISABLE_FILE" ]; then
	echo "Bootsetup: DISABLED"
	exit 0
fi

if [ ! -f "$BOOTSETUP_LOCK_INIT_FILE_DEST" ] && [ -d "$BOOTSETUP_BIN/scripts-init" ]; then
	# Run scripts
	for script in $BOOTSETUP_BIN/scripts-init/*.sh
	do
		([ -f "$script" ] && [ -x "$script" ]) || continue # Skip non-executable scripts

		# Execute script
		echo "Running: $script"
		$script
	done
else
	echo "Bootsetup: No scripts-init directory or disabled"
fi

# Check if scripts directory exists
if [ -d "$BOOTSETUP_BIN/scripts-config" ]; then
	# Run scripts
	for script in $BOOTSETUP_BIN/scripts-config/*.sh
	do
		([ -f "$script" ] && [ -x "$script" ]) || continue # Skip non-executable scripts

		# Execute script
		echo "Running: $script"
		$script
	done
else
	echo "Bootsetup: No scripts-config directory"
fi


# Check for lockfile (and lock bootsetup)
if [ -f "$BOOTSETUP_LOCK_INIT_FILE" ]; then
	# Remove lockfile
	rm $BOOTSETUP_LOCK_INIT_FILE

	# Create real lockfile
	touch $BOOTSETUP_LOCK_INIT_FILE_DEST

	echo "Bootsetup: Locked down init scripts"
fi


# Check for lockfile (and lock bootsetup)
if [ -f "$BOOTSETUP_LOCK_FILE" ]; then
	# Remove lockfile
	rm $BOOTSETUP_LOCK_FILE

	# Create real lockfile
	touch $BOOTSETUP_LOCK_FILE_DEST

	echo "Bootsetup: Locked down"
fi
