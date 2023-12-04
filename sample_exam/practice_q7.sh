#!/bin/dash


for file in "$@";
do
    first_line=$(head -1 "$file")
    extension=""

    if echo "$first_line" | grep -q "perl"; then
        extension="pl"
    elif echo "$first_line" | grep -q "python"; then
        extension="py"
    elif echo "$first_line" | grep -q "sh"; then
        extension="py"
    fi

    new_file_name="$file.$extension"

    if echo "$file" | grep -q "\."; then
        echo "# $file already has an extension"
    elif [ "$(head -c2 "$file")" != '#!' ]; then
        echo "# $file does not have a #! line"
    elif [ -z "$extension" ]; then
        echo "# $file no extension for #! line"
    elif [ -e "$new_file_name" ]; then
        echo "# $new_file_name already exists"
    else 
        echo "mv $file $new_file_name"
    fi
done
