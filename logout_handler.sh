#!/bin/bash

CHOICE=$(/usr/bin/printf "No\nYes" | dmenu -i -p "Do you want to kill dwm?")

case "$CHOICE" in
    Yes) pkill dwm ;;
esac

