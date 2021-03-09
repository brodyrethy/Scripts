#!/bin/bash

print_mpd_time() {
	mpcTime=$(mpc -p 6601 | sed -n 2p | awk '{print $3}')
	echo -e "$mpcTime"
}

print_mpd() {
	mpcCurrent=$(mpc -p 6601 current)
	echo -e "$mpcCurrent"
}

print_volume() {
	volume=$(echo $(pulsemixer --get-volume | awk '{print $2}')%)
	echo -e "$volume"
}

print_wifi() {
	ip=$(ip addr|awk '/enp2s0/ && /inet/ {gsub(/\/[0-9][0-9]/,""); print $2}')
	echo -e "$ip"
}

print_mem() {
	memFree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	memSym=$(echo "MB")
	echo -e "$memFree$memSym"
}

print_date(){
	date=$(date +"%m-%d")
	echo -e "$date"
}

print_time() {
	time=$(date +"%r")
	echo -e "$time"
}

while true
do
	tput setaf 1; echo "$(print_mpd_time) $(print_mpd)"
	tput setaf 2; echo "$(print_volume)"
	tput setaf 3; echo "$(print_mem)"
	tput setaf 5; echo "$(print_wifi)"
	tput setaf 6; echo "$(print_date) $(print_time)"

	tput sgr0

	sleep 2

	clear
done
