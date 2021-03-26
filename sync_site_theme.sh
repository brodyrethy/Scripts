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

for DIR in ${DIRS[@]}
do
	{
    /usr/bin/cp $HOME/repos/rethy.xyz/style.css $HOME/repos/rethy.xyz/$DIR/style.css
    /usr/bin/echo "/usr/bin/cp $HOME/repos/rethy.xyz/style.css $HOME/repos/rethy.xyz/$DIR/style.css"
	} > /dev/null 2>&1 && echo "Copied style.css to ~/repos/rethy.xyz/$DIR/style.css" || echo ":: Failed to copy style.css to ~/repos/rethy.xyz/$DIR/style.css"
done
