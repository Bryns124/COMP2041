#!/bin/dash

# Tests of ./pigs-add

for object in ".pig" "existent_file"; do
    if [ -e "${object}" ]; then 
        rm -rf "${object}"
    fi
done

expected_output1="./pigs-add: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-add <filenames>"
expected_output3="./pigs-add: error: can not open 'non_existent_file'"

# Check for when ./pigs-add is used before .pig is initialised
observed_output1=$(./pigs-add asd)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1> /dev/null
touch existent_file

# Check for incorrect usage
observed_output2=$(./pigs-add)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that error displays when trying to add a file that does not exist
observed_output3=$(./pigs-add non_existent_file)
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check that adding the specified file that exists is in the index
./pigs-add existent_file
if [ -f ".pig/index/existent_file" ] && [ -f "existent_file" ]; then
    echo "Passed: File exists and has been added to index"
else 
    echo "Failed: File does not exist and/or has not been added to index"
fi

rm -r .pig
rm existent_file