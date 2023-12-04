#! /usr/bin/env dash

while read -r id mark _; do
    echo -n "$id "
    if [ "$mark" -eq "$mark" ] 2 >/dev/null && [ "$mark" -ge 0 ] then
        if [ "$mark" -lt 50 ]; then
            echo "FL"
        elif [ "$mark" -lt 65 ]; then
            echo "PS"
        else echo "HD"
        fi
    else
        echo "?? ($mark)" >&2
    fi
done