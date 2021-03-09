#!/bin/bash

if [ "$1" = "Desktop" ] || [ "$1" = "desktop" ]
then
	DEVICE="500GigDrive1"
elif [ "$1" = "Laptop" ] || [ "$1" = "laptop" ] 
then
	DEVICE="1TBDrive"
elif [ -v "$1" ]
	echo ":: No device name given (insert laptop, or desktop)"; exit 1
else
	echo ":: Device name not found (insert laptop, or desktop)"; exit 1
fi

FILES=(
"computing"
"geography"
"history"
"literature"
"music"
"my_life"
"programming"
"visual_media"
)

echo "downloads.html" > $HOME/$DEVICE/repos/rethy.xyz/sitemap.html
echo "sitemap.html" >> $HOME/$DEVICE/repos/rethy.xyz/sitemap.html
echo "term_definitions.html" >> $HOME/$DEVICE/repos/rethy.xyz/sitemap.html
echo "about_me.html" >> $HOME/$DEVICE/repos/rethy.xyz/sitemap.html
echo "about_this_website.html" >> $HOME/$DEVICE/repos/rethy.xyz/sitemap.html

for FILE in ${FILES[@]}
do
	/usr/bin/ls $HOME/$DEVICE/repos/rethy.xyz/$FILE/*.html >> $HOME/$DEVICE/repos/rethy.xyz/sitemap.html
done
