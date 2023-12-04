#!/usr/bin/env python3

import sys

args = []

for arg in sys.argv[1:]:
    args.append(arg)
    
noDupes = []
for arg in args:
    if arg not in noDupes:
        noDupes.append(arg)
        
for arg in noDupes:
    print(arg, end=" ")

print()