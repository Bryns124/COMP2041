#! /usr/bin/env dash

# file is just a variable name

for file in *.c; do
    echo "$file includes:"
    grep -E "^#include" "$file" |
    sed 's/[">][^">]*$//' |
    sed 's/^.*[">]/     /'
done