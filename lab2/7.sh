#!/bin/bash

# Сбор информации о процессах и их использовании памяти
collect_proc_info() {
    ps -Ao pid,command | tail -n +2 | awk '{print $1":"$2}' |
    while read -r tmp; do
        pid=$(echo $tmp | awk -F ":" '{print $1}')
        com=$(echo $tmp | awk -F ":" '{print $2}')
        pth="/proc/$pid"
        if [ -f "$pth/io" ]; then
            byte=$(grep -h "read_bytes:" "$pth/io" | sed "s/[^0-9]*//")
            echo "$pid $com $byte"
        fi
    done | sort -nk1
}

# Сбор информации о процессах через минуту
sleep 1m
collect_proc_info > _b

# Сравнение и вывод результатов
paste _a _b | awk '{if ($1 == $4) print $1, $2, $3, $5}' | 
while read -r pid com mem1 mem2; do
    res=$(echo "$mem2-$mem1" | bc)
    echo "$pid : $com : $res"
done | sort -nrk3 | head -3 > 7.out
