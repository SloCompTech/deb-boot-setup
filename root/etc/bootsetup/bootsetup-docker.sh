#!/bin/bash
#
#		Bootsetup docker script
#
source /etc/bootsetup/config

# Check for lock file
if [ -f "$BOOTSETUP_LOCK_DOCKER_FILE_DEST" ]; then
	echo "Bootsetup docker: Bootsetup locked"
	exit 0
fi

# Check if bootsetup folder exists
if [ ! -d "$BOOTSETUP_ROOT" ]; then
	echo "Bootsetup docker: No bootsetup folder"
	exit 0
fi

# Check for disable file
if [ -f "$BOOTSETUP_DISABLE_FILE" ]; then
	echo "Bootsetup docker: DISABLED"
	exit 0
fi

# Check if scripts folder exists
if [ -d "$BOOTSETUP_BIN/scripts-init-docker" ]; then
	# Run scripts
	for script in $BOOTSETUP_BIN/scripts-init-docker/*.sh
	do
		([ -f "$script" ] && [ -x "$script" ]) || continue # Skip non-executable scripts

		# Execute script
		echo "Running: $script"
		$script
	done
else
	echo "Bootsetup docker: No scripts"
	exit 0
fi

# Check for lockfile (and lock bootsetup)
if [ -f "$BOOTSETUP_LOCK_DOCKER_FILE" ]; then
	# Create real lockfile
	touch $BOOTSETUP_LOCK_DOCKER_FILE_DEST

	# Remove lock config
	rm $BOOTSETUP_LOCK_DOCKER_FILE

	echo "Bootsetup docker: Locked down"
fi
