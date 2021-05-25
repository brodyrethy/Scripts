#!/bin/bash

CHOICE=$(/usr/bin/printf "No\nYes" | dmenu -i -p "Do you want to restart?")

case "$CHOICE" in
    Yes) sudo shutdown -r 0 ;;
esac
