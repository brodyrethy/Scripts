#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: Brody's Post-Installation Scripts for Arch: Desktop Edition
#	Version: 1.0
#
#	Summary:
#	A script to automate my post-installation process after
#	installing Arch Linux.
#
#	Installs and sets up dwm, ranger, bash aliases, qutebrowser,
#	vim, programs, daemons (services), and more.
#

git clone https://github.com/rethyxyz/dotfiles ~/dotfiles

# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~

# This is a bad idea, but they MAY work.
# Well, lets hope they do.
#
# Makes non-normal files (need root privileges).
PATHS=(
"/etc/inputrc"
"/etc/modprobe.d/nobeep.conf"
"/etc/systemd/system/pulseaudio.service"
)
for PATH in ${PATHS[@]}
do
	# Make file is it doesn't exist
	if [ ! -f $PATH ]
	then
		touch $PATH
	fi
	/usr/bin/sudo chmod 777 $PATH && echo "" # rwx for everyone!
	/usr/bin/sudo chown -R $USER:wheel $PATH && echo ":: chown $USER:wheel sucessful" || echo ":: chown $USER:wheel failed" # change owner and group
done

# Make dirs
PATHS=("~/.Trash/files" "~/.config/mpd/playlists" "~/.fonts" "~/.vim/undodir" "~/500GigDrive{0,1,2,3}")
for PATH in ${PATHS[@]}
do
	/usr/bin/sudo /usr/bin/mkdir -p $PATH
done

# copy dwm's config.h
/usr/bin/sudo /usr/bin/cp ~/dotfiles/.config/config.h_desktop ~/dotfiles/.config/dwm/config.h

# Copy from dotfiles directory
PATHS=(".config/dunst" ".config/dwm" ".config/mpd" ".config/ncmpcpp" ".config/qutebrowser" ".config/ranger" ".config/st" ".fonts" ".newsboat/" ".bash_aliases" ".bash_profile" ".vimrc" ".bashrc" ".vim/macros.vim")
for PATH in $PATHS
do
	/usr/bin/sudo /usr/bin/cp -R $PATH
done

# Make symlinks
PATHS=("music" "vids" "docs" "notes" "pix" "repos")
for PATH in ${PATHS[@]}
do
	/usr/bin/ln -sf $PATH
done

# Echo data into files.
#	It's easier than having multiple files in my dotilfes repo.
## For .xinitrc
echo "xinput --set-prop 12 'libinput Accel Speed' -1 &" > ~/.xinitrc
echo "setxkbmap -option caps:escape &" >> ~/.xinitrc
echo "xset r rate 200 50 &" >> ~/.xinitrc
echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
echo "dwmbar_desktop.sh &" >> ~/.xinitrc
echo "dunst &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc
## For inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc
## For nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
## For pulseaudio.service
echo "[Unit]" > /etc/systemd/system/pulseaudio.service
echo "Description=PulseAudio Daemon" >> /etc/systemd/system/pulseaudio.service
echo "" >> /etc/systemd/system/pulseaudio.service
echo "[Install]" >> /etc/systemd/system/pulseaudio.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/pulseaudio.service
echo "" >> /etc/systemd/system/pulseaudio.service
echo "[Service]" >> /etc/systemd/system/pulseaudio.service
echo "Type=simple" >> /etc/systemd/system/pulseaudio.service
echo "PrivateTmp=true" >> /etc/systemd/system/pulseaudio.service
echo "ExecStart=/usr/bin/pulseaudio --system --realtime --disallow" >> /etc/systemd/system/pulseaudio.service

# Install programs
/usr/bin/sudo /usr/bin/pacman -Syu dmenu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp firefox python3 python-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs light dos2unix picom dunst libnotify ranger -y
/usr/bin/sudo pip3 install youtube-dl ueberzug
## ranger
git clone https://github.com/ranger/ranger ~/ranger
cd ~/ranger
/usr/bin/sudo make clean install
## Vim
git clone https://github.com/vim/vim ~/vim
cd ~/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
## Install vim-plug
/usr/bin/curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Enable services
/usr/bin/sudo systemctl enable mpd
/usr/bin/sudo systemctl enable pulseaudio

# Remove
/usr/bin/sudo /usr/bin/pacman -R nano youtube-dl -y

# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~

# Compile suckless programs
cd ~/.config/dwm && /usr/bin/sudo make clean install
cd ~/.config/st && /usr/bin/sudo make clean install

python3 /home/$USER/scripts/convert_configs_for_device.py "laptop"

exit 0
