#!/bin/dash

# Tests for ./pigs-commit

for object in ".pig" "existent_file"; do
    if [ -e "${object}" ]; then 
        rm -rf "${object}"
    fi
done

expected_output1="./pigs-commit: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-commit [-a] -m <commit-message>"
expected_output3="Committed as commit 0"
expected_output4="nothing to commit"
expected_output5="Committed as commit 1"

# Check for when ./pigs-commit is used before .pig is initialised
observed_output1=$(./pigs-commit asd)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1> /dev/null
touch existent_file
./pigs-add existent_file

# Check for incorrect usage
observed_output2=$(./pigs-commit)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that a new commit is made for the file/s in the index
observed_output3=$(./pigs-commit -m 'message1')
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check that there is nothing to commit when the file/s in
# the index and the latest commit are the same
observed_output4=$(./pigs-commit -m 'message2')
if [ "$observed_output4" = "$expected_output4" ]; then
    echo "Passed: $observed_output4"
else
    echo "Failed: $observed_output4"
fi

echo hello > existent_file

# For the file in the index, check that a new commit is made
# when the same file in the current working directory is changed
observed_output5=$(./pigs-commit -a -m 'message3')
if [ "$observed_output5" = "$expected_output5" ]; then
    echo "Passed: $observed_output5"
else
    echo "Failed: $observed_output5"
fi

rm -r .pig
rm existent_file