#!/bin/bash

file_inf_loop=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/4/inf.sh
file_checker_NI=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/4/4_checker.sh

$file_inf_loop &
$file_inf_loop &
$file_inf_loop &

pid_first=$(pgrep -of $file_inf_loop)
pid_last=$(pgrep -nf $file_inf_loop)

# renice -n 20 $pid_first
echo $pid_first
kill $pid_last

$file_checker_NI $pid_first 10

