#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: Rethyxyz's Post-Installation Script for Arch: Desktop Edition
#	Version: 1.0
#
#	Summary:
#	A script to automate my post-installation process after
#	installing Arch Linux.
#
#	Steps it automates:
#		1. File/directory hierarchy
#		2. Installing programs
#		3. Removing bad defaults programs
#		4. Compile suckless programs (st, dwm)
#		5. Convert configs to proper format (ThinkPad E550, desktop)
#		6. Enable services (mpd, pulseaudio)
#

# Preliminary checks
## Check if user is in wheel
#
# If user is in wheel, they are able to use sudo (this is presumed).
# In the future, I should find a better way to do this, but it works
# for now.
#
# This ensures that the user has: 1) Created a user, and 2) is using
# one other than root.
#								  && [ ! $USER = "root"  ]
#		if [ ! getent group wheel | grep -q "\b${username}\b" ]
#		then
#			TODO: I think this error code is proper? Check this later.
#			echo ""; exit 126
#		fi
#
# Actually, it doesn't work yet, but I'll make complete this later. For now,
# I just need to remember to not do anything stupid and it'll work fine.



# Defining variables
#
# For getting dotfiles. As long as yours keep the same hierarchy
# as they do in the home directory (i.e. .config/qutebrowser,$HOME/.bash_aliases,
# $HOME/.vimrc) they should work flawlessly.
URL="https://github.com/rethyxyz/dotfiles"



# File/directory hierarchy setup
echo ""; echo "## File/directory hierarchy setup"
## Check if dir exists (I didn't break into function as it takes more code to
## write one over this)
#if [ -d $HOME/dotfiles ]
#then
/usr/bin/rm -rf $HOME/dotfiles || sudo rm -rf $HOME/dotfiles
#fi

## Download dotfiles
/usr/bin/git clone $URL $HOME/dotfiles || exit 1

## Set proper permissions
/usr/bin/sudo /usr/bin/chown $USER:wheel -R $HOME

# This is a bad idea, but it MAY work. Well, lets hope
# it does. I'm not sure what else to try here, so I'll
# keep this here till I find a better way.
#
# No code block here because I use a for loop. Instead,
# I'll display status text after each iteration.
#
## Makes non-normal files (need root privileges).
/usr/bin/sudo /usr/bin/chmod 777 /etc/inputrc
/usr/bin/sudo /usr/bin/chown -R $USER:wheel /etc/inputrc

/usr/bin/sudo /usr/bin/chmod 777 /etc/modprobe.d/nobeep.conf
/usr/bin/sudo /usr/bin/chown -R $USER:wheel /etc/modprobe.d/nobeep.conf

/usr/bin/sudo /usr/bin/chmod 777 /etc/systemd/system/pulseaudio.service
/usr/bin/sudo /usr/bin/chown -R $USER:wheel /etc/systemd/system/pulseaudio.service

## Make dirs
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.Trash/files
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.config/mpd/playlists
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.fonts
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.vim/undodir
/usr/bin/sudo /usr/bin/mkdir -p $HOME/500GigDrive{0,1,2,3}
/usr/bin/touch $HOME/dotfiles/pulseaudio.service

## copy dwm's config.h
/usr/bin/sudo /usr/bin/cp $HOME/dotfiles/.config/config.h_desktop $HOME/dotfiles/.config/dwm/config.h

## Copy from dotfiles directory
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/dunst $HOME/.config/dunst
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/dwm $HOME/.config/dwm
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/mpd $HOME/.config/mpd
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/ncmpcpp $HOME/.config/ncmpcpp
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/qutebrowser $HOME/.config/qutebrowser
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/ranger $HOME/.config/ranger
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.config/st $HOME/.config/st
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.fonts $HOME/.fonts
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.newsboat/ $HOME/.newsboat/
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.bash_aliases $HOME/.bash_aliases
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.bash_profile $HOME/.bash_profile
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.vimrc $HOME/.vimrc
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.bashrc $HOME/.bashrc
/usr/bin/sudo /usr/bin/cp -R $HOME/dotfiles/.vim/macros.vim $HOME/.vim/macros.vim

## Make symlinks
/usr/bin/ln -sf $HOME/500GigDrive0/music $HOME/music
/usr/bin/ln -sf $HOME/500GigDrive0/vids $HOME/vids
/usr/bin/ln -sf $HOME/500GigDrive1/docs $HOME/docs
/usr/bin/ln -sf $HOME/500GigDrive1/notes $HOME/notes
/usr/bin/ln -sf $HOME/500GigDrive1/pix $HOME/pix
/usr/bin/ln -sf $HOME/500GigDrive1/repos $HOME/repos

## Echo data into files. It's easier than having multiple files in my dotilfes repo.
#
### For .xinitrc
echo "xinput --set-prop 8 'libinput Accel Speed' -1 &" > $HOME/.xinitrc
echo "setxkbmap -option caps:escape &" >> $HOME/.xinitrc
echo "xset r rate 200 50 &" >> $HOME/.xinitrc
echo "dwmbar_desktop.sh &" >> $HOME/.xinitrc
echo "dunst &" >> $HOME/.xinitrc
echo "" >> $HOME/.xinitrc
echo "exec dwm" >> $HOME/.xinitrc
### For inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc
### For nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
### For pulseaudio.service
echo "[Unit]" > $HOME/dotfiles/pulseaudio.service
echo "Description=PulseAudio Daemon" >> $HOME/dotfiles/pulseaudio.service
echo "" >> $HOME/dotfiles/pulseaudio.service
echo "[Install]" >> $HOME/dotfiles/pulseaudio.service
echo "WantedBy=multi-user.target" >> $HOME/dotfiles/pulseaudio.service
echo "" >> $HOME/dotfiles/pulseaudio.service
echo "[Service]" >> $HOME/dotfiles/pulseaudio.service
echo "Type=simple" >> $HOME/dotfiles/pulseaudio.service
echo "PrivateTmp=true" >> $HOME/dotfiles/pulseaudio.service
echo "ExecStart=/usr/bin/pulseaudio --system --realtime --disallow" >> $HOME/dotfiles/pulseaudio.service
/usr/bin/sudo /usr/bin/mv $HOME/dotfiles/pulseaudio.service /etc/systemd/system/pulseaudio.service



# Install programs
## Download and install programs from Arch repos
#
# I get the main ones from here.
echo ""; echo "## Installing programs"

/usr/bin/sudo /usr/bin/pacman -Syu dmenu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp python3 python-pip mpv imagemagick irssi newsboat fuse zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs dos2unix dunst libnotify ranger scrot picard -y

## Ueberzug, for ranger image previews
#
# It's mandatory for st image previews.
/usr/bin/sudo pip3 install youtube-dl ueberzug

## ranger
#
# The newest version is needed for image previews with st. Ueberzug doesn't work with the Arch repo version.
/usr/bin/git clone https://github.com/ranger/ranger $HOME/ranger
cd $HOME/ranger
/usr/bin/sudo make clean install

## vim-py3
#
# Needed for LaTeX live preview, an plugin for vim.
/usr/bin/git clone https://github.com/vim/vim $HOME/vim
cd $HOME/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3

## vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# Remove programs
/usr/bin/sudo /usr/bin/pacman -R nano youtube-dl -y



# Enable services
/usr/bin/sudo systemctl enable mpd
/usr/bin/sudo systemctl enable pulseaudio

## Set proper permissions
/usr/bin/sudo chown $USER:wheel -R $HOME



# Compile suckless programs
cd $HOME/.config/dwm && /usr/bin/sudo make clean install
cd $HOME/.config/st && /usr/bin/sudo make clean install



# Convert configs to proper format
/home/$USER/scripts/file_hierarchy_converter.sh desktop 



# exit using success code
exit 0
