#!/bin/bash

ps -eo pid,etime,command | sort -k2 -r | head -n 2 | awk '{print $1}'