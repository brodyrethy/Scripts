# this script skips pre-existing songs in a directory
printf "Insert the playlist URL: "
read URL

youtube-dl --no-post-overwrites -ciwx --audio-format mp3 $URL
