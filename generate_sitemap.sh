#!/bin/bash

PATH_TO_SITE="$HOME/Documents/Repositories/rethy.xyz"

SITEMAP_FILE_NAME="sitemap.php"

FILES=(
"computing"
"geography"
"history"
"literature"
"music"
"music/albums"
"my_life"
"visual_media"
)

/usr/bin/printf "downloads.php" > $PATH_TO_SITE/$SITEMAP_FILE_NAME
/usr/bin/printf "$SITEMAP_FILE_NAME" >> $PATH_TO_SITE/$SITEMAP_FILE_NAME
/usr/bin/printf "term_definitions.php" >> $PATH_TO_SITE/$SITEMAP_FILE_NAME
/usr/bin/printf "about_me.php" >> $PATH_TO_SITE/$SITEMAP_FILE_NAME
/usr/bin/printf "about_this_website.php" >> $PATH_TO_SITE/$SITEMAP_FILE_NAME

for FILE in ${FILES[@]}; do
	/usr/bin/ls $PATH_TO_SITE/$FILE/*.php >> $PATH_TO_SITE/$SITEMAP_FILE_NAME
done
