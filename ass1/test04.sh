#!/bin/dash

# Tests for ./pigs-show

for object in ".pig" "show_file1"; do
    if [ -e "${object}" ]; then 
        rm -rf "${object}"
    fi
done

expected_output1="./pigs-show: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-show [<commit>]:<filename>"
expected_output3="./pigs-show: error: unknown commit '2'"
expected_output4="./pigs-show: error: 'not_show_file' not found in commit 0"
expected_output5="./pigs-show: error: 'show_file1' not found in index"
expected_output6="log1"

# Check for when ./pigs-show is used before .pig is initialised
observed_output1=$(./pigs-show)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1>/dev/null
echo "log1" > show_file1
./pigs-add show_file1
./pigs-commit -m "message1" 1>/dev/null

# Check for incorrect usage
observed_output2=$(./pigs-show)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that an error displays for a commit that does not exist
observed_output3=$(./pigs-show 2:not_show_file)
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check that an error displays for a commit that exists but
# specified file does not exist in the commit
observed_output4=$(./pigs-show 0:not_show_file)
if [ "$observed_output4" = "$expected_output4" ]; then
    echo "Passed: $observed_output4"
else
    echo "Failed: $observed_output4"
fi

rm ".pig/index/show_file1"

# Check that an error displays when specified file does not
# exist in the index
observed_output5=$(./pigs-show :show_file1)
if [ "$observed_output5" = "$expected_output5" ]; then
    echo "Passed: $observed_output5"
else
    echo "Failed: $observed_output5"
fi

./pigs-add "show_file1"

# Check that content from the specified filename in the specified
# commit is displayed
observed_output6=$(./pigs-show 0:show_file1)
if [ "$observed_output6" = "$expected_output6" ]; then
    echo "Passed: ./pigs-show displays contents of show_file1 from the 0th commit"
else
    echo "Failed: ./pigs-show does not display contents of show_file1 from the 0th commit"
fi

# Check that content from the specified filename from the index, when
# the commit is omitted, is displayed.
observed_output7=$(./pigs-show :show_file1)
if [ "$observed_output7" = "$expected_output6" ]; then
    echo "Passed: ./pigs-show displays contents of show_file1 in the index"
else
    echo "Failed: ./pigs-show does not display contents of show_file1 in the index"
fi

rm -r .pig
rm show_file1