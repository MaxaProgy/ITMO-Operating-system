#!/bin/bash

output_file="processes_start_in_sbin.txt"

ps -ef | grep '/sbin/' | awk '{print $2}' > "$output_file"⏎    