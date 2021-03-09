#!/bin/bash

#/usr/bin/ls $HOME/repos/ezrecipe.xyz/recipes/*.html >> $HOME/repos/ezrecipe.xyz/sitemap.html
PAGES=$(/usr/bin/ls $HOME/repos/ezrecipe.xyz/recipes/*.html)

echo "<p>Press Ctrl+f to search through recipes</p>" > $HOME/repos/ezrecipe.xyz/sitemap.html
echo "<p>" >> $HOME/repos/ezrecipe.xyz/sitemap.html
echo "<ol>" >> $HOME/repos/ezrecipe.xyz/sitemap.html

for PAGE in ${PAGES[@]}
do
	grep -m 1 "<img src='https://www.allrecipes.com/img/misc/og-default.png'>" $PAGE > /dev/null 2>&1 && DEFAULT_IMAGE="True" || DEFAULT_IMAGE="False"

	if [ $DEFAULT_IMAGE = "True" ]
	then
		/usr/bin/rm "$PAGE" > /dev/null 2>&1 && echo ":: Removed $PAGE with no image"
	else
		{
		TITLE=$(grep -m 1 '<title>' "$PAGE")
		TITLE=$(echo "$TITLE" | sed --expression='s/<title>//g' --expression='s/<\/title>//g')
		echo "<li><a href="$PAGE">$TITLE</a></li>" >> $HOME/repos/ezrecipe.xyz/sitemap.html
		} > /dev/null 2>&1 && echo ":: Copied $PAGE to ~/repos/ezrecipe.xyz/sitemap.html"
	fi
done

echo "</ol>" >> $HOME/repos/ezrecipe.xyz/sitemap.html
echo "</p>" >> $HOME/repos/ezrecipe.xyz/sitemap.html
