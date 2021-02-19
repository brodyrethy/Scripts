#!/usr/bin/python3
import os

os.system("sudo find . \( -iname '*.gif' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +")
os.system("sudo find . \( -iname '*.jpeg' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +")
os.system("sudo find . \( -iname '*.jpg' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +")
