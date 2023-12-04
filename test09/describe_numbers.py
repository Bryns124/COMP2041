#!/usr/bin/python3 -u

import sys
import statistics

def prod(list):
    product = 1
    for i in list:
        product *= i
    return product

num_list = []
for num in sys.argv[1:]:
    num_list.append(int(num))

mean = (sum(num_list))/len(num_list)
if mean.is_integer():
    mean = int(mean)
median = sorted(num_list)[int(len(num_list)/2)]
mode = statistics.mode(num_list)

print(f"count={len(num_list)}")
print(f"unique={len(set(num_list))}")
print(f"minimum={min(num_list)}")
print(f"maximum={max(num_list)}")
print(f"mean={mean}")
print(f"median={median}")
print(f"mode={mode}")
print(f"sum={sum(num_list)}")
print(f"product={prod(num_list)}")