#!/bin/bash
#
# By: Brody Rethy
# Website: https://rethy.xyz
#
# Name: sync_dotfiles.sh
#
# Summary:
# Used for backing up system dotfiles to dotfiles directory (defined as
# variable).
#

PATH_TO_DOTFILES="$HOME/Documents/Repositories/dotfiles"

FILES_TO_COPY=(
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

clear

for FILE in "${FILES_TO_COPY[@]}"; do
	/usr/bin/diff "$PATH_TO_DOTFILES/$FILE" "$HOME/$FILE"

    printf "Do you want to replace \"%s/%s\" with \"%s/%s\"? (y/n)\n" \
    "$HOME" "$FILE" "$PATH_TO_DOTFILES" "$FILE"

	read -r CHOICE

    case "$CHOICE" in
        y | Y)
            clear

            /usr/bin/cp -R "$PATH_TO_DOTFILES/$FILE" "$HOME/$FILE" 2> /dev/null \
            && printf ":: Backup of \"%s\" to %s/%s successful.\n" "$FILE" "$HOME" "$FILE" \
            || printf ":: \"%s\" not found, skipping\n" "$FILE"
        ;;
    esac
done

exit 0

