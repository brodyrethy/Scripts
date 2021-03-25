DIR="$HOME/pix/wallpapers"
WALLPAPER=$(ls $DIR | shuf -n 1)

feh --bg-fill "$DIR/$WALLPAPER"
