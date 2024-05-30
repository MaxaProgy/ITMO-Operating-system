#!/bin/bash

if [ $# -ne 1 ]; then
	echo "ERROR | Incorrect number of arguments"
	exit 1
fi

file_name="$1"

file_path="$(realpath "./$file_name")"

trash_directory="$HOME/.trash"
trash_log_file="$trash_directory/trash.log"

mkdir -p "$trash_directory"
if [ -f "$trash_log_file" ]; then
	touch "$trash_log_file"
fi

if [ -d "$file_name" ]
then
	echo "ERROR | It is directory"
	exit 1
fi

if [ ! -f "$file_name" ]; then
	echo "ERROR | File does not exist"
	exit 1
fi

link_file_name=$(date +%s%N)

ln "$file_path" "$trash_directory/$link_file_name"

rm "$file_path"
echo "$file_path $link_file_name" >> "$trash_log_file"