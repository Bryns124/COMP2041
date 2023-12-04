#! /bin/dash

snapshot-save.sh

for file in ".snapshot.$1"/*; do
    file_copy=$(echo "$file" | cut -d"/" -f2)
    cp -r "$file" "$file_copy"
done

echo "Restoring snapshot $1"