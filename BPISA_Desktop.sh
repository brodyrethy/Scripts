#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: BPISA_desktop.sh
#	Version: 1.0
#
#	Summary:
#	Used for backing up system dotfiles to 
#	dotfiles directory (~/repos/dotfiles).
#
#	Requires one argument defining the device,
#	being a desktop or laptop system, as some
#	configs differ between system to system.
#

git clone https://github.com/rethyxyz/dotfiles ~/dotfiles

# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~

# These are bad ideas
PATHS=("/etc/inputrc" "/etc/modprobe.d/nobeep.conf" "/etc/systemd/system/pulseaudio.service")

for PATH in ${PATHS[@]}
do
	/usr/bin/sudo chmod 777 $PATH && echo ""
	/usr/bin/sudo chown -R $USER:wheel $PATH && echo ":: chown $USER:wheel sucessful" || echo ":: chown $USER:wheel failed" 
done



# Mk files and dirs
/usr/bin/sudo /usr/bin/mkdir -p /mnt/
/usr/bin/sudo /usr/bin/mkdir -p ~/.Trash/files
/usr/bin/sudo /usr/bin/mkdir -p ~/.config/mpd/playlists
/usr/bin/sudo /usr/bin/mkdir -p ~/.fonts
/usr/bin/sudo /usr/bin/mkdir -p ~/.vim/undodir
/usr/bin/sudo /usr/bin/mkdir -p ~/500GigDrive{0,1,2,3}

/usr/bin/sudo /usr/bin/touch /etc/modprobe.d/nobeep.conf
/usr/bin/sudo /usr/bin/touch /etc/systemd/system/pulseaudio.serviceS



# Setup dotfiles
/usr/bin/sudo cp ~/dotfiles/.config/config.h_desktop ~/dotfiles/.config/dwm/config.h
/usr/bin/sudo cp ~/dotfiles/.bash_aliases ~/
/usr/bin/sudo cp ~/dotfiles/.bash_profile ~/
/usr/bin/sudo cp ~/dotfiles/.vimrc ~/
/usr/bin/sudo cp ~/dotfiles/.bashrc ~/
/usr/bin/sudo cp ~/dotfiles/.vim/macros.vim ~/.vim/macros.vim

/usr/bin/sudo cp -R ~/dotfiles/.config/dunst ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/dwm ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/mpd ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/qutebrowser ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/ranger ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.config/st ~/.config/
/usr/bin/sudo cp -R ~/dotfiles/.fonts ~/
/usr/bin/sudo cp -R ~/dotfiles/.newsboat/ ~/

## Drive shouldn't have to be mounted to make symlinks
ln -sf ~/500GigDrive0/music ~/music
ln -sf ~/500GigDrive0/vids ~/vids
ln -sf ~/500GigDrive1/docs ~/docs
ln -sf ~/500GigDrive1/notes ~/notes
ln -sf ~/500GigDrive1/pix ~/pix
ln -sf ~/500GigDrive1/repos ~/repos



# echo data into files
## .xinitrc
echo "xinput --set-prop 12 'libinput Accel Speed' -1 &" > ~/.xinitrc
echo "setxkbmap -option caps:escape &" >> ~/.xinitrc
echo "xset r rate 200 50 &" >> ~/.xinitrc
echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
echo "dwmbar_desktop.sh &" >> ~/.xinitrc
echo "dunst &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc

## inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc

## nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

## pulseaudio.service
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
/usr/bin/sudo pacman -Syu dmenu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp firefox python3 python-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs light dos2unix picom dunst libnotify ranger -y

/usr/bin/sudo pip3 install youtube-dl ueberzug

## ranger
git clone https://github.com/ranger/ranger ~/ranger
cd ~/ranger
/usr/bin/sudo make clean install

git clone https://github.com/vim/vim ~/vim
cd ~/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3



# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# Enable services
/usr/bin/sudo systemctl enable mpd
/usr/bin/sudo systemctl enable pulseaudio



/usr/bin/sudo pacman -R nano youtube-dl -y



# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~



cd ~/.config/dwm && /usr/bin/sudo make clean install
cd ~/.config/st && /usr/bin/sudo make clean install



python3 /home/$USER/scripts/convert_configs_for_device.py "laptop"

exit 0
