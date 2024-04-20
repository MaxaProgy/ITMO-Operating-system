#!/bin/bash

file_inf_loop=$HOME/4sem/ITMO-Operating-system/lab3/inf.sh

$file_inf_loop &
$file_inf_loop &
$file_inf_loop &

pid_first=$(pgrep -of $file_inf_loop)
pid_last=$(pgrep -nf $file_inf_loop)

cpulimit -p $pid_first -l 10 &
kill $pid_last