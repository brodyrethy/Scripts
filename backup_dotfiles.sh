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

PATHS=(
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

case $1 in
	desktop)
		/usr/bin/cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_desktop 2> /dev/null && echo ":: Backup of config.h_desktop to ~/repos/dotfiles/.config/config.h_desktop sucessful" || echo ":: Couldn't backup config.h_desktop"
	   	;;
	laptop)
		/usr/bin/cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_e550 2> /dev/null && echo ":: Backup of config.h_e550 to ~/repos/dotfiles/.config/config.h_e550 sucessful" || echo "Couldn't backup config.h_e550" 
		;;
	*)
		echo ':: Insert device'; echo 'Example: ./backup_dotfiles.sh desktop'; exit 1 ;;
esac

for PATH in ${PATHS[@]}
do
	/usr/bin/cp -R ~/$PATH ~/repos/dotfiles/$PATH 2> /dev/null && echo ":: Backup of $PATH to ~/repos/dotfiles/$PATH successful" || echo ":: $PATH not found, skipping"
done

/usr/bin/rm ~/repos/dotfiles/.config/dwm/config.h 2> /dev/null

exit 0
