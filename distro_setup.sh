# This is going to be a installer for a distro that I'm making.
# We'll see if it happens. If it doesn't, it'll still
# be a good installer for Arch.

# TODO Complete this script

# run this until a valid device is given
check_if_file_exists() {
	while ::
	do
		if [ -e "/dev/$1" ]
		then
			return $1
		fi

		printf "$RED:: /dev/$1 not found$RESET\nTry again\n"
		read $1
	done
}

status_text() {
	printf "$BLUE$1$RESET\n"
}

error_text() {
	printf "$RED$1$RESET\n"
}

title_text() {
	printf "$GREEN$1$RESET\n"
}

prompt_text() {
	printf "$1\n"
}

RED="\e[31m"
GREEN="\e[42m"
BLUE="\e[34m"
RESET="\e[0m"
CHROOT="arch-chroot /mnt"

title_text "Brody's Arch-Based Distro Installer"
title_text "Partitioning\n"

lsblk

status_text "Which drive do you want to partition"
status_text "Example: sda, sdb, sdc..."
read DRIVE
DRIVE=$(check_if_drive_exists $DRIVE)

cfdisk /dev/$DRIVE

lsblk

status_text "Which partition do you want to mount as root (/)"
read ROOT_PART
ROOT_PART=$(check_if_drive_exists $ROOT_PART)

status_text "Which partition do you want to mount as boot (/boot/)"
read BOOT_PART
BOOT_PART=$(check_if_drive_exists $BOOT_PART)



title_text "Pacstrap/Setup filesystem\n"
pacstrap /mnt base base-devel linux linux-firmware vim grub networkmanager



/usr/bin/printf "GENERATE FILESYSTEM TABLE\n"
genfstab -U /mnt >> /mnt/etc/fstab



/usr/bin/printf "USER MANAGEMENT\n"
/usr/bin/printf "What username do you want to use for your non-root user?\n"
read SYS_USERNAME
$CHROOT useradd -mg wheel $SYS_USERNAME

/usr/bin/printf "Insert password for $SYS_HOSTNAME\n"
$CHROOT passwd $SYS_HOSTNAME

/usr/bin/printf "Insert password for root\n"
$CHROOT passwd root



/usr/bin/printf "SYSTEM CONFIGURATION SETTINGS\n"
/usr/bin/printf "Enable networkmanager\n"
$CHROOT systemctl enable NetworkManager



/usr/bin/printf "Install grub\n"
$CHROOT grub-install $DRIVE; grub-mkconfig -o /boot/grub/grub.cfg



/usr/bin/printf "Uncomment your desired locale(s)\n"
/usr/bin/printf "Press Return to continue\n"
read RETURN
$CHROOT vim /etc/locale.gen; locale-gen

/usr/bin/printf "Insert your main locale\n"
/usr/bin/printf "(Example: LANG=en_US.UTF-8)\n"
/usr/bin/printf "Press Return to continue\n"
read RETURN
$CHROOT vim /etc/locale.conf



/usr/bin/printf "Insert hostname\n"
read SYS_HOSTNAME
$CHROOT echo "$SYS_USERNAME" > /mnt/etc/hostname



/usr/bin/printf "Syncing local time\n"

ls /mnt/usr/share/zoneinfo/

/usr/bin/printf "\n\nWhere are you located?\n"
/usr/bin/printf "Example: Canada, America, Indian...\n"
while ::
do
	read LOCATION

	if [ -e /mnt/usr/share/zoneinfo/$LOCATION ]
	then
		break
	fi
	/usr/bin/printf "$RED:: Not a valid timezone$RESET\n"
done

ln -sf /usr/share/zoneinfo/$LOCATION
/usr/bin/printf "Which timezone?\n"
read TIMEZONE

if [ -d $TIMEZONE ]
then
	ln -sf /usr/share/zoneinfo/$LOCATION/$TIMEZONE
	/usr/bin/printf "Which sub-timezone?\n"
	read SUB_LOCATION

	ln -sf /usr/share/zoneinfo/$LOCATION/$TIMEZONE/$SUB_LOCATION
	break
elif [ -f $TIMEZONE ]
then
	ln -sf /usr/share/zoneinfo/$LOCATION/$TIMEZONE
	break
else
	/usr/bin/printf "$RED:: Timezone not found$RESET\n"
fi
