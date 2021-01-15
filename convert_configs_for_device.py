import sys

def main():
    files = ["~/.config/ranger/rc.conf", "~/.config/mpd/mpd.conf", "~/.config/ncmpcpp/config"]
    
    try:
        device = sys.argv[1]
    except IndexError:
        quit(":: insert a device name (laptop or desktop)")

    device = device.lower()
    print(device)

    if (device == "laptop"):
        for filename in files:
            find_and_replace(filename, "500GigDrive0", "1TBDrive")
            find_and_replace(filename, "500GigDrive1", "1TBDrive")
    elif (device == "desktop"):
        for filename in files:
            find_and_replace(filename, "1TBDrive", "500GigDrive1")
            find_and_replace(filename, "500GigDrive1/music", "500GigDrive0/music")
            find_and_replace(filename, "500GigDrive1/visual_media", "500GigDrive0/visual_media")
    else:
        quit(":: not a valid device")

def find_and_replace(filename, find, replace):
    f = open(filename, 'r')
    filedata = f.read()
    f.close()

    newdata = filedata.replace(find, replace)

    f = open(filename, 'w')
    f.write(newdata)
    f.close()

main()
