#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: backup_dotfiles.sh
#	Version: 1.0
#
#	Summary:
#	Used for backing up system dotfiles to 
#	dotfiles directory (~/repos/dotfiles).
#
#	Requires one argument defining the device,
#	being a desktop or laptop system, as some
#	configs differ between system to system.
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
".vim/keybindings.vim"
".vimrc"
)

for FILE in ${FILES[@]}
do
	/usr/bin/diff "$HOME/repos/dotfiles/$FILE" "$HOME/$FILE" 

	echo "Are you sure you want to replace $FILE file found in ~/repos/dotfiles? (y/n)"
	read CHOICE

	if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ]
	then
		/usr/bin/cp -R "$HOME/$FILE" "$HOME/repos/dotfiles/$FILE"
		clear
	else
		clear
		echo ":: Passed on $FILE"
	fi
done

exit 0
