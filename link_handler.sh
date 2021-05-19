#!/bin/bash

CHOICE=$(echo -e "mpv\nQutebrowser\nDownload" | dmenu -i -p "$1")

case "$CHOICE" in
    mpv) mpv $1 ;;
    Qutebrowser) qutebrowser $1 ;;
    Download)
        CHOICE=$(echo -e "audio\n480p\n720p\n1080p" | dmenu -i -p "Format:")

        case $CHOICE in
            audio)
                youtube-dl -f best -x --no-playlist --audio-format mp3 "$1" && notify-send "Successfully downloaded $1 as audio in mp3 format" || notify-send "Failed to download $1"
                ;;
            480p)
                youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' --no-playlist -i --format mp4 "$1" && notify-send "Successfully downloaded $1 in 480p quality" || notify-send "Failed to download $1"
                ;;
            720p)
                youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --no-playlist -i --format mp4 "$1" && notify-send "Successfully downloaded $1 in 720p quality" || notify-send "Failed to download $1"
                ;;
            1080p)
                youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' --no-playlist -i --format mp4 "$1" && notify-send "Successfully downloaded $1 in 1080p quality" || notify-send "Failed to download $1"
                ;;
        esac
esac
