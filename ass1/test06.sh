#!/bin/dash

# Tests for ./pigs-status

if [ -d ".pig" ]; then
    rm -rf ".pig"
fi

expected_output1="./pigs-status: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-status"
expected_output3="- untracked"
expected_output4="- added to index"
expected_output5="- same as repo"
expected_output6="- deleted from index"
expected_output7="- file deleted, deleted from index"
expected_output8="- file changed, changes staged for commit"
expected_output9="- file changed, different changes staged for commit"
expected_output10="- file changed, changes not staged for commit"
expected_output11="- added to index, file changed"
expected_output12="- file deleted"
expected_output13="- added to index, file deleted"

# Check for when ./pigs-rm is used before .pig is initialised
observed_output1=$(./pigs-status)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1>/dev/null

# Check for incorrect usage
observed_output2=$(./pigs-status asd)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check if the file exists in the current working directory but 
# not the latest commit and index, it is 'untracked'
echo "hello" > status_file1
observed_output3=$(./pigs-status)
if [ "$observed_output3" = "status_file1 $expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check if the file exists in the current working directory and
# index but not the latest commit but there is no difference, it 
# is 'added to index'
./pigs-add status_file1
observed_output4=$(./pigs-status)
if [ "$observed_output4" = "status_file1 $expected_output4" ]; then
    echo "Passed: $observed_output4"
else
    echo "Failed: $observed_output4"
fi

# Check if there is no difference between the index and working 
# directory and the latest commit and working directory, it is 
# 'same as repo'
./pigs-commit -m "message1" 1> /dev/null
observed_output5=$(./pigs-status)
if [ "$observed_output5" = "status_file1 $expected_output5" ]; then
    echo "Passed: $observed_output5"
else
    echo "Failed: $observed_output5"
fi

# Check if the file exists in the current working directory and
# latest commit but not the index, it is 'deleted from index'
./pigs-rm --cached "status_file1"
observed_output6=$(./pigs-status)
if [ "$observed_output6" = "status_file1 $expected_output6" ]; then
    echo "Passed: $observed_output6"
else
    echo "Failed: $observed_output6"
fi

# Check if the file is in the latest commit but not in the 
# current working directory or in the index, it is 'file 
# deleted, deleted from index'
./pigs-add "status_file1"
./pigs-rm "status_file1"
observed_output7=$(./pigs-status)
if [ "$observed_output7" = "status_file1 $expected_output7" ]; then
    echo "Passed: $observed_output7"
else
    echo "Failed: $observed_output7"
fi

# Check if there is no difference between the index and
# the working directory but there is a difference between 
# the index and the latest commit, it is 'file changed,
# changes staged for commit'
echo "hello there" > status_file1
./pigs-add "status_file1"
observed_output8=$(./pigs-status)
if [ "$observed_output8" = "status_file1 $expected_output8" ]; then
    echo "Passed: $observed_output8"
else
    echo "Failed: $observed_output8"
fi

# Check if there is a difference between all three stages,
# it is 'file changed, different changes staged for commit'
echo "man" >> status_file1
observed_output9=$(./pigs-status)
if [ "$observed_output9" = "status_file1 $expected_output9" ]; then
    echo "Passed: $observed_output9"
else
    echo "Failed: $observed_output9"
fi

# Check if there is a difference between the index and working
# directory and the latest commit and working directory but no
# difference between the index and latest commit, it is 'file 
# changed, changes not staged for commit'
./pigs-commit -m "message2" 1> /dev/null
observed_output10=$(./pigs-status)
if [ "$observed_output10" = "status_file1 $expected_output10" ]; then
    echo "Passed: $observed_output10"
else
    echo "Failed: $observed_output10"
fi

# Check if the file exists in the current working directory 
# and index but not the latest commit and there is a difference
# between the file in the working directory and the index, it 
# is 'added to index, file changed'
rm -r ".pig/commits/.commit.0"
rm -r ".pig/commits/.commit.1"
observed_output11=$(./pigs-status)
if [ "$observed_output11" = "status_file1 $expected_output11" ]; then
    echo "Passed: $observed_output11"
else
    echo "Failed: $observed_output11"
fi

# Check if the file is in the index and latest commit but not in
# the current working directory, it is 'file deleted'
./pigs-commit -m "message3" 1> /dev/null
rm "status_file1"
observed_output12=$(./pigs-status)
if [ "$observed_output12" = "status_file1 $expected_output12" ]; then
    echo "Passed: $observed_output12"
else
    echo "Failed: $observed_output12"
fi

# Check if the file is in the index but not in the current working
# directory and latest commit, it is 'added to index, file deleted'
rm -r ".pig/commits/.commit.0"
observed_output13=$(./pigs-status)
if [ "$observed_output13" = "status_file1 $expected_output13" ]; then
    echo "Passed: $observed_output13"
else
    echo "Failed: $observed_output13"
fi

rm -r ".pig"