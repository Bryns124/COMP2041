#! /bin/dash


for file in *.jpg; do
    baseFileName=$(basename "$file")
    baseFileName="${baseFileName%.*}"
    if [ -e "$baseFileName.png" ] && [ -e "$baseFileName.jpg" ]; then
        echo "$baseFileName.png already exists"
    else
        convert "$baseFileName.jpg" "$baseFileName.png"
        rm "$baseFileName.jpg"
    fi
done