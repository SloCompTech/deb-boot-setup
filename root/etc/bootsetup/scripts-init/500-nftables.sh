#!/bin/bash
#
# Setup nftables
#
source /etc/bootsetup/config

if [ ! -f "$BOOTSETUP_ROOT/nftables.conf" ]; then
  exit 0
fi

# Check if existing nftables config exists
if [ -f /etc/nftables.conf ]; then
  # Backup existing config
  mv /etc/nftables.conf /etc/nftables.conf.$(date +%Y%m%d%H%M%S).bck
fi

# Move new config file
mv $BOOTSETUP_ROOT/nftables.conf /etc/nftables.conf
chmod 644 /etc/nftables.conf

# Apply new config
nft -f /etc/nftables.conf

echo "Applied new nftables config"
