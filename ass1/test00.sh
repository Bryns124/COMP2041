#!/bin/dash

# Tests for ./pigs-init

if [ -d ".pig" ]; then
    rm -rf ".pig"
fi

expected_output1="Usage: ./pigs-init"
expected_output2="Initialized empty pigs repository in .pig"
expected_output3="./pigs-init: error: .pig already exists"

# Check for incorrect usage
observed_output1=$(./pigs-init asd)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

# Check that .pig is initialised
observed_output2=$(./pigs-init)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that error displays if .pig already exists
observed_output3=$(./pigs-init)
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

# Check that necessary files and directories are initialised
if [ -f ".pig/log" ] && [ -f ".pig/status" ] && [ -d ".pig/commits" ] && [ -d ".pig/index" ]; then
    echo "Passed: Necessary files and directories were created"
else 
    echo "Failed: Files are missing"
fi

rm -r ".pig"