#!/usr/bin/env python3

import sys

fileName = sys.argv[1]

with open(fileName, "r") as f:
    lines = f.readlines()
    sortedAlphabetical = sorted(lines)
    sortedLength = sorted(sortedAlphabetical, key=len)
    for word in sortedLength:
        print(word.strip())