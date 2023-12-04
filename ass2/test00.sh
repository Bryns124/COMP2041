#!/bin/dash

# The pipe will very likely be mis-translated as translating
# the pipe may require more and specific code for each command
# and combining them

value=`echo "1 2 3" | cut -d " " -f 2`
echo "The second value is: $value"