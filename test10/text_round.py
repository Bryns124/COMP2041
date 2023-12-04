#!/usr/bin/python3 -u

import sys
import re

def rounded_num(match):
    return str(round(float(match.group(0))))

lines = []
for line in sys.stdin.readlines():
    line = line.strip()
    lines.append(line)
    
for line in lines:
    rounded_line = re.sub(r'(\d+\.\d+|\.\d+|\d+)', rounded_num, line)
    print(rounded_line)
