#!/bin/bash
#
# By: Brody Rethy
# Website: https://rethy.xyz
#
# Name: link_handler.sh
#
# Summary:
# A dmenu link handler. Open in mpv, browser of choice, or downloads in various
# pre-determined formats.
#

CHOICE=$(\
    printf "center\nfill\nscale\ntile" \
    | dmenu -i -p "Set \"$1\" as wallpaper using method:"\
)

case "$CHOICE" in
    center) METHOD="center" ;;
    fill) METHOD="max" ;;
    scale) METHOD="scale" ;;
    tile) METHOD="tile" ;;
    *) notify-send "Didn't set \"$1\" as wallpaper" ; exit 1 ;;
esac

feh --bg-"$METHOD" "$1" \
    && notify-send "Set \"$1\" as wallpaper" \
    || notify-send "Failed to set \"$1\" as wallpaper"
