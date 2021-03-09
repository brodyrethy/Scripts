clear
tput setaf 1; echo "Are you sure you want to end this openbox session?$(tput sgr0) (y/n)";
read CHOICE

if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ] 
then
	pkill openbox
fi

exit 0
