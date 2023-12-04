#!/bin/dash

# demo03.sh displays:
# echo with ""
# read
# if statment
# =
# nested while loops
# Backticks
# $
# Comments
# exit

# Comment 1
echo "Enter a number for loop iterations:"
read num

# Comment 2
if test $num -lt 1
then
    echo "Number must be greater than 0"
    exit 1
fi

i=1
while test $i -le $num
do
    echo "For loop 'iteration': $i"
    
    counter=1
    while test $counter -le 3
    do
        echo "    While loop 'iteration': $counter"
        
        if test $counter -eq 2 
        then
            echo "        This is the second 'iteration' of the while loop"
        fi
        
        counter=`expr $counter + 1` # Comment 3
    done

    i=`expr $i + 1`
done
exit 0