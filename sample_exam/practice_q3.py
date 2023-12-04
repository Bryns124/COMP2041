#!/usr/bin/env python3

import sys
import re

unique_surnames = []
for line in sys.stdin.readlines():
    line = line.strip()
    if re.search(r'M$', line):
        line = line.split("|")[2].split(",")[0]
        unique_surnames.append(line)
        
for surname in sorted(set(unique_surnames)):
    print(surname)