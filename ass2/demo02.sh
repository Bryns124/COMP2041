#!/bin/dash

# demo02.sh displays:
# echo with no quotes and ""
# nested for and while loops
# Backticks
# =
# $
# Comments
# exit

for i in 1 2 3
do
    echo Iteration of outer loop: $i

    j=1
    # Comment 2
    while test $j -le 3
    do
        echo "    Iteration of inner loop: $j" # Comment 3
        j=`expr $j + 1`
    done
done

exit 0