#!/bin/bash

print_mpd_time() {
	mpc_time=$(mpc -p 6601 | sed -n 2p | awk '{print $3}')
	echo -e "$mpc_time"
}

print_mpd() {
	mpc_current=$(mpc -p 6601 current)
	echo -e "$mpc_current"
}

print_volume() {
	volume=$(echo $(pulsemixer --get-volume | awk '{print $2}')%)
	echo -e "V:$volume"
}

print_wifi() {
	ip=$(ip addr|awk '/enp2s0/ && /inet/ {gsub(/\/[0-9][0-9]/,""); print $2}')
	echo -e "IP:$ip"
}

print_mem() {
	mem_free=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	mem_sym=$(echo "MB")
	echo -e "M:$mem_free$mem_sym"
}

print_date(){
	date=$(date "+%a %m-%d %r")
	echo -e "D:$date"
}

show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}

while true
do
	xsetroot -name "$(print_mpd_time) $(print_mpd) $(print_volume) $(print_mem) $(print_date)"

	sleep 1
done
