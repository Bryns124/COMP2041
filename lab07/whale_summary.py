#!/usr/bin/env python3

import sys

whales = {}
for filename in sys.argv[1:]:
    with open(filename, "r") as file:
        lines = file.readlines()
        for line in lines:
            line = line.split()
            num = int(line[1])
            name = ' '.join(line[2:]).lower()
            if name.endswith(('s')):
                name = name[:-1]
            if name not in whales:
                whales[name] = {"pods": 1, "individuals": num}
            else:
                whales[name]["pods"] += 1
                whales[name]["individuals"] += num

for name, info in sorted(whales.items()):
    print(f"{name} observations: {info['pods']} pods, {info['individuals']} individuals")