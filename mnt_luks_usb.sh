#!/bin/bash

# display available drives
lsblk

echo "What drive do you want to mount (/dev/sd?? format)?"
read DRIVE

echo "What mount point (/mnt, /media, /home/$USER/mount_point)?"
read MOUNT_POINT

if [ ! -d "$MOUNT_POINT" ]
then
	echo "$MOUNT_POINT doesn't exist"; exit 1;
fi

sudo cryptsetup luksOpen $DRIVE encrypted_drive
sudo mount /dev/mapper/encrypted_drive "$MOUNT_POINT"
