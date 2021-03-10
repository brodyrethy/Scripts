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
".vim/macros.vim"
".bash_profile"
".bashrc"
".config/dunst/dunstrc"
".config/mpd/mpd.conf"
".config/ncmpcpp/bindings"
".config/ncmpcpp/config"
".config/qutebrowser/config.py"
".config/qutebrowser/quickmarks"
".config/ranger/rc.conf"
".config/ranger/rifle.conf"
".newsboat/config"
".vimrc"
)

case "$1" in
	desktop)
		/usr/bin/cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_desktop
		/usr/bin/cp ~/.config/openbox/rc.xml ~/repos/dotfiles/.config/rc.xml_desktop
	   	;;
	laptop)
		/usr/bin/cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_e550
		/usr/bin/cp ~/.config/openbox/rc.xml ~/repos/dotfiles/.config/rc.xml_e550
		;;
	*)
		echo ':: Insert device'; echo 'Example: ./backup_dotfiles.sh desktop'; exit 1;;
esac

/usr/bin/rm ~/repos/dotfiles/.config/dwm/config.h 2> /dev/null

for FILE in ${FILES[@]}
do
	/usr/bin/diff -q "$HOME/repos/dotfiles/$FILE" "$HOME/$FILE" 

	echo "Are you sure you want to replace $FILE file found in ~/repos/dotfiles? (y/n)"
	read CHOICE

	if [ $CHOICE = "y" ] || [ $CHOICE = "Y"  ]
	then
		/usr/bin/cp -R ~/$FILE ~/repos/dotfiles/$FILE 2> /dev/null && echo ":: Backup of $FILE to ~/repos/dotfiles/$FILE successful" || echo ":: $FILE not found, skipping"
	else
		echo ":: Passing on $FILE"
	fi

	clear
done

exit 0
