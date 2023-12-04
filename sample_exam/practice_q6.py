#!/usr/bin/env python3

import sys
import re

file1 = sys.argv[1]
file2 = sys.argv[2]

file1_lines = []
file2_lines = []
with open(file1, "r") as f1:
    lines = f1.readlines()
    for line in lines:
        file1_lines.append(line)
        
with open(file2, "r") as f2:
    lines = f2.readlines()
    for line in lines:
        file2_lines.append(line)

if len(file1_lines) != len(file2_lines):
    print(f"Not mirrored: different number of lines: {len(file1_lines)} versus {len(file2_lines)}")
    sys.exit(0)

for i, (line1, line2) in enumerate(zip(file1_lines, file2_lines[::-1]), 1):
    if line1 != line2:
        print(f"Not mirrored: line {i} was different")
        sys.exit(0)

print("Mirrored")