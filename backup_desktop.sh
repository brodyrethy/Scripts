#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: backup_desktop.sh
#	Version: 1.0
#
#	Summary:
#	A backup script to backup my docs. Should
#	backup to /var/log/backups.log file.
#

FILES=("repos" "docs" "notes" "pix")
DATE=$(date +'### --- %D at %T --- ###')
LOG_PATH="/var/log/backups.log"

if [ ! -w $LOG_PATH ]
then
	touch "$LOG_PATH" || sudo touch "$LOG_PATH"
	/usr/bin/sudo chmod 664 "$LOG_PATH"; sudo chown -R $USER:wheel "$LOG_PATH";
fi

echo "$DATE" >> $LOG_PATH

for FILE in ${FILES[@]}
do
	{ notify-send ":: Backing up $FILE"; rsync --progress -avru $HOME/500GigDrive1/$FILE/ $HOME/500GigDrive3/desktop/$FILE; } >> $LOG_PATH && notify-send ":: Backup of $FILE successful"
done

/usr/bin/printf "### --- END OF BACKUP --- ###\n\n\n" >> $LOG_PATH

notify-send "Great success!"

exit 0
