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
#	dotfiles directory ($HOME/repos/dotfiles).
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
		/usr/bin/cp $HOME/repos/dotfiles/.config/config.h_desktop $HOME/.config/dwm/config.h 2> /dev/null && echo ":: Backup of rc.xml to $HOME/repos/dotfiles/.config/config.h_desktop sucessful" || echo ":: Couldn't backup config.h_desktop"
		/usr/bin/cp $HOME/repos/dotfiles/.config/rc.xml_desktop $HOME/.config/openbox/rc.xml 2> /dev/null && echo ":: Backup of rc.xml to $HOME/repos/dotfiles/.config/rc.xml_desktop sucessful" || echo ":: Couldn't backup rc.xml"
	   	;;
	laptop)
		/usr/bin/cp $HOME/repos/dotfiles/.config/config.h_e550 $HOME/.config/dwm/config.h 2> /dev/null && echo ":: Backup of config.h_e550 to $HOME/repos/dotfiles/.config/config.h_e550 sucessful" || echo "Couldn't backup config.h_e550" 
		/usr/bin/cp $HOME/repos/dotfiles/.config/rc.xml_e550 $HOME/.config/openbox/rc.xml 2> /dev/null && echo ":: Backup of rc.xml to $HOME/repos/dotfiles/.config/rc.xml_e550 sucessful" || echo ":: Couldn't backup rc.xml"
		;;
	*)
		echo ':: Insert device'; echo 'Example: ./backup_dotfiles.sh desktop'; exit 1 ;;
esac

#/usr/bin/rm $HOME/repos/dotfiles/.config/dwm/config.h 2> /dev/null

for FILE in ${FILES[@]}
do
	clear
	/usr/bin/diff "$HOME/repos/dotfiles/$FILE" "$HOME/$FILE" 

	echo "Are you sure you want to replace $HOME/$FILE with file found in $HOME/repos/dotfiles/$FILE? (y/n)"
	read CHOICE

	if [ $CHOICE = "y" ] || [ $CHOICE = "Y"  ]
	then
		/usr/bin/cp -R $HOME/repos/dotfiles/$FILE $HOME/$FILE 2> /dev/null && echo ":: Backup of $FILE to $HOME/repos/dotfiles/$FILE successful" || echo ":: $FILE not found, skipping"
	else
		echo ":: Passing on $FILE"
	fi
done

exit 0

