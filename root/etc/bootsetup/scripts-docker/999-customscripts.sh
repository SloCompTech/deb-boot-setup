#!/bin/bash

#
#	Run custom scripts
#	Directory tree:
# bootsetup
#		custom-docker
#			... scripts ...
#

# Check if directory with custom scripts exsist
if [ ! -d "$BOOTSETUP_ROOT/custom-docker" ]; then
	exit 0
fi

# Run custom scripts
echo "Executed custom scripts if any"
for script in $BOOTSETUP_ROOT/custom-docker/*
do
	if [ -f "$script" ] && [ -x "$script" ]; then
		echo "$script"

		# Execute script
		$script
	fi
done

# Remove directory
rm -r $BOOTSETUP_ROOT/custom-docker
