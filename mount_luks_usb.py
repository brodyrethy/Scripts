#!/usr/bin/python3
import os

os.system("lsblk")

drive = str(input("drive to mount (/dev/sd?? format): "))
mount_point = str(input("mount point: "))

os.system("sudo cryptsetup luksOpen " + drive + " encrypted_drive")
os.system("sudo mount /dev/mapper/encrypted_drive " + mount_point)


main()
