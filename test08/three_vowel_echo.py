#!/usr/bin/env python3

import sys
import re

words = []
for word in sys.argv[1:]:
    if re.search(r'[aeiouAEIOU]{3}', word):
        words.append(word)

print(' '.join(words))