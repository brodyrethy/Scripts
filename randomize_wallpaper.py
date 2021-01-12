#!/usr/bin/python3
import os, random, getpass, sys

def main():
    all_files = []

    device = sys.argv

    if (len(device) < 2):
        quit(":: insert your device")

    device.pop(0) # remove the filename
    device = device[0]

    username = get_system_username()

    paths = ["architecture", "painting", "city", "computer", "fractals", "game", "landscape", "music", "psy", "space", "math", "orthodoxy"]

    sub_folder = random.choice(paths)

    if (device == "laptop"):
        path = "/home/" + username + "/1TBDrive/pictures/wallpapers/" + sub_folder + "/"
    elif (device == "desktop"):
        path = "/home/" + username + "/500GigDrive1/pictures/wallpapers/" + sub_folder + "/"
    else:
        quit(":: insert your device")
    
    for x in files(path):
        all_files.append(x)

    wallpaper = random.choice(all_files)

    os.system("wal -i " + path + str(wallpaper))

def files(path):
    for x in os.listdir(path):
        if os.path.isfile(os.path.join(path, x)):
            yield x

def get_system_username():
    return getpass.getuser()

main()
