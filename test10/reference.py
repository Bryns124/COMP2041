#!/usr/bin/python3 -u

import sys
import re

lines = []
for line in sys.stdin.readlines():
    line = line.strip()
    lines.append(line)

for line in lines:
    if re.search(r'^#[0-9]+', line):
        num = int(line.replace("#", ""))
        print(lines[num - 1])
    else:
        print(line)