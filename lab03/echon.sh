#! /usr/bin/env dash

cur=0
positive_int=$(echo $1 | grep -E "^[0-9]+$")

if [ $# -eq 2 ]; then
    if [ -n "$positive_int" ] 2>/dev/null; then
        while [ "$cur" -lt "$1" ] 2>/dev/null; do
            echo "$2"
            cur=$((cur + 1))
        done
    else
        echo "$0: argument 1 must be a non-negative integer"
        exit 1
    fi
else 
    echo "Usage: $0 <number of lines> <string>"
    exit 1
fi 