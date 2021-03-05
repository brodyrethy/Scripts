#!/bin/bash

/usr/bin/sudo /usr/bin/find . \( -iname '*.gif' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +
/usr/bin/sudo /usr/bin/find . \( -iname '*.jpeg' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +
/usr/bin/sudo /usr/bin/find . \( -iname '*.jpg' -o -iname '*.png' \) -type f -exec mv -nv -t '.' -- {} +
