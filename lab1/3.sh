#!/bin/bash

echo -e "1. Nano\n2. Vim\n3. Links\n4. Exit"

read options
case $options in
    1 )
        nano
        ;;
    2 )
        vi
        ;;
    3 )
        links
        ;;
    4 )
        exit 0
        ;;
esac