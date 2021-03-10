WALLPAPERS_DIR="$HOME/pix/wallpapers"
WALLPAPER=$(ls $WALLPAPERS_DIR | shuf -n 1)

feh --bg-fill "$WALLPAPERS_DIR/$WALLPAPER"
