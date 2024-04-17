#!/bin/bash

current_value=1
opertion="+"
pipe_name=$1

if [[ -z $pipe_name ]]; then
    echo "Pipe not found: $0"
    exit 1
fi

(tail -f $pipe_name ; pid=$!) | 
    while read -r line; do
        if [[ "$line" == "+" ]] || [[ "$line" == "*" ]]; then
            opertion="$line"
            echo "| Handler | Current operation: $line"
        elif [[ "$line" =~ ^[[:digit:]]+ ]]; then
            if [[ "$opertion" == "+" ]]; then
                current_value=$(echo $current_value $line | awk '{print $1 + $2}')
            else
                current_value=$(echo $current_value $line | awk '{print $1 * $2}')
            fi
            echo "| Handler | Current value = "$current_value

        elif [[ "$line" == "QUIT" ]]; then
            kill $pid
            echo "| Handler | Exit 0: ok | Result = "$current_value
            exit
        else
            kill $pid
            echo "| Handler | Exit 1: invalid operations"
            exit 1
        fi
    done