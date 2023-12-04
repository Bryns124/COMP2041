#!/bin/dash

# demo03.sh displays:
# echo with ""
# external commands with and without ""
# = with and without ''
# if statments
# =
# nested while loops
# Backticks
# $
# for loops
# file and string checking in if statements
# cd
# Comments
# exit

# Comment 1
DIR='test_dir'

mkdir "$DIR"
cd "$DIR"

touch file1.txt
touch file2.txt
echo "Created some files"

COUNT=1
while test $COUNT -le 2
do
    INNER_COUNT=1
    while test $INNER_COUNT -le 3
    do
        echo "Outer loop: $COUNT, Inner loop: $INNER_COUNT"
        INNER_COUNT=`expr $INNER_COUNT + 1` # Comment 3
    done
    COUNT=`expr $COUNT + 1`
done

for FILE in *.txt
do
    if test -f "$FILE"
    then
        echo "$FILE is a regular file."
    fi

    if test -r "$FILE"
    then
        echo "You have read permission for $FILE"
    fi

    if test -w "$FILE"
    then
        echo "You have write permission for $FILE"
    fi

    if test -x "$FILE"
    then
        echo "You have execute permission for $FILE"
    else
        echo "You don't have execute permission for $FILE"
    fi
done

STRING="Hello"
if test -n "$STRING"
then
    echo "String is not empty"
fi

EMPTY=""
if test -z "$EMPTY"
then
    echo "String is empty"
fi

cd ..
echo "Script finished."
exit 0
