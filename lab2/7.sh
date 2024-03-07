#!/bin/bash

output_file="3_process_with_max_mem_in_minute.out"

collect_proc_info() {
    ps -Ao pid,command | tail -n +2 | awk '{print $1":"$2}' |
    while read -r tmp; do
        pid=$(echo $tmp | awk -F ":" '{print $1}')
        com=$(echo $tmp | awk -F ":" '{print $2}')
        
        path="/proc/$pid"
        if [ -f "$path/io" ]; then
            byte=$(grep -h "read_bytes:" "$path/io" | sed "s/[^0-9]*//")
            echo "$pid $com $byte"
        fi
    done | sort -nk1
}

collect_proc_info > temp_info_1
sleep 1m
collect_proc_info > temp_info_2

paste temp_info_1 temp_info_2 | awk '{if ($1 == $4) print $1, $2, $3, $6}' | 
while read -r pid com mem1 mem2; do
    res=$(echo "$mem2-$mem1" | bc)
    echo "$pid : $com : $(echo "$mem2-$mem1" | bc)"
done |  sort -t ':' -nr -k3 | head -3 > "$output_file"
