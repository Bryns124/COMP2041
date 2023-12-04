#!/usr/bin/env python3

import sys

n = int(sys.argv[1])

inputs = []
while True:
    try:
        newInput = input()
        inputs.append(newInput)
        if inputs.count(newInput) == n:
            break
    except EOFError:
        sys.exit(0)

print(f"Snap: {newInput}")