

import sys

first = int(sys.argv[1])
last = int(sys.argv[2])
filename = sys.argv[3]

i = first
while i <= last:
    file = open(filename, "a")
    file.write(f"{i}\n")
    file.close()
    i = i + 1