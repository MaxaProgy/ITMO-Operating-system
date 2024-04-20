#!/bin/bash

current_value=1
operation="+"

usr1() {
    current_value=$(echo $current_value | awk '{print $val + 2}')
    echo "| Handler | Current value = "$current_value}
}

usr2() {
	current_value=$(echo $current_value | awk '{print $val * 2}')
    echo "| Handler | Current value = "$current_value
}

sigterm() {
	echo "| Handler | Exit: TERM"
    exit
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true; do
    sleep 5
done