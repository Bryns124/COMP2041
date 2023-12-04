

import sys

orcas = []
count = 0
for filename in sys.argv[1:]:
    with open(filename, "r") as file:
        lines = file.readlines()
        for line in lines:
            line = line.split()
            # print(line)
            if line[2] == 'Orca':
                count += int(line[1])
print(f'{count} Orcas reported')