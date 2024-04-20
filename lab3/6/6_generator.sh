#!/bin/bash

pid=$1
if [[ -z $pid || $pid -eq 0 ]]; then
    echo "Process not found: $0"
    exit 1
fi

while read -r line; do
    if [[ "$line" == "TERM" ]]; then
        kill -SIGTERM $1
        echo "| Generator | Exit: TERM"
        exit
    fi

    if [[ "$line" == "+" ]]; then
        kill -USR1 $1
    fi

    if [[ "$line" == "*" ]]; then
        kill -USR2 $1
    fi
done