
#!/bin/bash

if [ $# -ne 1 ]; then
	echo "ERROR | Incorrect number of arguments"
	exit 1
fi

find_file_path="$(realpath "./$1")"
find_file_name="$(basename "$find_file_path")"

trash_directory="$HOME/.trash"
trash_log_file="$trash_directory/trash.log"

if [ ! -f $trash_log_file ]; then
	echo "ERROR | File trash.log does not exist"
	exit 1
fi

cat $trash_log_file | while read -r line; do
	trash_file=$(echo $line | awk '{print $2}')
	file_path=$(echo $line | awk '{print $1}')

    file_name=$(basename "$file_path")
    directory_name=$(dirname "$file_path")

    if [ "$file_name" != "$find_file_name" ]; then
        continue
    fi

	while true; do
        read -p "Retrash $file_path? [Y/n]: " answer_retrash < /dev/tty

        case "$answer_retrash" in
        [Nn])
            break
            ;;
        *)
            if [ ! -d "$directory_name" ]; then
                echo "Directory $directory_name does not exist."
                read -p "Should you save file in $HOME directory? [Y/n]: " answer_save_home < /dev/tty

                case "$answer_save_home" in
                [Nn])
                    while true; do
                        read -p "Indicate a new directory name: " directory_name < /dev/tty 
                        

                        if [ -z "$directory_name" ]; then
                            echo "--! Enter a non-empty path"
                            continue
                        fi

                        full_path_new_directory="$(realpath "$directory_name")"


                        if [ -f "$full_path_new_directory" ]; then
                            echo "--! The specified path is not a directory"
                            continue
                        
                        fi

                        if [ ! -e "$full_path_new_directory" ]; then
                            mkdir "$full_path_new_directory"
                            echo "--> New directory is $full_path_new_directory"
                            break
                        fi
                        
                        echo "--> New directory is $full_path_new_directory"                        
                        break
                    done

                    ;;
                *)
                    directory_name="$HOME"
                    ;;
                esac
                file_path="$directory_name/$file_name"

            fi

                
            if [ -e "$file_path" ]; then
                if [ -d "$file_path" ]; then
                    echo "--! Directory with name $file_name already exists in $file_path"
                else 
                    echo "--! File with name $file_name already exists in $file_path"
                fi

                while true; do
                    read -p "Indicate a new file name: " file_name < /dev/tty
                    
                    if [ -z "$file_name" ]; then
                        echo "--! Enter a non-empty name"
                        continue
                    fi

                    if [ -f "$directory_name/$file_name" ]; then
                        echo "--! File $new_file_name already exist"
                        continue
                    fi

                    if [ -d "$directory_name/$file_name" ]; then
                        echo "--! Directory $file_name already exist"
                        continue
                    fi

                    echo "--> New file name is $file_name"                        
                    break
                done

                file_path="$directory_name/$file_name"                  
            fi

            ln "$trash_directory/$trash_file" "$directory_name/$file_name"
            rm "$trash_directory/$trash_file"

            escaped_line=$(echo "$line" | sed 's/[&/\-]/\\&/g')
            awk "!/$escaped_line/" "$trash_log_file" > temp && mv temp "$trash_log_file"

            echo "File was restored successfully"
            
            exit 0
            ;;
        esac
	done
done
