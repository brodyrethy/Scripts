#TODO: incomplete

def main():
    dirs = [".bash_aliases", ".vimrc", "ncmpcpp/bindings", "ranger/rc.conf", "ranger/rifle.conf", "st/config.h"]

    for x in dirs:
        copy_files(x)

    # sources
	sudo cp /etc/apt/sources.list ~/dotfiles/sources.list
    # suckless software
	sudo cp ~/.config/dwm/config.h ~/dotfiles/.config/config.h_e550

def copy_files(dirs):
    os.system("sudo cp ~/" + dirs + " ")

    # bash_aliases
	sudo cp ~/.bash_aliases ~/dotfiles/.bash_aliases
	sudo cp ~/.vimrc ~/dotfiles/.vimrc

    # sources
	sudo cp /etc/apt/sources.list ~/dotfiles/sources.list

    # ncmpcpp
	sudo cp -R ~/.config/ncmpcpp/bindings ~/dotfiles/.config/ncmpcpp/bindings

    # ranger
	sudo cp -R ~/.config/ranger/rc.conf ~/dotfiles/.config/ranger/rc.conf
	sudo cp -R ~/.config/ranger/rifle.conf ~/dotfiles/.config/ranger/rifle.conf

    # suckless software
	sudo cp ~/.config/dwm/config.h ~/dotfiles/.config/config.h_e550
	sudo cp -R ~/.config/st/config.h ~/dotfiles/.config/st/config.h

def copy_dirs():
    pass

main()