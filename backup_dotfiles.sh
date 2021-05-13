#!/bin/bash
#
# By: Brody Rethy
# Website: https://rethy.xyz
#
# Name: backup_dotfiles.sh
# Version: 1.0
#
# Summary:
# Used for backing up system dotfiles to dotfiles directory 
# (~/Documents/Repositories/dotfiles).
#
# Requires one argument defining the device, being a desktop or laptop system, 
# as some configs differ between system to system.

# File list goes here (taken from the perspective of $HOME variable).
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
DOTFILES_REPO="Documents/Repositories/dotfiles"

for FILE in ${FILES[@]}; do
	/usr/bin/diff -n "$HOME/$DOTFILES_REPO/$FILE" "$HOME/$FILE"

	/usr/bin/echo "Replace \"$FILE\" found in ~/$DOTFILES_REPO? (y/n)"
	read CHOICE

	case "$CHOICE" in
		y | Y)
            /usr/bin/cp -R "$HOME/$FILE" "$HOME/$DOTFILES_REPO/$FILE"
            clear
            ;;
		*)
            clear
            /usr/bin/echo ":: Passed on $FILE."
            ;;
	esac
done

/usr/bin/echo "All done."; exit 0
