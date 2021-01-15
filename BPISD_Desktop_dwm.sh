#!/bin/bash

get_dotfiles() {
    git clone https://github.com/brodyrethy/dotfiles ~/dotfiles
}

mk_dirs() {
    sudo mkdir -p ~/.config/mpc
	sudo mkdir -p ~/vim/undodir
	sudo mkdir -p /mnt/thewired_server
}

mv_files_and_dirs() {
	#THIS COMMAND MUST BE RUN FIRST TO GET config.h
	sudo cp ~/dotfiles/.config/config.h_desktop ~/dotfiles/.config/dwm/config.h

	sudo cp -R ~/dotfiles/.fonts ~/
    sudo cp -R ~/dotfiles/.config/dwm ~/.config/
    sudo cp -R ~/dotfiles/.config/mpd ~/.config/
    sudo cp -R ~/dotfiles/.config/ranger ~/.config/
    sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config/
    sudo cp -R ~/dotfiles/.config/st ~/.config/

    sudo cp ~/dotfiles/inputrc /etc/
    sudo cp ~/dotfiles/grub /etc/default/
    sudo cp ~/dotfiles/sources.list /etc/apt/
    sudo cp ~/dotfiles/nobeep.conf /etc/modprobe.d/
    sudo cp ~/dotfiles/pulseaudio.service /etc/systemd/system/

    sudo cp ~/dotfiles/.xinitrc ~/
    sudo cp ~/dotfiles/.Xdefaults ~/
	sudo cp ~/dotfiles/.bash_aliases ~/
    sudo cp ~/dotfiles/.bash_profile ~/
    sudo cp ~/dotfiles/.vimrc ~/.vimrc
    sudo cp ~/dotfiles/.bashrc ~/.bashrc
}

echo_data() {
	#.xinitrc
	echo "/home/$USER/scripts/dwmbar_desktop &" >> ~/.xinitrc
	echo "xrandr --output HDMI-0 --left-of DVI-I-1 &" >> ~/.xinitrc
	echo "exec dwm" >> ~/.xinitrc
}

download_and_install_programs() {
    sudo apt update -y
    sudo apt install ranger feh xinit vim lxappearance x11-xserver-utils pulseaudio curl mpd mpc ncmpcpp firefox-esr xinput python3-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler gparted libax25-dev libukwm-1-dev python3-pip mercurial python-dev python3-dev ruby ruby-dev libx11-dev libxt-dev libncurses5 ncurses-dev sshfs nvidia-driver pulsemixer suckless-tools rsync compton -y
    sudo pip3 install youtube-dl
}

compile_py3_vim() {
    git clone https://github.com/vim/vim ~/vim
    cd ~/vim
    ./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
    make && sudo make install
    sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
}

install_vim_plug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
   
enable_services() {
    sudo systemctl enable mpd
    sudo systemctl enable pulseaudio
}

update_grub2() {
    sudo update-grub2
}

remove_nano() {
    sudo apt purge nano youtube-dl -y && sudo apt remove nano youtube-dl -y
}

apply_ownership() {
    sudo chown $USER:$USER -R ~
}

main() {
    get_dotfiles
    apply_ownership
    mk_dirs
    mv_files_and_dirs
    apply_ownership
	echo_data
    download_and_install_programs
    compile_py3_vim
    install_vim_plug
    install_light
    enable_services
    remove_nano
    apply_ownership
    update_grub2

	/home/$USER/scripts/convert_configs_for_device.py "desktop"
}

main
