#!/bin/bash

output_file="user_processes.txt"

ps -U maxa | wc -l > "$output_file"
ps -U maxa -o pid,comm >> "$output_file"
