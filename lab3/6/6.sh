#!/bin/bash

handler=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/6/6_handler.sh
generator=/home/maxalaptop/4sem/ITMO-Operating-system/lab3/6/6_generator.sh

bash $handler & 
bash $generator $(pgrep -nf $handler)

