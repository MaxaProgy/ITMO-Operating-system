
#!/bin/bash

if [ $# -ne 1 ]; then
	echo "ERROR | Incorrect number of arguments"
	exit 1
fi

find_file_name="$1"
trash_directory="$HOME/.trash"
trash_log_file="$trash_directory/trash.log"

if [ ! -f $trash_log_file ]; then
	echo "ERROR | File trash.log does not existls"
	exit 1
fi


grep "$find_file_name" "$trash_log_file" | while read -r line; do
	file_path=$(echo $line | awk '{print $1}')
	trash_file=$(echo $line | awk '{print $2}')
    file_name=$(basename "$file_path")

	while true; do
        read -p "Retrash $file_path? [Y/n]: " answer < /dev/tty

		case $answer in
            [Nn]*)
                break
                ;;
            * )
                directory_name=$(dirname "$file_path")
                if [ ! -d "$directory_name" ]; then
                    echo "Directory $directory_name does not exist. New directory is $HOME"
                    directory_name="$HOME"
                fi

                
                if [ -f "$directory_name/$file_name" ]; then
                    echo "File with name $file_name already exists in $directory_name"

                    new_name=""
                    while [ -z "$new_name" ]; do
                        read -p "Indicate a new name: " new_name < /dev/tty
                        if [ -z "$new_name" ]; then
                            echo "Enter a non-empty name"
                        fi
                    done

                    file_name="$new_name"
                     
                fi

                ln "$trash_directory/$trash_file" "$directory_name/$file_name"
                rm "$trash_directory/$trash_file"
                sed -i "/$(echo "$line" | sed 's/[&/\]/\\&/g')/d" "$trash_log_file"
                echo "File was restored successfully"
                exit 0
                ;; 
            esac

	done
done
