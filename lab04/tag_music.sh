#! /bin/dash

for dir in "$@"
do
    for song in "$dir"/*
    do
        if [ -e "$song" ]
        then
            title=$(echo "$song" | cut -d '-' -f2 | sed 's/\s//')
            artist=$(echo "$song" | cut -d '-' -f3 | sed 's/\.[^.]*$//' | sed 's/\s//')
            track=$(echo "$song" | grep -Eo '\/[0-9]+\s\-' | sed 's/\///g' | sed 's/\s\-//g')
            album=$(echo "$song" | cut -d'/' -f2)
            year=$(echo "$song" | cut -d'/' -f2 | sed 's/.*,\s//')
            id3 -t "$title" "$song" > /dev/null
            id3 -a "$artist" "$song" > /dev/null
            id3 -A "$album" "$song" > /dev/null
            id3 -y "$year" "$song" > /dev/null
            id3 -T "$track" "$song" > /dev/null
        fi
    done
done