#! /bin/dash

for arg in "$@"; do
    datetime=$(ls -l | grep -E "$arg" | cut -d" " -f8)
    convert -gravity south -pointsize 36 -draw "text 0,10 '$datetime'" "$arg" "$arg"
done