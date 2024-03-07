#!/bin/bash

output_file="processes_start_in_sbin.txt"

ps -ef | awk '$8 ~ /^\/sbin\// {print $2}'