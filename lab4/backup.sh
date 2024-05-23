#!/bin/bash

work_directory="$HOME"
backup_directory="$work_directory/Backup-$(date +%Y-%m-%d)"
backup_report_file="$work_directory/backup-report"

source_directory="$work_directory/source"
if [ ! -d $source_directory ]; then
	mkdir $s@ource_directory
fi

latest_backup=$(find $work_directory -maxdepth 1 -type d -name "Backup-*" -mtime -7 -print | sort -r | head -n 1)

if [[ -z $latest_backup ]]; then
    mkdir $backup_directory
    cp -r $source_directory/* $backup_directory
    echo "New backup directory created: $backup_directory on $(date)" >> $backup_report_file
    ls $source_directory >> $backup_report_file
    exit 0
fi

for source_file in $source_directory/*; do
    file_name=$(basename "$source_file")
    destination_file="$latest_backup/$file_name"

    if [[ ! -f $destination_file ]]; then
        cp $source_file $latest_backup
        
        echo "Added $file_name" >> $backup_report_file
    else 
        cmp -s "$source_file" "$destination_file"
        if (( $?!= 0 )); then 
            mv $destination_file "${destination_file}.$(date +%Y-%m-%d)"
            cp $source_file $latest_backup
            echo "Updated $file_name as ${file_name}.$(date +%Y-%m-%d)" >> $backup_report_file
        fi
    fi
done
