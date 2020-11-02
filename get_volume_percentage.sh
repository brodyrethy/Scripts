get_volume_percentage () {
	volume_percentage=$(pulsemixer --get-volume | awk '{print $2}')

	echo "$volume_percentage%"
}

get_volume_percentage
