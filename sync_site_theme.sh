#!/bin/bash

WEBSITE_DIRECTORY="Documents/Repositories/rethy.xyz"

SUB_DIRECTORIES=(
"computing"
"geography"
"literature"
"working_on"
"history"
"music"
"music/albums"
"my_life"
"visual_media"
)

for DIRECTORY in ${SUB_DIRECTORIES[@]}
do
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/style.css $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/style.css
    /usr/bin/rm $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/files/bigblue_terminalplus.ttf
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/menu.php $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/menu.php
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/header.php $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/header.php
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/footer.php $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/footer.php
done
