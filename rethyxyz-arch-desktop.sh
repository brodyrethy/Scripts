#!/bin/bash
# TODO Complete this script

#
#	By: Brody Rethy
#	Website: https://rethy.xyz
#
#	Name: rethyxyz's Arch Post-Installation Script
#	Version: 1.0
#
#	Summary:
#	A script to automate my post-installation process after installing Arch
#	Linux. I may make functions if the script gets big enough. For now, it's
#	fine, as I device code blocks by 3
#	newlines.
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
# TODO Check if user is in group wheel



# Defining variables
#
# As long as yours keeps the same hierarchy as they
# do in the home directory (i.e. $HOME/.config/qutebrowser, $HOME/.bash_aliases,
# $HOME/.vimrc) they should work flawlessly if you change this.
DOTFILES="rethyxyz-dotfiles"
GITHUB_URL="https://github.com/rethyxyz/$DOTFILES"



# File/directory hierarchy setup
echo ""; echo "## File/directory hierarchy setup"
## Check if dir exists (I didn't break into function as it takes more code to
## write one over this)
#if [ -d $HOME/dotfiles ]
#then
/usr/bin/rm -rf $HOME/$DOTFILES || sudo rm -rf $HOME/$DOTFILES
#fi

## Download dotfiles
/usr/bin/git clone $GITHUB_URL $HOME/$DOTFILES || exit 1

# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R $HOME

# This is a bad idea, but it MAY work. Well, lets hope it does. I'm not sure
# what else to try here, so I'll keep this here till I find a better way.
#
# No code block here because I use a for loop. Instead, I'll display status
# text after each iteration.
#
## Makes non-normal files (need root privileges).
/usr/bin/sudo /usr/bin/chmod 777 /etc/inputrc /etc/modprobe.d/nobeep.conf
/usr/bin/sudo /usr/bin/chown -R $USER:wheel /etc/inputrc /etc/modprobe.d/nobeep.conf
/usr/bin/touch $HOME/$DOTFILES/pulseaudio.service

## Make dirs
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.Trash/files
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.config/mpd/playlists
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.config/mpv/{scripts,script-opts}
/usr/bin/sudo /usr/bin/mkdir -p $HOME/.vim/undodir
/usr/bin/sudo /usr/bin/mkdir -p $HOME/500GigDrive{0,1,2,3}

## Copy from dotfiles directory
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.bash_aliases $HOME/.bash_aliases
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.bash_profile $HOME/.bash_profile
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.bashrc $HOME/.bashrc
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.config/dunst/ $HOME/.config/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.config/mpd/ $HOME/.config/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.config/ncmpcpp/ $HOME/.config/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.config/qutebrowser/ $HOME/.config/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.config/ranger/ $HOME/.config/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.fonts/ $HOME/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.newsboat/ $HOME/
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.vim/keybindings.vim $HOME/.vim/keybindings.vim
/usr/bin/sudo /usr/bin/cp -R $HOME/$DOTFILES/.vimrc $HOME/.vimrc

## Make symlinks
/usr/bin/ln -sf $HOME/500GigDrive0/music $HOME/music
/usr/bin/ln -sf $HOME/500GigDrive0/vids $HOME/vids
/usr/bin/ln -sf $HOME/500GigDrive1/docs $HOME/docs
/usr/bin/ln -sf $HOME/500GigDrive1/notes $HOME/notes
/usr/bin/ln -sf $HOME/500GigDrive1/pix $HOME/pix
/usr/bin/ln -sf $HOME/500GigDrive1/repos $HOME/repos

## Echo data into files.
#
# Easier than having to manage more files in my dotilfes repo.
### For .xinitrc
echo "dunst &" > $HOME/.xinitrc
echo "dwmbar_desktop.sh &" >> $HOME/.xinitrc
echo "picom &" >> $HOME/.xinitrc
echo "setxkbmap -option caps:escape &" >> $HOME/.xinitrc
echo "xinput --set-prop 8 'libinput Accel Speed' -1 &" >> $HOME/.xinitrc
echo "xset r rate 200 50 &" >> $HOME/.xinitrc
echo "" >> $HOME/.xinitrc
echo "exec dwm" >> $HOME/.xinitrc
### For inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc
### For nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
### For pulseaudio.service
echo "[Unit]" > $HOME/$DOTFILES/pulseaudio.service
echo "Description=PulseAudio Daemon" >> $HOME/$DOTFILES/pulseaudio.service
echo "" >> $HOME/$DOTFILES/pulseaudio.service
echo "[Install]" >> $HOME/$DOTFILES/pulseaudio.service
echo "WantedBy=multi-user.target" >> $HOME/$DOTFILES/pulseaudio.service
echo "" >> $HOME/$DOTFILES/pulseaudio.service
echo "[Service]" >> $HOME/$DOTFILES/pulseaudio.service
echo "Type=simple" >> $HOME/$DOTFILES/pulseaudio.service
echo "PrivateTmp=true" >> $HOME/$DOTFILES/pulseaudio.service
echo "ExecStart=/usr/bin/pulseaudio --system --realtime --disallow" >> $HOME/$DOTFILES/pulseaudio.service
/usr/bin/sudo /usr/bin/mv $HOME/$DOTFILES/pulseaudio.service /etc/systemd/system/pulseaudio.service



# Install programs

## Arch repos
#
# I get most programs from here.
/usr/bin/sudo /usr/bin/pacman -Syu adobe-source-han-sans-kr-fonts curl dmenu \
	dos2unix dunst feh fuse imagemagick irssi libnotify lxappearance mpc mpd \
	mpv ncmpcpp newsboat ntfs-3g picard pulseaudio pulsemixer python-pip \
	python3 qutebrowser ranger rsync scrot sshfs ttf-dejavu ttf-hanazono vim \
	xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot zathura zathura-cb \
	zathura-pdf-poppler -y

## ueberzug
#
# Mandatory for st image previews.
/usr/bin/sudo pip3 install youtube-dl ueberzug

## ranger
#
# The newest version is needed for image previews with st. Ueberzug doesn't
# work with the Arch repo version.
/usr/bin/git clone https://github.com/ranger/ranger $HOME/ranger
cd $HOME/ranger
/usr/bin/sudo make clean install

## vim-py3
#
# Needed for LaTeX live preview (vim-plugin).
/usr/bin/git clone https://github.com/vim/vim $HOME/vim
cd $HOME/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp \
	--enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check \
	--with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' \
	--with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
	--prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3

## mpv-youtube-quality
git clone https://github.com/jgreco/mpv-youtube-quality
cd mpv-youtube-quality
cp youtube-quality.lua ~/.config/mpv/scripts/
cp youtube-quality.conf ~/.config/mpv/script-opts/

## install vim-plug
/usr/bin/curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# Remove programs
/usr/bin/sudo /usr/bin/pacman -R nano youtube-dl -y



# Enable services
/usr/bin/sudo systemctl enable mpd pulseaudio



# Set proper permissions
/usr/bin/sudo chown $USER:wheel -R $HOME



# Compile suckless programs
cd $HOME/.config/rethyxyz-dwm && /usr/bin/sudo make clean install
cd $HOME/.config/rethyxyz-st && /usr/bin/sudo make clean install



# Convert configs to proper format
/home/$USER/scripts/file_hierarchy_converter.sh desktop



exit 0
