#!/bin/dash

for file in "$@"; do
    numLines=$(wc -l "$file")
    echo "$numLines"
done | sort -nr | head -1 | cut -d" " -f2
