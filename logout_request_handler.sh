#!/bin/bash

case "$(/usr/bin/printf "No\nYes" | dmenu -i -p "Kill dwm?")" in
    Yes) pkill dwm ;;
esac

