#!/bin/bash

#
#	Configure hostname
#	File: hostname
#	Description: Put hostname in file hostname
#
#	@see https://raspberrypi.stackexchange.com/questions/78092/how-do-i-change-the-hostname-without-rebooting
#	@see https://gist.github.com/dweeber/4055331
#	@see https://www.raspberrypi-spy.co.uk/2012/11/how-to-rename-your-raspberry-pi/
#	@see https://slippytrumpet.io/posts/raspberry-pi-zero-w-setup/
#	@see https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/
#	@see https://docs.dataplicity.com/docs/install-dataplicity-on-many-devices
#	@see https://vicpimakers.ca/tutorials/raspbian/change-the-raspberry-pis-hostname/
#

HOST_FILE=$BOOTSETUP_ROOT/hostname

# Check if config file exists
if [ ! -f "$HOST_FILE" ]; then
	exit 0
fi

# Get new hostname
host_name="$(cat $HOST_FILE)"

# Remove file
rm $HOST_FILE

# If hostname already set or empty
if [ -z "$host_name" ] || [ "$(hostname)" == "$host_name" ]; then
	exit 0
fi

# Save in file (to make permanent)
echo "$host_name" > /etc/hostname

# Update /etc/hosts
sed -i -E 's/^127.0.1.1.*/127.0.1.1\t'"$host_name"'/' /etc/hosts

# Change active hostname
hostnamectl set-hostname "$host_name"

# Restart mDNS daemon (so it can be accessed using HOSTNAME.local)
systemctl restart avahi-daemon

echo "Hostname changed to $host_name"
