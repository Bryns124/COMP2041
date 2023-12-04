#!/bin/dash

# demo00.sh displays:
# echo with no quotes, '' and ""
# read
# =
# $
# if-else
# Comments
# Backticks
# exit

# Comment 1
echo Enter a number: # Comment 2
read number

test_translation_number=$number
other_num=$1
date=`date +%Y-%m-%d`

if test $number -lt $other_num 
then
    # Comment 3
    echo "a is less than 20" # Comment 4
else
    echo "a is greater than 20"
fi

if test $test_translation_number -lt 20 
then
    # Comment 5
    echo "a is less than 20" # Comment 6
else
    echo "a is greater than 20"
fi

echo Hello `whoami`, today is $date

echo "command substitution still works in double quotes: `hostname`"

echo 'command substitution does not work in single quotes: `not a command`'

exit 0