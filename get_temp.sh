get_temp(){
    temp=$(echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C)

    echo "$temp"
}

get_temp
