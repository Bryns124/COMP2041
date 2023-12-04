#!/bin/dash

# Tests for ./pigs-log

for object in ".pig" "log_file" "expected_output4" "observed_output4"; do
    if [ -e "${object}" ]; then 
        rm -rf "${object}"
    fi
done

expected_output1="./pigs-log: error: pigs repository directory .pig not found"
expected_output2="Usage: ./pigs-log"
expected_output3="0 message1"

# Check for when ./pigs-log is used before .pig is initialised
observed_output1=$(./pigs-log)
if [ "$observed_output1" = "$expected_output1" ]; then
    echo "Passed: $observed_output1"
else
    echo "Failed: $observed_output1"
fi

./pigs-init 1>/dev/null
echo log1 >log_file
./pigs-add log_file
./pigs-commit -m "message1" 1>/dev/null

# Check for incorrect usage
observed_output2=$(./pigs-log asd)
if [ "$observed_output2" = "$expected_output2" ]; then
    echo "Passed: $observed_output2"
else
    echo "Failed: $observed_output2"
fi

# Check that ./pigs-log displays the commit history after a
# commit is made
observed_output3=$(./pigs-log)
if [ "$observed_output3" = "$expected_output3" ]; then
    echo "Passed: $observed_output3"
else
    echo "Failed: $observed_output3"
fi

echo log2 >log_file
./pigs-commit -a -m "message2" 1>/dev/null

echo "1 message2" >> expected_output4
echo "0 message1" >> expected_output4
./pigs-log > observed_output4

# Check that ./pigs-log displays the commit history after another
# commit is made
if [ -z "$(diff -q observed_output4 expected_output4)" ] >/dev/null; then
    echo "Passed: Logs commits correctly"
else
    echo "Failed: Failed to log commits correctly"
fi

rm -r ".pig"
rm "log_file"
rm "expected_output4"
rm "observed_output4"