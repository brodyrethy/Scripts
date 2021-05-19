#!/bin/bash
STORAGE_DEVICES=$(lsblk | awk '{print $1}' | grep -e "└─" -e "├─" | sed -e "s/└─//g" -e "s/├─//g")
STORAGE_DEVICE_LETTER=$(echo "$STORAGE_DEVICES" | dmenu -i -p "Which drive do you want to mount?")

if [ -a "/dev/$STORAGE_DEVICE_LETTER" ]; then
    /usr/bin/sudo mount "/dev/$STORAGE_DEVICE_LETTER"
else
    echo "Nope"
fi

#if [ $(echo -e "No\nYes" | dmenu -i -p "Do you want to shut down?") == "Yes" ]; then
#    echo "askdljhaskdljh"
#fi

