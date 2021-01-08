#!/bin/bash
#
# BPISD for Desktopss: dwm Edition
#  _____
# |  __ \  GitHub: https://github.com/brodyrethy
# | |__) | 
# |  _  /  
# | | \ \  
# |_|  \_\ Website: https://rethy.xyz
#
# Description:
# BPISD is a post-installation script to set up Debian 9/10.
# In this case, i3wm is the wm installed. The configs used
# are the ones I've made over the years.
#

create_dirs_and_files () {
	sudo mkdir -p /mnt/thewired_server
	sudo mkdir -p ~/.config
	sudo mkdir -p ~/.config/mpc
	sudo mkdir -p ~/.config/mpd/playlists

	sudo touch ~/.config/mpd/mpd.db
	sudo touch ~/.config/mpd/mpd.log
}

move_dirs_and_files () {
	#Move i3 desktop config to i3 dir
	cp /home/$USER/dotfiles/.config/config_desktop /home/$USER/dotfiles/.config/i3/config 
	#To ~/.config/...
	sudo cp -R /home/$USER/dotfiles/.config/i3 /home/$USER/.config
	sudo cp -R /home/$USER/dotfiles/.config/mpd /home/$USER/.config
	sudo cp -R /home/$USER/dotfiles/.config/ranger /home/$USER/.config
	sudo cp -R /home/$USER/dotfiles/.config/ncmpcpp /home/$USER/.config
	sudo cp -R /home/$USER/dotfiles/.config/i3blocks /home/$USER/.config
	#To /etc/...
	sudo cp /home/$USER/dotfiles/.config/grub /etc/default/
	sudo cp /home/$USER/dotfiles/.config/inputrc /etc/
	sudo cp /home/$USER/dotfiles/.config/sources.list /etc/apt/
	sudo cp /home/$USER/dotfiles/.config/.Xdefaults /home/$USER/
	sudo cp /home/$USER/dotfiles/.config/.vimrc /home/$USER/
	sudo cp /home/$USER/dotfiles/.config/.bashrc /home/$USER/
	sudo cp /home/$USER/dotfiles/.config/.xinitrc_desktop_i3 /home/$USER/.xinitrc
	sudo cp /home/$USER/dotfiles/.config/.bash_aliases /home/$USER/
	sudo cp /home/$USER/dotfiles/.config/.bash_profile /home/$USER/
	sudo cp /home/$USER/dotfiles/.config/nobeep.conf /etc/modprobe.d/
	sudo cp /home/$USER/dotfiles/.config/pulseaudio.service /etc/systemd/system/
}

get_programs () {
	sudo apt update -y
	sudo apt install i3 i3blocks ranger rxvt-unicode-256color feh xinit vim lxappearance x11-xserver-utils pulseaudio curl mpd mpc ncmpcpp firefox-esr xinput python3-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler gparted nvidia-driver mercurial python-dev python3-dev ruby ruby-dev libx11-dev libxt-dev libncurses5 ncurses-dev -y
	sudo pip3 install pywal

	echo "Do you want to install texlive-full? (0 or 1)"
	read answer

	if [$answer == 1]
	then
		sudo apt install texlive-full -y
	fi
}

get_vim-py3 () {
	git clone https://github.com/vim/vim ~/vim
	cd ~/vim
	./configure \
	--enable-perlinterp \
	--enable-python3interp \
	--enable-rubyinterp \
	--enable-cscope \
	--enable-gui=auto \
	--enable-gtk2-check \
	--enable-gnome-check \
	--with-features=huge \
	--enable-multibyte \
	--with-x \
	--with-compiledby="xorpd" \
	--with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
	--prefix=/opt/vim74
	make && sudo make install
	sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
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

get_vim_plug () {
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

get_i3_gaps_deb () {
	git clone https://github.com/maestrogerardo/i3-gaps-deb ~/i3-gaps-deb
	~/i3-gaps-deb/i3-gaps-deb
}

enable_services () {
	sudo systemctl enable pulseaudio
	sudo systemctl enable mpd
}

update_grub2 () {
	#Update grub
	sudo update-grub2
}

remove_nano () {
	#The most important step
	sudo apt purge nano -y && sudo apt remove nano -y
}


chown_home () {
	sudo chown $USER:$USER -R ~
}

main () {
	chown_home
	create_dirs_and_files
	move_dirs_and_files
	get_programs
	get_vim-py3
	get_and_enable_bitmap_fonts
	get_vim_plug
	get_i3_gaps_deb
	enable_services
	update_grub2
	remove_nano
	chown_home
}

main