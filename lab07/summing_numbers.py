#!/usr/bin/env python3

import sys
import re

sum = 0
with open(sys.argv[1], "r") as file:
    lines = file.readlines()
    for line in lines:
        numbers = re.findall('[0-9]+', line)
        for number in numbers:
            sum += int(number)
print(sum)