#!/bin/bash

find_and_replace() {
	# 1:file 2:find 3:replace
	NEW_DATA=$(/usr/bin/sed -i "s/$2/$3/g" $1)
}

main() {
	# Get the device type (either desktop or laptop), and convert to lowercase
	DEVICE=$(/usr/bin/echo $1 | /usr/bin/tr '[:upper:]' '[:lower:]')
	# A list of FILES to convert between
	FILES=(
	"$HOME/.config/mpd/mpd.conf"
	"$HOME/.config/ncmpcpp/config"
	"$HOME/.config/ranger/rc.conf"
   	"$HOME/.bash_aliases"
   	"$HOME/.bash_profile"
   	"$HOME/.vimrc"
	)

	case "$DEVICE" in
		laptop) 
			for FILE in ${FILES[@]}
			do
				{
				find_and_replace $FILE "500GigDrive0" "1TBDrive"
				find_and_replace $FILE "500GigDrive1" "1TBDrive"
				} > /dev/null 2>&1 && echo ":: Done with $FILE" || echo ":: Error, skipped $FILE"
			done
			;;
		desktop)
			for FILE in ${FILES[@]}
			do
				{
				find_and_replace $FILE "1TBDrive" "500GigDrive1"
				find_and_replace $FILE "500GigDrive1\/music" "500GigDrive0\/music"
				find_and_replace $FILE "500GigDrive1\/visual_media" "500GigDrive0\/visual_media"
				find_and_replace $FILE "500GigDrive1\/anime" "500GigDrive0\/anime"
				find_and_replace $FILE "500GigDrive1\/youtube" "500GigDrive0\/youtube"
				} > /dev/null 2>&1 && echo ":: Done with $FILE" || echo ":: Error, skipped $FILE"
			done
			;;
		*)
			/usr/bin/echo ":: Enter a valid device name (laptop, or desktop)"; exit 1
			;;
	esac

	echo ":: All done"; exit 0
}

main $1
