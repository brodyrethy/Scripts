#!/bin/bash
#
# BPISA for E550s: dwm Edition
#  _____
# |  __ \  GitHub: https://github.com/brodyrethy
# | |__) | 
# |  _  /  
# | | \ \  
# |_|  \_\ Website: https://rethy.xyz
#
# Description:
# BPISA is a post-installation script to set up Arch Linux.
# In this case, dwm is the wm installed. The configs used
# are the ones I've made and used over the years.
#

get_dotfiles () {
    git clone https://github.com/brodyrethy/dotfiles ~/dotfiles
}

apply_ownership () {
    sudo chown -R $USER:wheel -R ~
}

create_dirs () {
    sudo mkdir -p ~/.fonts
    sudo mkdir -p ~/1TBDrive
    sudo mkdir -p ~/.config/mpc
	sudo mkdir -p ~/.vim/undodir
	sudo mkdir -p ~/.Trash
}

move_files_to_dirs () {
	sudo cp ~/dotfiles/.config/config.h_e550 ~/dotfiles/.config/dwm/config.h

	sudo cp -R ~/dotfiles/.fonts ~/
    sudo cp -R ~/dotfiles/.config/dwm ~/.config/
    sudo cp -R ~/dotfiles/.config/mpd ~/.config
    sudo cp -R ~/dotfiles/.config/ranger ~/.config
    sudo cp -R ~/dotfiles/.config/ncmpcpp ~/.config
    sudo cp -R ~/dotfiles/.config/st ~/.config/

    sudo cp ~/dotfiles/inputrc /etc/
    sudo cp ~/dotfiles/grub /etc/default/
    sudo cp ~/dotfiles/sources.list /etc/apt/
    sudo cp ~/dotfiles/nobeep.conf /etc/modprobe.d/
    sudo cp ~/dotfiles/pulseaudio.service /etc/systemd/system/

    sudo cp ~/dotfiles/.xinitrc ~/
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
	echo "map gv cd ~/1TBDrive/Visual\ Media" >> ~/.config/ranger/rc.conf
	echo "map ghs cd ~/1TBDrive/GitHub\ Storage" >> ~/.config/ranger/rc.conf
	echo "map gw cd ~/1TBDrive/Pictures/Wallpapers" >> ~/.config/ranger/rc.conf
	echo "map gm cd ~/1TBDrive/Visual\ Media/Movies" >> ~/.config/ranger/rc.conf
	echo "map gn cd ~/1TBDrive/GitHub\ Storage/Notes" >> ~/.config/ranger/rc.conf
	echo "map gho cd ~" >> ~/.config/ranger/rc.conf
	echo "map gd cd ~/Downloads" >> ~/.config/ranger/rc.conf
	echo "map gD cd ~/Documents" >> ~/.config/ranger/rc.conf
	echo "map gMn cd /mnt" >> ~/.config/ranger/rc.conf
	#.bash_aliases
	echo "alias gM='cd ~/1TBDrive/Music'" >> ~/.bash_aliases
	echo "alias gb='cd ~/1TBDrive/Books'" >> ~/.bash_aliases
	echo "alias gl='cd ~/1TBDrive/LaTeX'" >> ~/.bash_aliases
	echo "alias ghh='cd ~/1TBDrive/GitHub'" >> ~/.bash_aliases
	echo "alias gp='cd ~/1TBDrive/Pictures'" >> ~/.bash_aliases
	echo "alias gP='cd ~/1TBDrive/Programming'" >> ~/.bash_aliases
	echo "alias gv='cd ~/1TBDrive/Visual\ Media'" >> ~/.bash_aliases
	echo "alias ghs='cd ~/1TBDrive/GitHub\ Storage'" >> ~/.bash_aliases
	echo "alias gw='cd ~/1TBDrive/Pictures/Wallpapers'" >> ~/.bash_aliases
	echo "alias gm='cd ~/1TBDrive/Visual\ Media/Movies'" >> ~/.bash_aliases
	echo "alias gn='cd ~/1TBDrive/GitHub\ Storage/Notes'" >> ~/.bash_aliases
	echo "alias gMn='cd /mnt/'"
	echo "alias g1tb='cd ~/1TBDrive'"
	echo "alias crt='xrandr && xrandr --output DP-2 --mode 1024x768 --rate 85 --right-of eDP-1'"
	echo "alias crt0='xrandr && xrandr --output DP-2 --mode 1024x768 --rate 85.00 --right-of eDP-1'"
	echo "alias dcrt='xrandr --output DP-2 --off'"
	echo "alias gre='cd ~/1TBDrive/GitHub/rethy.xyz'"
	echo "alias sshac='ssh lowlife@45.79.250.220'"
	echo "alias tott='cd ~/1TBDrive/ToolsOfTheTrade'"
	echo "alias torb='cd ~/1TBDrive/ToolsOfTheTrade/tor-browser_en-US/'"
	echo "alias sonic='xrandr && xrandr --output DP-2 --mode 1920x1080 --rate 60 --right-of eDP-1'"
	echo "alias dsonic='xrandr --output DP-2 --off'"
	#.xinitrc
	echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad'" >> ~/.xinitrc
	echo "~/Scripts/dwmbar_e550 &" >> ~/.xinitrc
	echo "" >> ~/.xinitrc
	echo "exec dwm" >> ~/.xinitrc
	#.vimrc
	echo ":map <leader>ghh :e ~/1TBDrive/GitHub<CR>" >> ~/.vimrc
	echo ":map <leader>ghs :e ~/1TBDrive/GitHub<CR>" >> ~/.vimrc
	echo ":map <leader>gre :e ~/1TBDrive/GitHub/rethy.xyz<CR>" >> ~/.vimrc
	echo ":map <leader>t :e ~/1TBDrive/GitHub\ Storage/Notes/TODO.md<CR>" >> ~/.vimrc
	echo "let g:vimwiki_list = [{'path': '~/1TBDrive/GitHub\ Storage/Notes', 'syntax': 'markdown', 'ext': 'md'}]" >> ~/.vimrc
	echo ":map <leader>h :e /home/$USER<CR>"
}

get_programs () {
    sudo pacman -S ranger feh xorg xorg-xinit vim lxappearance pulseaudio curl mpd mpc ncmpcpp firefox xorg-xinput mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler libxft rsync pulsemixer sshfs python-pip light -y
    sudo pip3 install youtube-dl
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
   
enable_services () {
    sudo systemctl enable mpd
    sudo systemctl enable pulseaudio
}

compile_dwm_and_st () {
	cd ~/.config/dwm && sudo make clean install
	cd ~/.config/st && sudo make clean install
}

clean_up () {
    sudo chown -R $USER:wheel /sys/class/backlight/intel_backlight/brightness
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
    apply_ownership
	compile_dwm_and_st
    clean_up
}

main
