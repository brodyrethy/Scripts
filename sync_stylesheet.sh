#!/bin/bash

PATH_TO_WEBSITE_DIRECTORY="$HOME/Documents/Repositories/rethy.xyz"

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

FILES_TO_COPY=(
"footer.php"
"header.php"
"style.css"
)

for SUB_DIRECTORY in "${SUB_DIRECTORIES[@]}"; do
    for FILE in "${FILES_TO_COPY[@]}"; do
        /usr/bin/cp "$PATH_TO_WEBSITE_DIRECTORY/$FILE" "$PATH_TO_WEBSITE_DIRECTORY/$SUB_DIRECTORY/$FILE" 2> /dev/null \
            && /usr/bin/printf "Copied to \"$PATH_TO_WEBSITE_DIRECTORY/$SUB_DIRECTORY/$FILE\" successfully.\n" \
            || /usr/bin/printf "Failed to copy to \"$PATH_TO_WEBSITE_DIRECTORY/$SUB_DIRECTORY/$FILE\".\n"
    done
done
