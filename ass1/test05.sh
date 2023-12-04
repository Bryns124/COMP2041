#!/bin/dash

# Tests for ./pigs-rm

if [ -d ".pig" ]; then
    rm -rf ".pig"
fi

expected_output1="./pigs-rm: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-rm [--force] [--cached] <filenames>"
expected_output3="./pigs-rm: error: 'existent_file' is not in the pigs repository"
expected_output4="./pigs-rm: error: 'existent_file' has staged changes in the index"
expected_output5="./pigs-rm: error: 'existent_file' in index is different to both the working file and the repository"
expected_output6="./pigs-rm: error: 'existent_file' in the repository is different to the working file"

touch "existent_file"

# Check for when ./pigs-rm is used before .pig is initialised
observed_output1=$(./pigs-rm existent_file)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1>/dev/null

# Check for incorrect usage
observed_output2=$(./pigs-rm)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that error displays when --cached option is called
# and file is not in the index
observed_output3=$(./pigs-rm --cached "existent_file")
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check that error displays when --force option is called 
# and file exists but is still not in the index
observed_output4=$(./pigs-rm --force "existent_file")
if [ "$observed_output4" = "$expected_output3" ]; then
    echo "Passed: $observed_output4"
else
    echo "Failed: $observed_output4"
fi

# Check that error displays when --force and --cached option
# is called and file exists but is still not in the index
observed_output5=$(./pigs-rm --force --cached "existent_file")
if [ "$observed_output5" = "$expected_output3" ]; then
    echo "Passed: $observed_output5"
else
    echo "Failed: $observed_output5"
fi

./pigs-add "existent_file"

# Check that error displays when the file is in the current
# working directory and index but not in the latest commit
observed_output6=$(./pigs-rm "existent_file")
if [ "$observed_output6" = "$expected_output4" ]; then
    echo "Passed: $observed_output6"
else
    echo "Failed: $observed_output6"
fi

./pigs-commit -m "message1" 1>/dev/null
echo "hello" > existent_file
./pigs-add "existent_file"

# Check that error displays when the file is in the current
# working directory and index but not in the latest commit
observed_output7=$(./pigs-rm "existent_file")
if [ "$observed_output7" = "$expected_output4" ]; then
    echo "Passed: $observed_output7"
else
    echo "Failed: $observed_output7"
fi

echo "there" >> existent_file

# Check that error displays when the file in the index is
# different to both the file in the working directory and
# the latest commit when --cached option is used
observed_output8=$(./pigs-rm --cached "existent_file")
if [ "$observed_output8" = "$expected_output5" ]; then
    echo "Passed: $observed_output8"
else
    echo "Failed: $observed_output8"
fi

# Check that error displays when the file in the working
# directory is different to the file in the index and the
# latest commit.
observed_output9=$(./pigs-rm "existent_file")
if [ "$observed_output9" = "$expected_output5" ]; then
    echo "Passed: $observed_output9"
else
    echo "Failed: $observed_output9"
fi

./pigs-add "existent_file"
./pigs-commit -m "message2" 1>/dev/null

echo "guys" >> existent_file

# Check that error displays when the file in the working
# directory is the same as the file in the index but different
# to the file in the latest commit
observed_output10=$(./pigs-rm "existent_file")
if [ "$observed_output10" = "$expected_output6" ]; then
    echo "Passed: $observed_output10"
else
    echo "Failed: $observed_output10"
fi

rm -r ".pig/commits/.commit.0"
rm -r ".pig/commits/.commit.1"
rm ".pig/index/existent_file"
rm "existent_file"

touch "existent_file1"
./pigs-add "existent_file1"
./pigs-commit -m "message3" 1>/dev/null

# Indiviual tests for each ./pigs-rm command with or without --cached and/or --force options
if [ -f "existent_file1" ] && [ -f ".pig/index/existent_file1" ] && [ -f ".pig/commits/.commit.0/existent_file1" ]; then
    # Check that --cached removes the file from the index
    ./pigs-rm --cached "existent_file1"
    if [ ! -f ".pig/index/existent_file1" ] && [ -f "existent_file1" ] && [ -f ".pig/commits/.commit.0/existent_file1" ]; then
        echo "Passed: ./pigs-rm --cached deleted the staged copy"
    else 
        echo "Fail: ./pigs-rm --cached did not delete the staged copy"
    fi
    ./pigs-add "existent_file1"
    # Check that --force --cached removes the file from the index 
    ./pigs-rm --force --cached "existent_file1"
    if [ ! -f ".pig/index/existent_file1" ] && [ -f "existent_file1" ] && [ -f ".pig/commits/.commit.0/existent_file1" ]; then
        echo "Passed: ./pigs-rm --force --cached deleted the staged copy"
    else 
        echo "Fail: ./pigs-rm --force --cached did not delete the staged copy"
    fi
    ./pigs-add "existent_file1"
    # Check that no options removes the file from the index and current working directory
    ./pigs-rm "existent_file1"
    if [ ! -f ".pig/index/existent_file1" ] && [ ! -f "existent_file1" ] && [ -f ".pig/commits/.commit.0/existent_file1" ]; then
        echo "Passed: ./pigs-rm deleted the staged and working copy"
    else 
        echo "Fail: ./pigs-rm did not delete the staged and working copy"
    fi
    touch "existent_file1"
    ./pigs-add "existent_file1"
    # Check that --force removes the file from the index and current working directory
    ./pigs-rm --force "existent_file1"
    if [ ! -f ".pig/index/existent_file1" ] && [ ! -f "existent_file1" ] && [ -f ".pig/commits/.commit.0/existent_file1" ]; then
        echo "Passed: ./pigs-rm --force deleted the staged and working copy"
    else 
        echo "Fail: ./pigs-rm --force did not delete the staged and working copy"
    fi
fi

rm -r .pig