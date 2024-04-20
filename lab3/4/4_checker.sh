#!/bin/bash

pid=$1
limit=$2

if [[ -z $pid || $pid -eq 0 ]]; then
    echo "Process not found: $0"
    exit 1
fi

if [[ -z $limit || $limit -eq 0 ]]; then
    echo "Limit not found: $0"
    exit 1
fi

current=$(ps -o ni $pid | tail -n 1)
while true; do
	cpu=$(ps -p $pid -o %cpu --no-headers)
    echo $cpu
    if (( $(echo "$cpu > $limit" | bc -l) )); then
        current=$(($current+1))
        renice -n "$current" -p $pid

    elif (( $(echo "$cpu < $limit" | bc -l) )); then
        current=$(($current-1))
        renice -n "$current" -p $pid
    fi
    sleep 1
done