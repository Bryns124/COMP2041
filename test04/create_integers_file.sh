#! /bin/dash

first_num=$1
second_num=$2
file_name=$3

while [ "$first_num" -le "$second_num" ]; do
    echo "$first_num" >> "$file_name"
    first_num=$((first_num + 1))
done