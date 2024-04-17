#!/bin/bash

pipe_name=$1

if [[ -z $pipe_name ]]; then
    echo "Pipe not found: $0"
    exit 1
fi


while read -r line; do
	echo "$line" > $pipe_name

	if [[ "$line" == "QUIT" ]]; then
        echo "| Generator | Exit 0: ok"
        exit
    fi

    if [[ "$line" != "+" && "$line" != "*" ]] && ! [[ "$line" =~ ^[[:digit:]]+ ]]; then
        echo "| Generator | Exit 1: invalid operations"
        exit 1
    fi
done