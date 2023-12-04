#!/usr/bin/env python3

import sys

n = int(sys.argv[1])
filename = sys.argv[2]

with open(filename, "r") as f:
    lines = f.readlines()
    space_indexes = []
    for line in lines:
        line = line.strip()
        if len(line) <= n:
            continue
        for i, c in enumerate(line):
            if c == " ":
                space_indexes.append(i)
        if len(space_indexes) == 0:
            continue
        index_less_than = []
        for i in space_indexes:
            if i < n:
                index_less_than.append(i)
            
    print(space_indexes)