#!/bin/dash

# The increment will likely be mis-translated due to 
# the : command
count=0
while [ "$count" -lt 10 ]; do
    if [ $(($count % 2)) -eq 0 ]; then
        echo "$count is even."
    else
        echo "$count is odd."
    fi
    : $((count++))
done