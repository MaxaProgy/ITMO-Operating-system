#!/bin/bash

restore_directory="$HOME/restore"
if [ ! -d $restore_directory ]; then
	mkdir $restore_directory
fi

latest_backup=$(find $HOME -maxdepth 1 -type d -name "Backup-*" -mtime -7 -print | sort -r | head -n 1)

if [[ ! -z "$latest_backup" ]]; then
	find $latest_backup -type f ! -regex ".[0-9]{4}-[0-9]{2}-[0-9]{2}" -exec cp {} "$restore_directory/" \; 
else
	echo "No Backup directories were found"
fi