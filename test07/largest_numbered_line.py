#!/usr/bin/env python3

import sys
import re

lines = []
nums = []
for line in sys.stdin:
    try:
        if re.search("(-?[0-9]*\.?[0-9]+)", line):
            lines.append(line)
        nums.append(re.findall("(-?[0-9]*\.?[0-9]+)", line))
    except EOFError:
        sys.exit(0)

floats = []
for subList in nums:
    for num in subList:
        floats.append(float(num))

for string in lines:
    stringInts = re.findall("(-?[0-9]*\.?[0-9]+)", string)
    stringFloats = [float(i) for i in stringInts]
    if max(floats) in stringFloats:
        print(string, end='')