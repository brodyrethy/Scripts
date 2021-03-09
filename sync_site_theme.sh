#!/bin/bash

DIRS=(
"computing"
"geography"
"literature"
"programming"
"working_on"
"history"
"music"
"my_life"
"visual_media"
)

if [ "$1" = "desktop" ]
then
    DRIVE="500GigDrive1"
elif [ "$1" = "laptop" ]
then
    DRIVE="1TBDrive"
else
    echo ":: Device does not exist"; exit 1
fi

for DIR in ${DIRS[@]}
do
	{
    /usr/bin/cp $HOME/$DRIVE/repos/rethy.xyz/style.css $HOME/$DRIVE/repos/rethy.xyz/$DIR/style.css
    /usr/bin/echo "/usr/bin/cp $HOME/$DRIVE/repos/rethy.xyz/style.css $HOME/$DRIVE/repos/rethy.xyz/$DIR/style.css"
	} > /dev/null 2>&1 && echo "Copied style.css to ~/$DRIVE/repos/rethy.xyz/$DIR/style.css" || echo ":: Failed to copy style.css to ~/$DRIVE/repos/rethy.xyz/$DIR/style.css"
done
