#!/bin/bash

git clone https://github.com/brodyrethy/dotfiles ~/dotfiles

sudo chown -R $USER:$USER -R ~

sudo mkdir -p ~/.fonts
sudo mkdir -p ~/.config/mpc
sudo mkdir -p ~/.vim/undodir
sudo mkdir -p ~/.Trash
sudo mkdir -p ~/.Trash/files

sudo cp -R ~/dotfiles/.fonts ~/
sudo cp -R ~/dotfiles/.config/ranger ~/.config
sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config

sudo cp ~/dotfiles/inputrc /etc/
sudo cp ~/dotfiles/nobeep.conf /etc/modprobe.d/
sudo cp ~/dotfiles/pulseaudio.service /etc/systemd/system/

sudo cp ~/dotfiles/.xinitrc ~/
sudo cp ~/dotfiles/.bash_aliases ~/
sudo cp ~/dotfiles/.bash_profile ~/
sudo cp ~/dotfiles/.vimrc ~/
sudo cp ~/dotfiles/.bashrc ~/

sudo apt install ranger vim curl irssi newsboat fuse cifs-utils rsync sshfs python-pip python3-pip -y

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
