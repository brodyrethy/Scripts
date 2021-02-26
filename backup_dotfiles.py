import sys, os

device = argv[1]

if (device == "desktop"):
    os.system("sudo cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_e550")
elif (device == "laptop"):
    os.system("sudo cp ~/.config/dwm/config.h ~/repos/dotfiles/.config/config.h_e550")
else:
    quit(":: not a valid device")

os.system("sudo cp -R ~/.fonts ~/repos/dotfiles/")

os.system("sudo cp -R ~/.config/dwm ~/repos/dotfiles/.config/")
os.system("sudo rm ~/repos/dotfiles/.config/dwm/config.h")

os.system("sudo cp -R ~/.config/mpd/mpd.conf ~/repos/dotfiles/.config/mpd/mpd.conf")

os.system("sudo cp -R ~/.config/ranger/rc.conf ~/repos/dotfiles/.config/ranger/rc.conf")
os.system("sudo cp -R ~/.config/ranger/rifle.conf ~/repos/dotfiles/.config/ranger/rifle.conf")

os.system("sudo cp -R ~/.config/ncmpcpp ~/repos/dotfiles/.config/")
os.system("sudo cp -R ~/.config/st ~/repos/dotfiles/.config/")

os.system("sudo cp /etc/inputrc ~/repos/dotfiles/inputrc")
os.system("sudo cp /etc/default/grub ~/repos/dotfiles/grub")
os.system("sudo cp /etc/apt/sources.list ~/repos/dotfiles/sources.list")
os.system("sudo cp /etc/modprobe.d/nobeep.conf  ~/repos/dotfiles/nobeep.conf")
os.system("sudo cp /etc/systemd/system/pulseaudio.service ~/repos/dotfiles/pulseaudio.service")

os.system("sudo cp ~/.xinitrc  ~/repos/dotfiles/.xinitrc")
os.system("sudo cp ~/.Xdefaults ~/repos/dotfiles/.Xdefaults")
os.system("sudo cp ~/.bash_aliases ~/repos/dotfiles/.bash_aliases")
os.system("sudo cp ~/.bash_profile ~/repos/dotfiles/.bash_profile")
os.system("sudo cp ~/.vimrc ~/repos/dotfiles/.vimrc")
os.system("sudo cp ~/.bashrc ~/repos/dotfiles/.bashrc")
