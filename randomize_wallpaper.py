#!/usr/bin/python3
import os, random, getpass

def main():
    username = get_system_username()
    all_files = []

    paths = ["anime", "architecture", "art", "city", "computer", "fractals", "game", "landscape", "music", "psy", "space"]
    sub_folder = random.choice(paths)

    path = "/home/" + username + "/1TBDrive/pictures/wallpapers/" + sub_folder + "/"
    
    for file in files(path):
        all_files.append(file)

    wallpaper = random.choice(all_files)

    os.system("feh --bg-fill " + path + str(wallpaper))

def files(path):
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file

def get_system_username():
    return getpass.getuser()

main()


