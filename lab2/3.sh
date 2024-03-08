#!/bin/bash

ps -eo pid,lstart,command | tail -n 4 | head -n 1
