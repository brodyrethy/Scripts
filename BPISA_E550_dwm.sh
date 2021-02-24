#!/bin/bash
git clone https://github.com/rethyxyz/dotfiles ~/dotfiles



# Set proper permissions
sudo chown $USER:wheel -R ~



# Mkdirs
sudo mkdir -p ~/.fonts
sudo mkdir -p ~/1TBDrive
sudo mkdir -p ~/.vim/undodir
sudo mkdir -p ~/.Trash/files
sudo mkdir -p /mnt/



# Setup dotfiles
sudo cp ~/dotfiles/.config/config.h_e550 ~/dotfiles/.config/dwm/config.h
sudo cp ~/dotfiles/.bash_aliases ~/
sudo cp ~/dotfiles/.bash_profile ~/
sudo cp ~/dotfiles/.vimrc ~/
sudo cp ~/dotfiles/.bashrc ~/
sudo cp ~/dotfiles/.vim/macros.vim ~/.vim/macros.vim

sudo cp -R ~/dotfiles/.config/dwm ~/.config/
sudo cp -R ~/dotfiles/.config/mpd ~/.config/
sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config/
sudo cp -R ~/dotfiles/.config/qutebrowser ~/.config/
sudo cp -R ~/dotfiles/.config/ranger ~/.config/
sudo cp -R ~/dotfiles/.config/st ~/.config/
sudo cp -R ~/dotfiles/.fonts ~/
sudo cp -R ~/dotfiles/.newsboat/ ~/

## Drive shouldn't have to be mounted to make symlinks
ln -sf ~/1TBDrive/docs ~/docs
ln -sf ~/1TBDrive/notes ~/notes
ln -sf ~/1TBDrive/pix ~/pix
ln -sf ~/1TBDrive/repos ~/repos
ln -sf ~/1TBDrive/vids ~/vids



# echo data into files
## set perms
sudo chown -R brody:wheel /etc/inputrc 
sudo chown -R brody:wheel /etc/modprobe.d/nobeep.conf
sudo chown -R brody:wheel /etc/systemd/system/pulseaudio.service
sudo chmod 755 /etc/inputrc 
sudo chmod 755 /etc/modprobe.d/nobeep.conf
sudo chmod 755 /etc/systemd/system/pulseaudio.service

## .xinitrc
echo "setxkbmap -option caps:escape &" > ~/.xinitrc
echo "xset r rate 200 50 &" >> ~/.xinitrc
echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
echo "dwmbar_e550.sh &" >> ~/.xinitrc
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
sudo pacman -Syu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp firefox python3 python-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs light dos2unix ntfs-3g -y
sudo pip3 install youtube-dl ueberzug

git clone https://github.com/ranger/ranger ~/ranger
cd ~/ranger
sudo make clean install



# Vim with py3 interpreter
git clone https://github.com/vim/vim ~/vim
cd ~/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && sudo make install
sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3



# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# Enable services
sudo systemctl enable mpd
sudo systemctl enable pulseaudio



sudo pacman -R nano youtube-dl -y



# Set proper permissions
sudo chown $USER:wheel -R ~



cd ~/.config/dwm && sudo make clean install
cd ~/.config/st && sudo make clean install



sudo chown $USER:wheel -R /sys/class/backlight/intel_backlight/brightness



python3 /home/$USER/scripts/convert_configs_for_device.py "laptop"
