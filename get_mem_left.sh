get_mem_left () {
    memFree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
    memSym=$(echo "MB")

    echo "$memFree$memSym"
}

get_mem_left
