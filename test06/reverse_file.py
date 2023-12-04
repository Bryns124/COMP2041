#!/usr/bin/env python3

import sys

file1 = sys.argv[1]
file2 = sys.argv[2]

with open(file1, 'r') as f1:
    lines = f1.readlines()
    reverseLines = lines[::-1]
    with open(file2, 'w') as f2:
        for lines in reverseLines:
            f2.write(lines)