#!/usr/bin/env python3

import sys

fileName = sys.argv[1]
with open(fileName, "r") as f:
    lines = f.readlines()
    if len(lines) == 0:
        sys.exit(0)
    elif len(lines) % 2 == 0:
        mid1 = int((len(lines) - 2) / 2)
        mid2 = int(len(lines) / 2)
        print(lines[mid1].strip())
        print(lines[mid2].strip())
    elif len(lines) % 2 == 1:
        mid = int((len(lines) - 1) / 2)
        print(lines[mid].strip())