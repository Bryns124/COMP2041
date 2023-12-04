#!/bin/dash

# The read will most likely be mis-translated as input()

while read line; do [ -z "$line" ] && echo "Empty"; done