#!/bin/bash
#
#	Run custom scripts
#	Directory tree:
# bootsetup
#		custom-docker
#			... scripts ...
#

# Check if directory with custom scripts exists
if [ ! -d "$BOOTSETUP_ROOT/custom-docker" ]; then
	exit 0
fi

# Run custom scripts
echo "Executed custom docker scripts if any"
for script in $BOOTSETUP_ROOT/custom-docker/*
do
	if [ -f "$script" ] && [ -x "$script" ]; then
		# Execute script
		echo "Running: $script"
		$script
	fi
done

# Remove directory
rm -r $BOOTSETUP_ROOT/custom-docker
