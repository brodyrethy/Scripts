#!/bin/bash

get_dotfiles() {
    git clone https://github.com/brodyrethy/dotfiles ~/dotfiles
	wget "https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb"
}

apply_ownership() {
    sudo chown $USER:$USER -R ~
}

mk_dirs() {
    sudo mkdir -p ~/.fonts
    sudo mkdir -p ~/.config/mpc
    sudo mkdir -p ~/1TBDrive
	sudo mkdir -p /mnt/thewired_server
}

mv_files_to_dirs() {
    #THIS COMMAND MUST RUN FIRST
	cp ~/dotfiles/.config/config_e550 ~/dotfiles/.config/i3/config 

	sudo cp -R ~/dotfiles/.fonts ~/
    sudo cp -R ~/dotfiles/.config/mpd ~/.config
    sudo cp -R ~/dotfiles/.config/ranger ~/.config
    sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config
	sudo cp -R ~/dotfiles/.config/i3 ~/.config
	sudo cp -R ~/dotfiles/.config/i3blocks ~/.config

    sudo cp ~/dotfiles/inputrc /etc/
    sudo cp ~/dotfiles/grub /etc/default/
    sudo cp ~/dotfiles/sources.list /etc/apt/
    sudo cp ~/dotfiles/nobeep.conf /etc/modprobe.d/
    sudo cp ~/dotfiles/pulseaudio.service /etc/systemd/system/

    sudo cp ~/dotfiles/.xinitrc ~/
    sudo cp ~/dotfiles/.Xdefaults ~/
    sudo cp ~/dotfiles/.bash_aliases ~/
    sudo cp ~/dotfiles/.bash_profile ~/
    sudo cp ~/dotfiles/.vimrc ~/
    sudo cp ~/dotfiles/.bashrc ~/
}

echo_data() {
	#.xinitrc
	echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
	echo "" >> ~/.xinitrc
	echo "exec i3" >> ~/.xinitrc
}

get_programs() {
	sudo apt update -y
	sudo apt install i3 i3blocks ranger rxvt-unicode-256color network-manager feh xinit vim lxappearance x11-xserver-utils pulseaudio curl mpd mpc ncmpcpp firefox-esr xinput python3-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler gparted firmware-iwlwifi mercurial python-dev python3-dev ruby ruby-dev libx11-dev libxt-dev libncurses5 ncurses-dev -y
	sudo pip3 install pywal
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

install_light() {
    sudo dpkg -i light_1.2_amd64.deb
}

enable_services() {
    sudo systemctl enable mpd
    sudo systemctl enable pulseaudio
    sudo systemctl enable network-manager
}

update_grub2() {
    sudo update-grub2
}

rm_programs() {
    sudo apt purge youtube-dl nano -y && sudo apt remove youtube-dl nano -y
}

clean_up() {
    sudo chown $USER:$USER -R /sys/class/backlight/intel_backlight/brightness
}

get_and_enable_bitmap_fonts() {
	git clone https://github.com/Tecate/bitmap-fonts
	cd bitmap-fonts
	sudo cp -avr bitmap/ /usr/share/fonts
	xset fp+ /usr/share/fonts/bitmap
	fc-cache -fv
	cd /etc/fonts/conf.d/
	sudo rm /etc/fonts/conf.d/10*  
	sudo rm -rf 70-no-bitmaps.conf 
	sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
	sudo dpkg-reconfigure fontconfig
}

main() {
    get_dotfiles
    apply_ownership
    mk_dirs
    mv_files_to_dirs
    apply_ownership
	echo_data
    get_programs
    compile_py3_vim
    install_vim_plug
    install_light
    enable_services
	rm_programs
    apply_ownership
    update_grub2
    clean_up

	~/scripts/convert_configs_for_device.py "laptop"
}

main
