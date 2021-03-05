#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: rethyxyz_recycle_bin.sh
#	Version: 1.0
#
#	Summary:
#	A script to imitate the Windows recycle bin.
#   It still needs to implement some features, such
#	as file compression, but I'm working on it.
#

# Check if there are args given
if [ $# -eq 0 ]
then
	echo ":: No file(s) given"; exit 1
fi

FILES=( "$@" )

for FILE in "${FILES[@]}"
do
	# Check if file given exists
	if [ ! -e "$FILE" ]
	then
		echo ":: File given does not exist"; exit 1
	fi

	# Get date and time. There's probably a better way to do this.
	# It works for now. I may want to refactor this later.
	FILE_NUM=0
	TRASH_DIR="$HOME/.Trash/files/"

	# Check age of first file/dir in Trash dir
	# if older than 30 days, remove
	# TODO

	# check if ~/.Trash/files doesn't exists
	if [ ! -d $TRASH_DIR ]
	then
		mkdir -p "$TRASH_DIR"
	fi

	# check size of file in megabytes
	SIZE=$(du -h -s -m "$FILE" | awk '{print $1}')

	# This is somewhat of a hack job
	if [ $SIZE -gt 20000 ]
	then
		echo ":: File is $SIZE, over 20GB, and is too large for the recycle bin"
		echo "Do you still want to remove it (this is permanent)? (y/n)"

		while true
		do
			read CHOICE

			case "$CHOICE" in
				y)
					/usr/bin/rm -rf "$FILE" || echo ":: Permissions failed, run this program as root"
					exit 1
					;;
				n)
					echo ":: Exiting, file not removed"
					exit 0
					;;
				*) echo ":: Choice not recognized, try again"
			esac
		done
	fi

	# Check if file/dir already exists
	#
	# I know that there is an option built into mv
	# to prompt if I want to override, but I think this is safer,
	# as you can't accidentally accept to overriding important files.
	NEW_FILE=$FILE

	while true
	do
		if [ -e "$TRASH_DIR/$NEW_FILE" ]
		then
			FILE_NUM=$((FILE_NUM+1))
			NEW_FILE="${FILE_NUM}_${FILE}"

			echo "$FILE_NUM_$FILE"
		else
			mv "$FILE" "$NEW_FILE" && echo ":: Renamed file" || echo ":: Passed"
			FILE=$NEW_FILE
			break
		fi
	done

	# Check if file needs root

	# Move file to ~/.Trash/files
	#
	mv -iv "$FILE" $TRASH_DIR
done

# A successful exit, if it gets here
exit 0
