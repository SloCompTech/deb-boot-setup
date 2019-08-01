#!/bin/bash

#
#	Copy directory tree as root fs to system tree
#	Directory: rootfs
#	Files: all files inside rootfs will be copied as rootfs is /
#

if [ ! -d "$BOOTSETUP_ROOT/rootfs" ]; then
	exit 0
fi

#	Copy whole tree structure
cp -r $BOOTSETUP_ROOT/rootfs/* /

# Remove dir
rm -rf $BOOTSETUP_ROOT/rootfs

echo "RootFS copied to the system"
