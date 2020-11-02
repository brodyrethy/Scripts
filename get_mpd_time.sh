get_mpd_time () {
	mpd_time=$(mpc -p 6601 | sed -n 2p | awk '{print $3}')

	echo "$mpd_time"
}

get_mpd_time
