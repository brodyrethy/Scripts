#!/bin/bash
#
# BPISD for ThinkPad E550s: i3 Edition
#  _____
# |  __ \  GitHub: https://github.com/rethyxyz
# | |__) | 
# |  _  /  
# | | \ \  
# |_|  \_\ Website: https://rethy.xyz
#
# Description:
# BPISD_e550_i3 is a post-installation script to set up Debian 9/10.
# In this case, i3wm is the wm installed. The configs used 
# are the ones I've made and have used over the years.
#

get_dotfiles () {
    git clone https://github.com/brodyrethy/dotfiles ~/dotfiles
	wget "https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb"
}

apply_ownership () {
    sudo chown $USER:$USER -R ~
}

create_dirs () {
    sudo mkdir -p ~/.fonts
    sudo mkdir -p ~/.config/mpc
    sudo mkdir -p ~/1TBDrive
	sudo mkdir -p /mnt/thewired_server
}

move_files_to_dirs () {
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

echo_data () {
	#mpd
	echo 'music_directory "~/1TBDrive/Music"' >> ~/.config/mpd/mpd.conf

	#ncmpcpp
	echo 'mpd_music_dir = "~/1TBDrive/Music"' >> ~/.config/ncmpcpp/config

	#rc.conf
	echo "" >> ~/.config/ranger/rc.conf
	echo "#Changing directories" >> ~/.config/ranger/rc.conf
	echo "map gM cd ~/1TBDrive/Music" >> ~/.config/ranger/rc.conf
	echo "map gb cd ~/1TBDrive/Books" >> ~/.config/ranger/rc.conf
	echo "map gl cd ~/1TBDrive/LaTeX" >> ~/.config/ranger/rc.conf
	echo "map ghh cd ~/1TBDrive/GitHub" >> ~/.config/ranger/rc.conf
	echo "map gp cd ~/1TBDrive/Pictures" >> ~/.config/ranger/rc.conf
	echo "map gP cd ~/1TBDrive/Programming" >> ~/.config/ranger/rc.conf
	echo "map gv cd ~/1TBDrive/Visual Media" >> ~/.config/ranger/rc.conf
	echo "map ghs cd ~/1TBDrive/GitHub Storage" >> ~/.config/ranger/rc.conf
	echo "map gw cd ~/1TBDrive/Pictures/Wallpapers" >> ~/.config/ranger/rc.conf
	echo "map gm cd ~/1TBDrive/Visual Media/Movies" >> ~/.config/ranger/rc.conf
	echo "map gn cd ~/1TBDrive/GitHub Storage/Notes" >> ~/.config/ranger/rc.conf
	echo "map gho cd ~" >> ~/.config/ranger/rc.conf
	echo "map gd cd ~/Downloads" >> ~/.config/ranger/rc.conf
	echo "map gD cd ~/Documents" >> ~/.config/ranger/rc.conf
	echo "map gMn cd /mnt" >> ~/.config/ranger/rc.conf

	#.bash_aliases
	echo "" >> ~/.bash_aliases
	echo "#Changing directories" >> ~/.bash_aliases
	echo "alias gM='cd ~/1TBDrive/Music'" >> ~/.bash_aliases
	echo "alias gb='cd ~/1TBDrive/Books'" >> ~/.bash_aliases
	echo "alias gl='cd ~/1TBDrive/LaTeX'" >> ~/.bash_aliases
	echo "alias ghh='cd ~/1TBDrive/GitHub'" >> ~/.bash_aliases
	echo "alias gp='cd ~/1TBDrive/Pictures'" >> ~/.bash_aliases
	echo "alias gP='cd ~/1TBDrive/Programming'" >> ~/.bash_aliases
	echo "alias gv='cd ~/1TBDrive/Visual Media'" >> ~/.bash_aliases
	echo "alias ghs='cd ~/1TBDrive/GitHub Storage'" >> ~/.bash_aliases
	echo "alias gw='cd ~/1TBDrive/Pictures/Wallpapers'" >> ~/.bash_aliases
	echo "alias gm='cd ~/1TBDrive/Visual Media/Movies'" >> ~/.bash_aliases
	echo "alias gn='cd ~/1TBDrive/GitHub Storage/Notes'" >> ~/.bash_aliases

	#.xinitrc
	echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
	echo "" >> ~/.xinitrc
	echo "exec i3" >> ~/.xinitrc

	#.vimrc
	echo "let g:vimwiki_list = [{'path': '~/1TBDrive/GitHub Storage/Notes'}]" >> ~/.vimrc
}

get_programs () {
	sudo apt update -y
	sudo apt install i3 i3blocks ranger rxvt-unicode-256color network-manager feh xinit vim lxappearance x11-xserver-utils pulseaudio curl mpd mpc ncmpcpp firefox-esr xinput python3-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler gparted firmware-iwlwifi mercurial python-dev python3-dev ruby ruby-dev libx11-dev libxt-dev libncurses5 ncurses-dev -y
    sudo apt purge youtube-dl
	sudo pip3 install pywal
}

compile_py3_vim () {
    git clone https://github.com/vim/vim ~/vim
    cd ~/vim
    ./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
    make && sudo make install
    sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
}

install_vim_plug () {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_light () {
    sudo dpkg -i ~/dotfiles/light_1.2_amd64.deb
}

enable_services () {
    sudo systemctl enable mpd
    sudo systemctl enable pulseaudio
    sudo systemctl enable network-manager
}

update_grub2 () {
    sudo update-grub2
}

remove_nano () {
    sudo apt purge nano && sudo apt remove nano
}

compile_dwm_and_st () {
	cd ~/.config/dwm && sudo make clean install
	cd ~/.config/st && sudo make clean install
}

clean_up () {
    sudo chown $USER:$USER -R /sys/class/backlight/intel_backlight/brightness
}

get_and_enable_bitmap_fonts () {
	git clone https://github.com/Tecate/bitmap-fonts.git ~/bitmap-fonts
	cd ~/bitmap-fonts
	sudo cp -avr bitmap/ /usr/share/fonts
	xset fp+ /usr/share/fonts/bitmap
	fc-cache -fv
	cd /etc/fonts/conf.d/
	sudo rm /etc/fonts/conf.d/10*  
	sudo rm -rf 70-no-bitmaps.conf 
	sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
	sudo dpkg-reconfigure fontconfig
}

get_i3_gaps_deb () {
	git clone https://github.com/maestrogerardo/i3-gaps-deb ~/i3-gaps-deb
	~/i3-gaps-deb/i3-gaps-deb
}

main () {
    get_dotfiles
    apply_ownership
    create_dirs
    move_files_to_dirs
    apply_ownership
	echo_data
    get_programs
    compile_py3_vim
    install_vim_plug
    install_light
    enable_services
    remove_nano
    get_i3_gaps_deb
    apply_ownership
    update_grub2
	compile_dwm_and_st
    clean_up
}

main
