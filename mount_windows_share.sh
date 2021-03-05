#!/bin/bash

echo "Windows share username?"
read WIN_USERNAME

echo "IP address?"
read WIN_IP_ADDRESS

echo "Mount point?"
read MOUNT_POINT

echo "Share name?"
read WIN_SHARE_NAME

/usr/bin/sudo /usr/bin/mount -t cifs -o username=$WIN_USERNAME //$WIN_IP_ADDRESS/$WIN_SHARE_NAME $MOUNT_POINT
