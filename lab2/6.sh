#!/bin/bash

output_file="process_with_max_mem.out"

pid_process_with_max_ram=0
max_ram=0

for path in $(find /proc -maxdepth 2 -wholename '/proc/[0-9]*/status' -type f -readable); do
    rss=$(grep -s VmRSS $path | awk '{print $2}')

    if [[ $rss -gt $max_ram ]]; then
        max_ram=$rss
        pid_process_with_max_ram=$(grep -s PID $path | head -1 | awk '{print $2}')
    fi
done

# grep -s VmRSS $(find /proc -maxdepth 2 -wholename '/proc/[0-9]*/status' -type f -readable) | awk '{print $2}' | sort -n | tail -1 > "$output_file"

echo "/proc: Process_PID="$pid_process_with_max_ram" Memory="$max_ram > "$output_file"

top -bo RES | head -n8 | tail -n1 | awk '{print "top: Process_PID="$1" Memory="$6}' >> "$output_file"