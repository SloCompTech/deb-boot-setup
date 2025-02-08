#!/bin/bash
#
#	Clear docker logs
#	File: dockerlogs
#

FLAG_FILE=$BOOTSETUP_ROOT/dockerlogs

# Chech if flag file exists
if [ ! -f "$FLAG_FILE" ]; then
	exit 0
fi

# Remove flag file
rm $FLAG_FILE

# Clear log files
truncate -s 0 /var/lib/docker/containers/*/*-json.log
