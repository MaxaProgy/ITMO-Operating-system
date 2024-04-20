#!/bin/bash

report_file=$HOME/report
test=$HOME/test

mkdir $test && 
    { 
    echo "catalog test was created successfully" >> $report_file
    touch $test/$(date +"%Y-%m-%d_%H-%M-%S")
    }

ping -c 1 www.net_nikogo.ru || echo "$(date +"%Y-%m-%d_%H-%M-%S") Can't connect www.net_nikogo.ru" >> $report_file