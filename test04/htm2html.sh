#! /bin/dash

for file in *.htm; do
    new_file=$(echo "$file" | sed -E "s/.htm$/.html/")
    if [ -e "$new_file" ]; then
        echo "$new_file exists"
        exit 1
    else
        mv "$file" "$new_file"
    fi
done