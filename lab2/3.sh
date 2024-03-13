#!/bin/bash

ps -eo pid,ppid,lstart,command | tail -n +2 | awk -v pid=$$ '$1 != pid && $2 != pid {print $0}' | tail -n 1
