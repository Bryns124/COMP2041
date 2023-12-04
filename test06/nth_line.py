#!/usr/bin/env python3

import sys

num = int(sys.argv[1])
filename = sys.argv[2]

with open(filename, "r") as file:
    lines = file.readlines()
    if num <= len(lines):
        print(lines[num-1].strip())