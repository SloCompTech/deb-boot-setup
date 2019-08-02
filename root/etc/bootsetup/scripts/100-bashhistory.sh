#!/bin/bash

#
#	Clear bash history
#	File: bashhistory
#
#	@see https://askubuntu.com/questions/191999/how-to-clear-bash-history-completely
#	@see https://www.cyberciti.biz/faq/clear-the-shell-history-in-ubuntu-linux/
#	@see https://www.techrepublic.com/article/how-to-effectively-clear-your-bash-history/
#	@see https://unix.stackexchange.com/questions/203290/how-do-i-clear-the-terminal-history
#

FLAG_FILE=$BOOTSETUP_ROOT/bashhistory

# Chech if flag file exists
if [ ! -f "$FLAG_FILE" ]; then
	exit 0
fi

# Remove flag file
rm $FLAG_FILE

# Clear bash history
if [ -f "/root/.bash_history" ]; then
	cat /dev/null	> /root/.bash_history
fi

for user_dir in /home/*
do
	if [ ! -d "$user_dir" ] || [ ! -f "$user_dir/.bash_history" ]; then
		continue
	fi

	# Clean bash history
	cat /dev/null > $user_dir/.bash_history 
done

echo "Bash history cleaned"
