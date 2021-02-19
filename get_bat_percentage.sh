get_bat_percentage () {
	bat_percentage="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)"

    echo "$bat_percentage%"
}

get_bat_percentage
