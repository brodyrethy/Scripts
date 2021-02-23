import os

def main():
    if (check_if_host_up()):
        display_notification("Backing up notes")
#        backup("/home/brody/1TBDrive/notes/", "/mnt/thewired_desktop/500GigDrive1/notes")

        display_notification("Backing up music")
#        backup("/home/brody/1TBDrive/music/", "/mnt/thewired_desktop/500GigDrive0/music")

        display_notification("Backing up visual_media")
#        backup("/home/brody/1TBDrive/visual_media/", "/mnt/thewired_desktop/500GigDrive0/visual_media")
    else:
        os.system("notify-send 'Backup failed: server cannot be reached.'")

def check_if_host_up():
    stdout = os.system('ping -c 4 192.168.1.105 > /dev/null && echo "True" || echo "False"')
    stdout = bool(stdout)
    return stdout

def backup(source, destination):
    # check for slash "/" at end of destination, if so, remove it
    os.system("rsync -arvup " + source + "/ " + destination)

def display_notification(message):
    os.system("notify-send '"+ message + "'")

main()