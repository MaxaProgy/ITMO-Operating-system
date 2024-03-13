#!/bin/bash

start_script=$(date +"%Y-%m-%d_%H-%M-%S")
report_file=$HOME/report
mkdir test && 
    { 
    echo "catalog test was created successfully" > $report_file
    touch test/$start_script 
    }

ping -c 1 www.net_nikogo.ru || echo "$(date +"%Y-%m-%d_%H-%M-%S") ERROR PING" >> $report_file