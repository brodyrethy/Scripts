#!/bin/bash

#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: backup_desktop.sh
#
#	Summary:
#	A backup script to backup my docs. Should
#	backup to /var/log/backups.log file.
#

LOG_PATH="/var/log/backups.log"
DATE=$(date +'### --- %D at %T --- ###')
DESTINATION="last_backup"
FILES=("repos" "docs" "notes" "pix")
FILE_DATE=$(date +'%D_at_%T' | sed -e 's/\//-/g'  -e 's/:/_/g')

if [[ ! -w $LOG_PATH ]]
then
	touch "$LOG_PATH" || sudo touch "$LOG_PATH"
	/usr/bin/sudo chmod 664 "$LOG_PATH"; sudo chown -R $USER:wheel "$LOG_PATH";
fi

echo "$DATE" >> $LOG_PATH

if [[ ! -d $HOME/backup1/$DESTINATION ]]
then
	mkdir $HOME/backup1/$DESTINATION || /usr/bin/sudo mkdir $HOME/backup1/$DESTINATION
fi

for FILE in ${FILES[@]}
do
	{ /usr/bin/notify-send "Backing up $FILE"; rsync --delete --progress -avru $HOME/500GigDrive1/$FILE/ $HOME/backup1/$DESTINATION/$FILE; } >> $LOG_PATH && notify-send "Successful"
done

/usr/bin/zip -r "$HOME/backup1/$FILE_DATE.zip" "$HOME/backup1/$DESTINATION/"

/usr/bin/printf "### --- END OF BACKUP --- ###\n\n\n" >> $LOG_PATH

notify-send "Great success!"

exit 0
