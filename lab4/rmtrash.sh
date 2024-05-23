#!/bin/bash

if [ $# -ne 1 ]; then
	echo "ERROR | Incorrect number of arguments"
	exit 1
fi

file_name="$1"
trash_directory="$HOME/.trash"
trash_log_file="$trash_directory/trash.log"

if [ ! -d $trash_directory ]; then
	mkdir $trash_directory
fi

if [ ! -e $file_name ]; then
	echo "ERROR | File does not exist"
	exit 1
fi

link_file_name=$(date +%s%N)

ln $file_name "$trash_directory/$link_file_name"

rm $file_name
echo "$PWD/$file_name $link_file_name" >> "$trash_log_file"