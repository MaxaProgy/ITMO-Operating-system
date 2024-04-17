#!/bin/bash

pipe_name=pipe
mkfifo $pipe_name
handler=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/5/5_handler.sh
generator=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/5/5_generator.sh

bash $handler $pipe_name & 
bash $generator $pipe_name

rm pipe