#!/bin/bash

output_file="process_stats.out"

for path in $(find /proc -maxdepth 1 -wholename '/proc/[0-9]*' -type d); do    
    if [ ! -f "$path/status" ] || [ ! -f "$path/sched" ]; then
        continue  
    fi

    pid=$(grep -shi "pid" "$path/status" | head -1 | awk '{print $2}')
 
    ppid=$(grep -shi "ppid" "$path/status" | awk '{print $2}')

    sum_runtime=$(grep -hsi "se\.sum_exec_runtime" $path"/sched" | awk '{print $3}') 
    count_switches=$(grep -hsi "nr_switches" $path"/sched" | awk '{print $3}')
    if [ -z $sum_runtime ] || [ -z $count_switches ];
    then
        art=0
    else
        art=$(echo "$sum_runtime $count_switches" | awk '{printf "%.5f", $1 / $2}')
    fi    

    echo "$pid $ppid $art"

done | sort -k2 -n | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > "$output_file"
