#!/usr/bin/env python3

import sys

for line in sys.stdin.readlines():
    new_line = []
    letter_count = {}
    line = line.rstrip("\n")
    line = line.split()
    for word in line:
        letter_count = {}
        for char in word:
            char = char.lower()
            if char not in letter_count:
                letter_count[char] = 1
            else:
                letter_count[char] += 1
        unique_values = set(letter_count.values())
        if len(unique_values) == 1:
            new_line.append(word)
        else:
            continue
    print(' '.join(new_line))