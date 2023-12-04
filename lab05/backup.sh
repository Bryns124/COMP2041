#! /bin/dash

count=0
file=".$1.$count"
while [ -e "$file" ]; do
    file=".$1.$count"
    count=$((count + 1))
done

cat "$1" >> "$file"
echo "Backup of '$1' saved as '$file'"
