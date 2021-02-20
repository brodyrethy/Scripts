import os

files = [".fonts", ".newsboat/urls", ".newsboat/config", ".config/ncmpcpp/bindings", ".config/ncmpcpp/config", ".config/ranger/rc.conf", ".config/ranger/rifle.conf", ".config/mpd/mpd.conf", ".config/qutebrowser/config.py", ".config/qutebrowser/quickmarks", ".config/st/config.h", ".bash_aliases", ".bash_profile", ".bashrc", ".vimrc"]

for file in files:
    print("cp -r /mnt/home/brody/" + file + " ~/" + file)
    os.system("cp -r /mnt/home/brody/" + file + " ~/" + file)
