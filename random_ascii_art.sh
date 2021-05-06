COLORS=(1 4 7)

DIR="$HOME/Documents/Repositories/ascii_art"
FILE=$(ls -I README.md "$DIR" | shuf -n 1)
COLOR=$((1 + $RANDOM % 8))

tput setaf "$COLOR"; cat "$DIR/$FILE"; tput sgr0
