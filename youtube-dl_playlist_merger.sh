printf "Insert the playlist URL: "
read URL

youtube-dl --no-post-overwrites -ciwx --audio-format mp3 $URL
