FILES=(
"repos"
"docs"
"notes"
"pix"
)

for FILE in ${FILES[@]}
do
	{ notify-send ":: Backing up $FILE"; rsync -aru $HOME/500GigDrive1/$FILE/ $HOME/500GigDrive3/desktop/$FILE; } && notify-send ":: Backup of $FILE successful"
done

exit 0
