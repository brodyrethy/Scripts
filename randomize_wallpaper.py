#!/usr/bin/python3
import os, random, getpass

def main():
    username = get_system_username()
    all_files = []

    paths = ["architecture", "painting", "city", "computer", "fractals", "game", "landscape", "music", "psy", "space", "math", "orthodoxy"]

    sub_folder = random.choice(paths)

    path = "/home/" + username + "/1TBDrive/pictures/wallpapers/" + sub_folder + "/"
    
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
