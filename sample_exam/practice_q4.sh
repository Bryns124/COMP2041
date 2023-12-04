#!/bin/dash

filename=$1

min_num=$(sort -n "$filename" | head -n 1)
max_num=$(sort -n "$filename" | tail -n 1)

seq "$min_num" "$max_num" | sort -n > tmp1.txt
sort -n "$filename" > tmp2.txt

missing_num=$(comm -23 tmp1.txt tmp2.txt)

if [ -n "$missing_num" ]; then
    echo "$missing_num"
fi

rm tmp1.txt tmp2.txt