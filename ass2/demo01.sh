#!/bin/dash

# demo01.sh displays:
# echo
# external commands
# for loops
# $
# Comments
# exit

# Comment 1
touch test_file.txt
ls -l test_file.txt

# For loops with external commands
for course in COMP1511 COMP1521 COMP2511 COMP2521
do
    echo $course
    mkdir $course
    chmod 700 $course # Comment 2
done

for course in COMP1511 COMP1521 COMP2511 COMP2521
do
    rmdir -v $course
    echo $course
done

rm test_file.txt # Comment 3
exit 0