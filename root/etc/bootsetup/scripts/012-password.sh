#!/bin/bash

#
#	Change user password
#	File: passwd-USER
#	File content: New password
#
#	@see https://www.systutorials.com/39549/changing-linux-users-password-in-one-command-line/
#	@see https://www.2daygeek.com/linux-passwd-chpasswd-command-set-update-change-users-password-in-linux-using-shell-script/
#

# Check for sshauth directories
for file in $BOOTSETUP_ROOT/passwd-*
do
	[ -f "$file" ] || continue

	user="$(echo "$file" | cut -d'-' -f2)" # Extract username
	[ -n "$user" ] || continue
	([ "$user" == "root" ] || [ -d "/home/$user" ]) || continue
	
	new_password="$(cat $file)"
	[ -n "$new_password" ] || continue

	# Change password for user
	echo -e "$new_password\n$new_password" | passwd $user

	# Remove processed folder
	rm $file

	echo "Changed password for $user"
done
