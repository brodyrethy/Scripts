#!/bin/bash
#
# By: Brody Rethy
# Website: https://rethy.xyz
#
# Name: backup_dotfiles.sh
# Version: 1.0
#
# Summary:
# Used for backing up system dotfiles to
# dotfiles directory ($HOME/repos/dotfiles).
#
# Requires one argument defining the device,
# being a desktop or laptop system, as some
# configs differ between system to system.
#
# TODO: Make dotfiles path variable
#

FILES=(
".bash_aliases"
".bash_profile"
".bashrc"
".config/dunst/dunstrc"
".config/mpd/mpd.conf"
".config/ncmpcpp/bindings"
".config/ncmpcpp/config"
".config/picom/picom.conf"
".config/qutebrowser/config.py"
".config/qutebrowser/quickmarks"
".config/ranger/rc.conf"
".config/ranger/rifle.conf"
".newsboat/config"
".vimrc"
)

for FILE in ${FILES[@]}; do
	clear
	/usr/bin/diff "$HOME/repos/dotfiles/$FILE" "$HOME/$FILE"

	echo "Are you sure you want to replace $HOME/$FILE with file found in $HOME/repos/dotfiles/$FILE? (y/n)"
	read CHOICE

	if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y"  ]; then
		/usr/bin/cp -R $HOME/repos/dotfiles/$FILE $HOME/$FILE 2> /dev/null && echo ":: Backup of $FILE to $HOME/repos/dotfiles/$FILE successful" || echo ":: $FILE not found, skipping"
	else
		echo ":: Passing on $FILE"
	fi
done

exit 0

