#!/usr/bin/python3
import os

os.system("lsblk")

drive = str(input("\nDrive to mount (/dev/sd?? format): "))
mount_point = str(input("\nMount point: "))

os.system("sudo mount " + drive + " " + mount_point)
