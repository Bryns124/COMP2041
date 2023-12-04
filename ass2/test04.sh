#!/bin/dash

# The final line will most likely be mis-translated as
# it would be a complex translation considering the 
# special cases for $@

path="$1"
shift

ls -las "$(echo "$path")/$@"