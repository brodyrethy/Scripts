#!/bin/bash

SSH_IP_ADDRESS="192.168.1.105"
SSH_PORT="22"
SSH_USER="brody"
DEVICE=$1
ACTION=""
PATHS_DESKTOP=(
""
)
# I use a slightly different directory hierarchy
# on my desktop, having four 500GB secondary HDDs instead
# of a single 1TB HDD (or 2TB).
PATHS_DESKTOP=(
"~/500GigDrive1/pix"
"~/500GigDrive1/notes"
"~/500GigDrive1/repos"
"~/500GigDrive1/docs"
"~/500GigDrive0/music"
"~/500GigDrive0/vids"
""
)

# This is redundant trash, but it good and works for now.
#
# What device are you on?
echo "What device are you on? "
read DEVICE

echo "What do you want to do?"
echo "1) to and fro"
echo "2) fro and to"
read ACTION

# to and from (To other machine, from this machine)
if [ $DEVICE = "laptop" ] && [ $ACTION = 1 ] # to and fo
then
	asd
elif [ $DEVICE = "laptop" ] && [ $ACTION = 2 ] # fro and to
then
	asd
elif [ $DEVICE = "desktop" ] && [ $ACTION = 1 ] 
then
	asd
elif [ $DEVICE = "desktop" ] && [ $ACTION = 2 ]
	asd
elif [ $DEVICE = laptop ] && [ $ACTION = 1 ]
then
	asd
elif [ $DEVICE = "laptop" ] && [ $ACTION = "fro and to" ]
then
	asd
elif [ $DEVICE = "desktop" ] && [ $ACTION = "to and fo" ]
then
	asd
elif [ $DEVICE = "desktop" ] && [ $ACTION = "fro and to" ]
then
	asd
else
	asd
fi

# Mount
sudo sshfs -p $SSH_PORT -o allow_other $SSH_USER@$SSH_IP_ADDRESS:$HOME/$SSH_USER/ /mnt/ && echo ":: Mounted $SSH_IP_ADDRESS to $DIR" || echo ":: Failed to mount $SSH_IP_ADDRESS"
