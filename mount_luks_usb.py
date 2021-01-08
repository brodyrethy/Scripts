#!/usr/bin/python3
import os

def main():
    os.system("lsblk")

    drive_letter = get_input("drive to mount (/dev/sd?? format): ")
    mount_point = get_input("mount point: ")

    os.system("sudo cryptsetup luksOpen " + drive_letter + " encrypted_drive")
    os.system("sudo mount /dev/mapper/encrypted_drive " + mount_point)

def get_input(msg):
    while (True):
        user_input = str(input(msg))
        if (not user_input):
            print(":: not a valid entry")
        break
    return user_input

main()
