get_mpd_song () {
	mpd_song=$(mpc -p 6601 current)

	echo "$mpd_song"
}

get_mpd_song
