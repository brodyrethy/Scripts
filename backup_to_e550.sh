#!/bin/bash

main() {
	server_status=$(ping -c 4 192.168.1.105 > /dev/null && echo "True" || echo "False")

	if [[ server_status ]];
	then
		notify-send "Backing up notes"
		rsync -arvup /home/brody/1TBDrive/notes/ /mnt/thewired_desktop/500GigDrive1/notes

		notify-send "Backing up music"
		rsync -arvup /home/brody/1TBDrive/music/ /mnt/thewired_desktop/500GigDrive0/music

		notify-send "Backing up visual_media"
		rsync -arvup /home/brody/1TBDrive/visual_media/ /mnt/thewired_desktop/500GigDrive0/visual_media
	else
		notify-send 'Backup failed: server cannot be reached.'
	fi
}

main
