#!/bin/bash
#
# Setup Wireguard interfaces
#
# bootsetup
#   wireguard
#     INTERFACE_NAME.conf
#
source /etc/bootsetup/config

# Check if WireGuard is installed
if [ -z "$(which wg-quick)" ]; then
  exit 0
fi

# Check if config directory exists
if [ ! -d "$BOOTSETUP_ROOT/wireguard" ]; then
  exit 0
fi

# Check for sshauth directories
for dir in $BOOTSETUP_ROOT/wireguard/*
do
	[ -f "$dir" ] || continue

	name="$(echo "$dir" | rev | cut -d'.' -f2 | cut -d'/' -f1 | rev)" # Extract name
	[ -n "$name" ] || continue

  # Disable existing interface
  if [ -f "/etc/wireguard/$name.conf" ]; then
    systemctl stop wg-quick@$name
    systemctl disable wg-quick@$name
    rm "/etc/wireguard/$name.conf"
  fi

  # Enable new interface
  mv $dir /etc/wireguard/
  chmod 600 /etc/wireguard/$name.conf
  systemctl enable wg-quick@$name
  systemctl start wg-quick@$name

	echo "Added WireGuard interface $name"
done

# Remove config directory
rm -r $BOOTSETUP_ROOT/wireguard
