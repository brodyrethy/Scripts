#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: sync_dotfiles.sh
#	Version: 1.0
#
#	Summary:
#	Used for syncing up system dotfiles to
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

case "$1" in
	desktop)
		/usr/bin/cp ~/repos/dotfiles/.config/config.h_desktop ~/.config/dwm/config.h 2> /dev/null && echo ":: Backup of config.h ~/.config/config.h sucessful" || echo "Couldn't replace current config.h"
	   	;;
	laptop)
		/usr/bin/cp ~/repos/dotfiles/.config/config.h_e550 ~/.config/dwm/config.h 2> /dev/null && echo ":: Backup of config.h ~/.config/config.h sucessful" || echo "Couldn't replace current config.h"
		;;
	*)
		echo ':: Insert device'; echo 'Example: ./backup_dotfiles.sh desktop'; exit 1
		;;
esac

for PATH in ${PATHS[@]}
do
	/usr/bin/cp -R ~/repos/dotfiles/$PATH ~/$PATH 2> /dev/null && echo ":: Copying of $PATH to ~/repos/dotfiles/$PATH successful" || echo ":: $PATH copy failed"
done

/usr/bin/rm ~/repos/dotfiles/.config/dwm/config.h 2> /dev/null

exit 0
