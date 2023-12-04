#!/usr/bin/env python3

import re
import sys

words = []
while True:
    line = sys.stdin.readline()
    if not line:
        break
    seps = re.split("[^a-zA-Z]", line)
    for sep in seps:
        if not sep:
            continue
        words.append(sep)
        
print(f"{len(words)} words")