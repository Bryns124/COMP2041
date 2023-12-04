#!/bin/dash

for file1 in "$1"/*; do
    fileName=$(basename "$file1")
    if [ -f "$2/$fileName" ]; then
        if cmp -s "$file1" "$2/$fileName"; then
            echo "$fileName"
        fi
    fi
done