#!/bin/dash

regex=$1
filename=$2

# grep -Fv "$1" "$2"
grep -Fv "$1" "$2" | cut -d "|" -f2 | sort | uniq