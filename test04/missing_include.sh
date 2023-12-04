#! /bin/dash

for file in "$@"
do
    include_header=$(cat "$file" | grep -E '#include ".*"' | cut -d' ' -f2 | sed 's/"//g')
    for header in $include_header
    do
        if ! [ -e "$header" ]
        then
            echo "$header included into $file does not exist"
        fi
    done
done