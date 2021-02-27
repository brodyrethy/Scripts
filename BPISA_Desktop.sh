#!/bin/bash
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#
#	Name: Brody's Post-Installation Scripts for Arch: Desktop Edition
#	Version: 1.0
#
#	Summary:
#	A script to automate my post-installation process after
#	installing Arch Linux.
#
#	Installs and sets up dwm, ranger, bash aliases, qutebrowser,
#	vim, mpd, programs, daemons (services), and more.
#



# Preliminary checks
## Check if user is in wheel
#
# If user is in wheel, they are able to use sudo (this is presumed).
# In the future, I should find a better way to do this, but it works
# for now.
#
#		if [ ! getent group wheel | grep -q "\b${username}\b" ]
#		then
#			echo ""; exit 126 # TODO: I think this error code is proper? Check this later.
#		fi
#
# Actually, it doesn't work, but I'll make complete this later. For now, I just need
# to remember to not do anything stupid and it'll work fine.



# File/directory hierarchy setup
echo ""; echo "## File/directory hierarchy setup"
## Download dotfiles
git clone https://github.com/rethyxyz/dotfiles ~/dotfiles || echo ":: Failed to download dotfiles (they are important to the script)"; echo "  Check Internet connection and try again"; exit 1

## Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~ 2> /dev/null && echo ":: Set ~/$USER to $USER:wheel ownership" || echo ":: Couldn't set ~/$USER ownership to $USER:wheel, this could be a problem later on..."; echo "   Come back after you fix the issue."; exit 126

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
	if [ ! -f $PATH ]
	then
		touch $PATH
	fi
	/usr/bin/sudo chmod 777 $PATH && echo "" # rwx for everyone!
	/usr/bin/sudo chown -R $USER:wheel $PATH && echo ":: chown $USER:wheel sucessful" || echo ":: chown $USER:wheel failed" # change owner and group
done

## Make dirs
PATHS=(
"~/.Trash/files"
"~/.config/mpd/playlists"
"~/.fonts" "~/.vim/undodir"
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



# Echo data into files. It's easier than having multiple files in my dotilfes repo.
#
## For .xinitrc
echo "xinput --set-prop 12 'libinput Accel Speed' -1 &" > ~/.xinitrc
echo "setxkbmap -option caps:escape &" >> ~/.xinitrc
echo "xset r rate 200 50 &" >> ~/.xinitrc
echo "xinput disable 'AlpsPS/2 ALPS DualPoint TouchPad' &" >> ~/.xinitrc
echo "dwmbar_desktop.sh &" >> ~/.xinitrc
echo "dunst &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc
## For inputrc
echo "set show-mode-in-prompt on" >> /etc/inputrc
## For nobeep.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
## For pulseaudio.service
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
## Download and install programs from Arch repos
#
# I get the main ones from here.
echo ""; echo "## Installing programs"
{
/usr/bin/sudo /usr/bin/pacman -Syu dmenu feh xorg xorg-xinit xorg-xinput xorg-xset xorg-xsetroot vim lxappearance pulseaudio curl mpd mpc ncmpcpp firefox python3 python-pip mpv imagemagick irssi newsboat fuse cifs-utils zathura zathura-cb zathura-pdf-poppler rsync pulsemixer sshfs light dos2unix picom dunst libnotify ranger scrot -y
} 2> /dev/null && echo ":: Installed main programs" || echo ":: One or more programs failed to install from pacman"

## Ueberzug, for ranger image previews
#
# It's mandatory for st image previews.
{
/usr/bin/sudo pip3 install youtube-dl ueberzug
} 2> /dev/null && echo ":: Installed ueberzug" || echo ":: Installed ueberzug"

## ranger
#
# The newest version is needed for image previews with st. Ueberzug doesn't work with the Arch repo version.
{
git clone https://github.com/ranger/ranger ~/ranger
cd ~/ranger
/usr/bin/sudo make clean install
} 2> /dev/null && echo ":: Compiled and installed newest ranger" || echo ":: Failed to install newest ranger"

## vim-py3
#
# Needed for LaTeX live preview, an plugin for vim.
{
git clone https://github.com/vim/vim ~/vim
cd ~/vim
./configure --enable-perlinterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby='xorpd' --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu --prefix=/opt/vim74
make && /usr/bin/sudo make install
/usr/bin/sudo ln -s /opt/vim74/bin/vim /usr/bin/vim-py3
} 2> /dev/null && echo ":: Compiled and installed vim-py3" || echo ":: Failed to install newest vim-py3"

## vim-plug
{
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
} 2> /dev/null && echo ":: Installing vim-plug" || echo ":: Failed to install vim-plug"



# Enable services
/usr/bin/sudo systemctl enable mpd && echo ":: Enabled mpd as service" || echo ":: Failed to enable mpd"
/usr/bin/sudo systemctl enable pulseaudio && echo ":: Enabled pulseaudio as service" || echo ":: Failed to enable pulseaudio"



# Remove programs
/usr/bin/sudo /usr/bin/pacman -R nano youtube-dl -y



## Set proper permissions
/usr/bin/sudo chown $USER:wheel -R ~ 2> /dev/null && echo ":: Set ~/$USER to $USER:wheel ownership" || echo ":: Couldn't set ~/$USER ownership to $USER:wheel"



# Compile suckless programs
cd ~/.config/dwm && /usr/bin/sudo make clean install
cd ~/.config/st && /usr/bin/sudo make clean install


# Convert configs to proper format
python3 /home/$USER/scripts/convert_configs_for_device.py "laptop"

exit 0
