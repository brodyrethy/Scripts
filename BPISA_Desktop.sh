#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: Brody's Post-Installation Script for Arch: Desktop Edition
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
#
#		if [ ! getent group wheel | grep -q "\b${username}\b" ] #&& [ ! $USER = "root"  ]
#		then
#			echo ""; exit 126 # TODO: I think this error code is proper? Check this later.
#		fi
#
# Actually, it doesn't work yet, but I'll make complete this later. For now,
# I just need to remember to not do anything stupid and it'll work fine.



# Defining variables
#
## For getting dotfiles. As long as yours keep the same hierarchy
## as they do in the home directory (i.e. .config/qutebrowser,~/.bash_aliases, ~/.vimrc)
## they should work flawlessly.
URL="https://github.com/rethyxyz/dotfiles"



# File/directory hierarchy setup
echo ""; echo "## File/directory hierarchy setup"
## Check if dir exists (I didn't break into function as it takes more code to write one over this)
if [ -d $PATH ]
then
	rm -rf ~/dotfiles && echo ":: Removed dotfiles directory" || { sudo rm -rf ~/dotfiles; echo ":: Removed dotfiles directory (used sudo)"; }
fi

## Download dotfiles

/usr/bin/git clone $URL  ~/dotfiles > /dev/null 2>&1 && echo ":: Downloaded dotfiles from $URL" || { echo ":: Failed to download dotfiles (they are important to the script)"; echo " Check Internet connection and try again"; }

## Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~ > /dev/null 2>&1 && echo ":: Set ~/$USER to $USER:wheel ownership" || { echo ":: Couldn't set ~/$USER ownership to $USER:wheel, this could be a problem later on..."; echo "   Come back after you fix the issue."; exit 126; }

# This is a bad idea, but it MAY work. Well, lets hope
# it does. I'm not sure what else to try here, so I'll
# keep this here till I find a better way.
#
# No code block here because I use a for loop. Instead,
# I'll display status text after each iteration.
#
## Makes non-normal files (need root privileges).
PATHS=(
"/etc/inputrc"
"/etc/modprobe.d/nobeep.conf"
"/etc/systemd/system/pulseaudio.service"
)
for PATH in ${PATHS[@]}
do
	# Make file is it doesn't exist
	if [ ! -e $PATH ]
	then
		# If command fails, try sudo
		{ /usr/bin/touch $PATH > /dev/null 2>&1 || /usr/bin/sudo /usr/bin/touch $PATH > /dev/null 2>&1 } && echo ":: Created $PATH"
	fi
	/usr/bin/sudo chmod 777 $PATH && echo "" # rwx for everyone!
	/usr/bin/sudo chown -R $USER:wheel $PATH && echo ":: chown $USER:wheel successful" || echo ":: chown $USER:wheel failed" # change owner and group
done

## Make dirs
PATHS=(
"~/.Trash/files"
"~/.config/mpd/playlists"
"~/.fonts"
"~/.vim/undodir"
"~/500GigDrive{0,1,2,3}"
)
for PATH in ${PATHS[@]}
do
	/usr/bin/sudo /usr/bin/mkdir -p $PATH || ":: Failed to make $PATH"
done

## copy dwm's config.h
/usr/bin/sudo /usr/bin/cp ~/dotfiles/.config/config.h_desktop ~/dotfiles/.config/dwm/config.h

## Copy from dotfiles directory
PATHS=(
".config/dunst"
".config/dwm"
".config/mpd"
".config/ncmpcpp"
".config/qutebrowser"
".config/ranger"
".config/st"
".fonts"
".newsboat/"
".bash_aliases"
".bash_profile"
".vimrc"
".bashrc"
".vim/macros.vim"
)
for PATH in $PATHS
do
	/usr/bin/sudo /usr/bin/cp -R $PATH && echo ":: Copied ~/dotfiles/$PATH to ~/$PATH" || echo ":: Failed to copy ~/dotfiles/$PATH to ~/$PATH"
done

## Make symlinks
PATHS=("music" "vids" "docs" "notes" "pix" "repos")
for PATH in ${PATHS[@]}
do
	/usr/bin/ln -sf $PATH && echo ":: Made symlink at $PATH" || echo ":: Couldn't make symlink at $PATH"
done

## Echo data into files. It's easier than having multiple files in my dotilfes repo.
#
### For .xinitrc
echo "xinput --set-prop 12 'libinput Accel Speed' -1 &" > ~/.xinitrc
echo "setxkbmap -option caps:escape &" >> ~/.xinitrc
echo "xset r rate 200 50 &" >> ~/.xinitrc
echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
echo "dwmbar_desktop.sh &" >> ~/.xinitrc
echo "dunst &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc
### For inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc
### For nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
### For pulseaudio.service
echo "[Unit]" > ~/dotfiles/pulseaudio.service
echo "Description=PulseAudio Daemon" >> ~/dotfiles/pulseaudio.service
echo "" >> ~/dotfiles/pulseaudio.service
echo "[Install]" >> ~/dotfiles/pulseaudio.service
echo "WantedBy=multi-user.target" >> ~/dotfiles/pulseaudio.service
echo "" >> ~/dotfiles/pulseaudio.service
echo "[Service]" >> ~/dotfiles/pulseaudio.service
echo "Type=simple" >> ~/dotfiles/pulseaudio.service
echo "PrivateTmp=true" >> ~/dotfiles/pulseaudio.service
echo "ExecStart=/usr/bin/pulseaudio --system --realtime --disallow" >> ~/dotfiles/pulseaudio.service
mv ~/dotfiles/pulseaudio.service /etc/systemd/system/pulseaudio.service



# Install programs
## Download and install programs from Arch repos
#
# I get the main ones from here.
echo ""; echo "## Installing programs"
{
/usr/bin/sudo /usr/bin/pacman -Syu dmenu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp python3 python-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs light dos2unix picom dunst libnotify ranger scrot picard -y
} > /dev/null 2>&1 && echo ":: Installed main programs" || echo ":: One or more programs failed to install from pacman"

## Ueberzug, for ranger image previews
#
# It's mandatory for st image previews.
{
/usr/bin/sudo pip3 install youtube-dl ueberzug
} > /dev/null 2>&1 && echo ":: Installed ueberzug" || echo ":: Installed ueberzug"

## ranger
#
# The newest version is needed for image previews with st. Ueberzug doesn't work with the Arch repo version.
{
/usr/bin/git clone https://github.com/ranger/ranger ~/ranger
cd ~/ranger
/usr/bin/sudo make clean install
} > /dev/null 2>&1 && echo ":: Compiled and installed newest ranger" || echo ":: Failed to install newest ranger"

## vim-py3
#
# Needed for LaTeX live preview, an plugin for vim.
{
/usr/bin/git clone https://github.com/vim/vim ~/vim
cd ~/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
} > /dev/null 2>&1 && echo ":: Compiled and installed vim-py3" || echo ":: Failed to install newest vim-py3"

## vim-plug
{
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
} > /dev/null 2>&1 && echo ":: Installing vim-plug" || echo ":: Failed to install vim-plug"



# Remove programs
/usr/bin/sudo /usr/bin/pacman -R nano youtube-dl -y && echo ":: Removed nano, and YouTube-dl" || echo ":: Failed to remove nano, and youtube-dl, they might already be removed."



# Enable services
/usr/bin/sudo systemctl enable mpd > /dev/null 2>&1 && echo ":: Enabled mpd as service" || echo ":: Failed to enable mpd"
/usr/bin/sudo systemctl enable pulseaudio > /dev/null 2>&1 && echo ":: Enabled pulseaudio as service" || echo ":: Failed to enable pulseaudio"



## Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~ > /dev/null 2>&1 && echo ":: Set ~/$USER to $USER:wheel ownership" || echo ":: Couldn't set ~/$USER ownership to $USER:wheel"



# Compile suckless programs
cd ~/.config/dwm && /usr/bin/sudo make clean install > /dev/null 2>&1 && echo ":: Compile dwm successful" || echo ":: Failed to compile dwm" 
cd ~/.config/st && /usr/bin/sudo make clean install > /dev/null 2>&1 && echo ":: Compile st successful" || echo ":: Failed to compile st"



# Convert configs to proper format
python3 /home/$USER/scripts/convert_configs_for_device.py "laptop"



# exit using success code
exit 0

check_if_file_exists() {
	if [ -e $1 ]
	then
		echo true
	else
		echo false
	fi
}

check_if_dir_exists() {
	if [ -d $1 ]
	then
		echo true
	else
		echo false
	fi
}