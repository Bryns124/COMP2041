#! /usr/bin/env dash

small_files=''
medium_files=''
large_files=''

for file in '/import/adams/1/z5361001/2041/lab03/test'/*
do
    shortened_name=$(echo "$file" | cut -d'/' -f9)
    num_lines=$(wc -l "$file" | cut -d' ' -f1)
    if [ "$num_lines" -lt 10 ]; then
        small_files="$small_files $shortened_name"
    elif [ "$num_lines" -lt 100 ]; then
        medium_files="$medium_files $shortened_name"
    else 
        large_files="$large_files $shortened_name"
    fi
done

echo "Small files:$small_files"
echo "Medium-sized files:$medium_files"
echo "Large files:$large_files"