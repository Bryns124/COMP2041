#!/usr/bin/python3 -u

import sys

n = sys.argv[1]

lines = []
while True:
    try:
        line = input()
        line = line.lower().replace(" ", "")
        lines.append(line)
        if len(set(lines)) == int(n):
            print(f"{n} distinct lines seen after {len(lines)} lines read.")
            sys.exit()
    except EOFError:
        print(f"End of input reached after {len(lines)} lines read - {n} different lines not seen.")
        sys.exit()
