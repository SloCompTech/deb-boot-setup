#!/bin/bash

#
#	Run custom scripts
#	Directory tree:
# bootsetup
#		custom
#			... scripts ...
#

# Check if directory with custom scripts exsist
if [ ! -d "$BOOTSETUP_ROOT/custom" ]; then
	exit 0
fi

# Run custom scripts
echo "Executed custom scripts if any"
for script in $BOOTSETUP_ROOT/custom/*
do
	if [ -f "$script" ] && [ -x "$script" ]; then
		echo "$script"

		# Execute script
		$script
	fi
done

# Remove directory
rm -r $BOOTSETUP_ROOT/custom
