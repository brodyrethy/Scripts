#!/bin/bash

WEBSITE_DIRECTORY="Documents/Repositories/rethy.xyz"

SUB_DIRECTORIES=(
"computing"
"geography"
"history"
"literature"
"music"
"music/albums"
"my_life"
"visual_media"
"working_on"
)

for DIRECTORY in ${SUB_DIRECTORIES[@]}; do
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/footer.php $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/footer.php
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/header.php $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/header.php
    /usr/bin/cp $HOME/$WEBSITE_DIRECTORY/style.css $HOME/$WEBSITE_DIRECTORY/$DIRECTORY/style.css
done
