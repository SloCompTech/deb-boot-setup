#!/bin/bash

#
#	Reset SSH configuration (usefull when using same image over and over)
#	File: sshreset
#
#	@see http://banoffeepiserver.com/change-default-settings.html
#	@see https://www.cyberciti.biz/faq/howto-regenerate-openssh-host-keys/
#

FLAG_FILE=$BOOTSETUP_ROOT/sshreset

# Chech if flag file exists
if [ ! -f "$FLAG_FILE" ]; then
	exit 0
fi

# Remove flag file
rm $FLAG_FILE

# Reset SSH configuration
rm /etc/ssh/ssh_host_* # Remove old device certs
dpkg-reconfigure openssh-server # Regenerate keys
systemctl restart ssh # Restart SSH server

# Remove authorized keys
rm /root/.ssh/authorized_keys* 2>/dev/null # For root
rm /home/**/.ssh/authorized_keys* 2>/dev/null	# For other users

echo "SSH keys were reconfigured"
