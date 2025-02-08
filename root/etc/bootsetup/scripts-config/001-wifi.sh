#!/bin/bash
#
# Setup Wi-Fi connection
# @see https://people.freedesktop.org/~lkundrak/nm-docs/nm-settings.html
# @see https://askubuntu.com/questions/1251273/how-to-add-a-wifi-connection-if-im-not-within-range
#
source /etc/bootsetup/config

# Check if nmcli util exists
if [ -z "$(which nmcli)" ]; then
  exit 0
fi

# Check if config directory exists
if [ ! -d "$BOOTSETUP_ROOT/wifi" ]; then
  exit 0
fi

# Add WiFi connections
echo "Adding Wi-Fi connections"
for script in $BOOTSETUP_ROOT/wifi/*
do
	ssid="$(head -n 1 $script | tr -d '\r\n')"
  connname="$(echo "$ssid" | tr -d '-')"
  ifname="$(ifconfig | grep wl | head -n 1 | cut -d':' -f1)"
  echo "Creating Wi-Fi connection $connname at $connname"
  echo "Configuring SSID: $ssid"

  # Create Wi-Fi config based on password present or not
  if [ "$(wc -l $script | cut -d' ' -f1)" -gt 1 ]; then
    nmcli connection add type wifi connection.id "$connname" connection.interface-name "$ifname" wifi.ssid "$ssid" wifi-sec.key-mgmt WPA-PSK wifi-sec.psk "$(head -n 2 $script | tail -n 1 | tr -d '\r\n')"
  else
    nmcli connection add type wifi connection.id "$connname" connection.interface-name "$ifname" wifi.ssid "$ssid"
  fi

  # Remove script
  rm $script
done

# Remove config directory
rm -r $BOOTSETUP_ROOT/wifi
