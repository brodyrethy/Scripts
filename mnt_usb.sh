#!/bin/bash

lsblk

echo "Drive to mount?"
read DRIVE

echo "Mount point?"
read MOUNT_POINT

sudo mount $DRIVE $MOUNT_POINT
