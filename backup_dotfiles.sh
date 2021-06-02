#!/bin/bash
#
# By: Brody Rethy
# Website: https://rethy.xyz
#
# Name: backup_dotfiles.sh
#
# Summary:
# Used for backing up system dotfiles to dotfiles directory
#

DOTFILES_REPO="$HOME/Documents/Repositories/dotfiles"

# File list goes here (defined from perspective of $HOME variable).
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
	/usr/bin/diff -n "$DOTFILES_REPO/$FILE" "$HOME/$FILE"

	/usr/bin/printf "Replace \"%s\" found in ~/%s? (y/n)\n" $FILE $DOTFILES_REPO

	read -r CHOICE

	case "$CHOICE" in
		y | Y)
            /usr/bin/cp -R "$HOME/$FILE" "$DOTFILES_REPO/$FILE"
            clear
        ;;

		*)
            clear
            /usr/bin/printf ":: Passed on $FILE.\n"
        ;;
	esac
done

/usr/bin/printf "All done.\n"; exit 0
