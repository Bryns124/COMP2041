#!/usr/bin/python3 -u

import sys
import re

regex = sys.argv[1]
file = sys.argv[2]

with open(file, "r") as f:
    lines = f.readlines()
    for line in lines:
        if re.search(regex, line):
            print(line.strip())