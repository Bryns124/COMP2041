#!/usr/bin/env python3

import sys
import re

wordSearch = sys.argv[1]
words = []
while True:
    line = sys.stdin.readline()
    if not line:
        break
    seps = re.split("[^a-zA-Z]", line)
    for sep in seps:
        sep = sep.lower()
        if sep == wordSearch:
            words.append(sep)

print(f"{wordSearch} occurred {len(words)} times")