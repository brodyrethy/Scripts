#!/usr/bin/python3
import sys, getpass

def main():
    files = [".config/ranger/rc.conf", ".config/mpd/mpd.conf", ".config/ncmpcpp/config", ".bash_aliases"]

    username = get_username()
    
    try:
        device = sys.argv[1]
    except IndexError:
        quit(":: insert a device name (laptop or desktop)")

    device = device.lower()
    print(device)

    if (device == "laptop"):
        for filename in files:
            find_and_replace(filename, "500GigDrive0", "1TBDrive", username)
            find_and_replace(filename, "500GigDrive1", "1TBDrive", username)
    elif (device == "desktop"):
        for filename in files:
            find_and_replace(filename, "1TBDrive", "500GigDrive1", username)
            find_and_replace(filename, "500GigDrive1/music", "500GigDrive0/music", username)
            find_and_replace(filename, "500GigDrive1/visual_media", "500GigDrive0/visual_media", username)
    else:
        quit(":: not a valid device")

def find_and_replace(filename, find, replace, username):
    f = open("/home/" + username + "/" + filename, 'r')
    filedata = f.read()
    f.close()

    newdata = filedata.replace(find, replace)

    f = open("/home/" + username + "/" + filename, 'w')
    f.write(newdata)
    f.close()

def get_username():
    username = getpass.getuser()
    return username

main()
