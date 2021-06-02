#!/bin/bash

CHOICE=$(/usr/bin/printf "No\nYes" | dmenu -i -p "Restart \"$HOSTNAME\"?")

case "$CHOICE" in
    Yes) sudo shutdown -r 0 ;;
esac
