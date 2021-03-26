DIR="$HOME/pix/wallpapers"
WALLPAPER=$(ls $DIR | shuf -n 1)

feh --bg-fill "$DIR/$WALLPAPER"
ln -sf "$DIR/$WALLPAPER" $HOME/.last_wallpaper
