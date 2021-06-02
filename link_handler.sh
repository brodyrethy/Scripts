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

CHOICE=$(/usr/bin/printf "mpv\nQutebrowser\nDownload" | dmenu -i -p "Open \"$1\" with:")

case "$CHOICE" in
    mpv)
        mpv "$1"
    ;;

    Qutebrowser)
        qutebrowser "$1"
    ;;

    Download)
        CHOICE=$(/usr/bin/printf "Audio only\n480p\n720p\n1080p" | dmenu -i -p "Format:")

        case $CHOICE in
            "Audio only")
                youtube-dl \
                    --audio-format mp3 \
                    --no-playlist \
                    -f best \
                    -x \
                    "$1" \
                    && notify-send "Successfully downloaded \"$1\" as audio in MP3 format." \
                    || notify-send "Failed to download \"$1\"."
            ;;

            480p)
                youtube-dl \
                    -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' \
                    --no-playlist \
                    -i \
                    --format mp4 \
                    "$1" \
                    && notify-send "Successfully downloaded \"$1\" in 480p quality." \
                    || notify-send "Failed to download \"$1\""
            ;;

            720p)
                youtube-dl \
                    --format mp4 \
                    --no-playlist \
                    -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' \
                    -i \
                    "$1" \
                    && notify-send "Successfully downloaded \"$1\" in 720p quality." \
                    || notify-send "Failed to download \"$1\"."
            ;;

            1080p)
                youtube-dl \
                    -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' \
                    --no-playlist \
                    -i \
                    --format mp4 \
                    "$1" \
                    && notify-send "Successfully downloaded \"$1\" in 1080p quality." \
                    || notify-send "Failed to download \"$1\"."
            ;;
        esac
esac
