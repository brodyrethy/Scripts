#!/bin/bash

# Check if there are args given
if [ $# -eq 0 ]
then
	echo ":: No file or directory given"; exit 1
fi



# Set first arg as variable FILE 
#
# I'll make this more than just one arg in the future.
#
FILE=$1

# Get date and time
#
# There's probably a better way to do this. It works for now.
# I may want to refactor this later.
#
CURRENT_DATE=$(date +"%m-%d at %R" | sed -e 's/ /_/g' -e 's/-/_/g' -e 's/:/_/g')

TRASH_DIR="$HOME/.Trash/files/"



if [ ! -e $FILE ]
then
	echo ":: File given does not exist"; exit 1
fi



# check if ~/.Trash/files doesn't exists
if [ ! -d $TRASH_DIR ]
then
	mkdir -p $TRASH_DIR
fi



# Check if file/dir already exists
if [ -e $TRASH_DIR/$1 ]
then
	mv $FILE ${CURRENT_DATE}_${1}
	FILE=${CURRENT_DATE}_${1}
fi



# Move file to ~/.Trash/files
mv -iv $FILE $TRASH_DIR


# A successful exit, it gets here
exit 0
