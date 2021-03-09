#!/usr/bin/python3
import os, random, getpass, sys

def main():
    all_files = []

    username = get_system_username()

    paths = ["architecture", "painting", "city", "computer", "fractals", "game", "landscape", "music", "psy", "space", "math", "orthodoxy"]

    sub_folder = random.choice(paths)

    path = "/home/" + username + "/pix/wallpapers/" + sub_folder + "/"

    for x in files(path):
        all_files.append(x)

    wallpaper = random.choice(all_files)

    os.system("feh --bg-fill " + path + str(wallpaper))

def files(path):
    for x in os.listdir(path):
        if os.path.isfile(os.path.join(path, x)):
            yield x

def get_system_username():
    return getpass.getuser()

main()
