#!/bin/bash

input_file="process_stats.out"
output_file="extended_process_stats.out"


last_ppid=0
childrens_art=0
childrens_count=0

while read pid ppid art; do
     if [[ $ppid == $last_ppid ]]; then
        ((childrens_count++))
        childrens_art=$(echo "$childrens_art $art" | awk '{printf "%.5f", $1 + $2}')
    else
        if [[ -n $last_ppid ]]; then
            average=$(echo "$childrens_art $childrens_count" | awk '{printf "%.5f", $1 / $2}')
            echo "Average_Children_Running_Time_Of_ParentID="$last_ppid" is "$average
        fi
        
        last_ppid=$ppid
        childrens_art=$art
        childrens_count=1
    fi

    if [[ -n $pid ]]; then
        echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$art
    fi
done < <(awk -F '[=:]' '{print $2 $4 $6}' "$input_file") > "$output_file"

average=$(echo "$childrens_art $childrens_count" | awk '{printf "%.5f", $1 / $2}')
echo "Average_Children_Running_Time_Of_PaarentID="$last_ppid" is "$average >> "$output_file"
