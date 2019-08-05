#!/bin/bash

#
#	Add authorized SSH keys for remote access
#	Files: sshauth-USER/KEYFILES
#
#	@see https://www.cansurmeli.com/posts/raspberry-pi-what-to-do-after-first-boot/
#	@see https://eklitzke.org/setting-up-a-headless-raspberry-pi-on-linux
# @see https://slippytrumpet.io/posts/raspberry-pi-zero-w-setup/
#	@see https://help.ubuntu.com/community/SSH/OpenSSH/Configuring
# @see http://banoffeepiserver.com/change-default-settings.html
#	@see https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server
#	@see https://kb.iu.edu/d/aews
#	@see https://www.linode.com/docs/security/authentication/use-public-key-authentication-with-ssh/
#	@see https://www.howtoforge.com/set-up-ssh-with-public-key-authentication-debian-etch
#	@see https://serverpilot.io/docs/how-to-use-ssh-public-key-authentication
#	@see https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/
#	@see https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/
#

# Check for sshauth directories
for dir in $BOOTSETUP_ROOT/sshauth-*
do
	[ -d "$dir" ] || continue

	user="$(echo "$dir" | cut -d'-' -f2)" # Extract username
	[ -n "$user" ] || continue


	if [ "$user" != "root" ]; then # Normal users
		[ -d "/home/$user" ] || continue
		
		if [ ! -d "/home/$user/.ssh" ]; then
			mkdir /home/$user/.ssh
			chown $user:$user /home/$user/.ssh
			chmod 700 /home/$user/.ssh
		fi
	else # Root user
		if [ ! -d "/root/.ssh" ]; then
			mkdir /root/.ssh
			chmod 700 /root/.ssh
		fi
	fi

	for file in $BOOTSETUP_ROOT/sshauth-$user/*	# Each cert file
	do
		if [ "$user" != "root" ]; then
			cat $file >> /home/$user/.ssh/authorized_keys
			echo "" >> /home/$user/.ssh/authorized_keys # Ensure at least 1 new line
			chown $user:$user /home/$user/.ssh/authorized_keys
			chmod 600 /home/$user/.ssh/authorized_keys
		else
			cat $file >> /root/.ssh/authorized_keys
			echo "" >> /root/.ssh/authorized_keys # Ensure at least 1 new line
			chmod 600 /root/.ssh/authorized_keys
		fi
	done

	# Remove processed folder
	rm -r $dir

	echo "Added SSH authorized keys for $user"
done
