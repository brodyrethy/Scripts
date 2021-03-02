#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: recycle_bin.sh
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
	echo ":: No file or directory given"; exit 1
fi


# Check if file given exists
if [ ! -e $FILE ]
then
	echo ":: File given does not exist"; exit 1
fi



# Set first arg as variable FILE.
# I'll make this more than just one arg in the future.
FILE=$1
# Get date and time. There's probably a better way to do this.
# It works for now. I may want to refactor this later.
CURRENT_DATE_FORMAT=$(date +"%m-%d at %R" | sed -e 's/ /_/g' -e 's/-/_/g' -e 's/:/_/g')
TRASH_DIR="$HOME/.Trash/files/"



# Check age of first file/dir in Trash dir
# if older than 30 days, remove
# TODO



# check if ~/.Trash/files doesn't exists
if [ ! -d $TRASH_DIR ]
then
	mkdir -p $TRASH_DIR
fi



# Check if file/dir already exists
#
# I know that there is an option built into mv
# to prompt if I want to override, but I think this is safer,
# as you can't accidentally accept to overriding important files.
if [ -e $TRASH_DIR/$1 ]
then
	mv $FILE ${CURRENT_DATE_FORMAT}_${1}
	FILE=${CURRENT_DATE_FORMAT}_${1}
fi



# Check if file needs root



# Move file to ~/.Trash/files
#
mv -iv "$FILE" $TRASH_DIR



# A successful exit, it gets here
exit 0
