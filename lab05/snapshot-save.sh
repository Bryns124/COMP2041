#! /bin/dash

count=0
while true; do
    if [ -d ".snapshot.$count" ]; then
        count=$((count + 1))
    else
        mkdir ".snapshot.$count"
        for file in *; do
            if [ "$file" != "snapshot-save.sh" ] && [ "$file" != "snapshot-load.sh" ] && [ "$file" != "backup.sh" ]; then
                cp -r "$file" ".snapshot.$count/$file"
            fi
        done
        echo "Creating snapshot $count"
        exit 0
    fi
done