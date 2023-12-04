#!/usr/bin/env python3

import sys
import re
import os
import math

def total_words(filename):
    words = []
    with open(filename, "r") as f:
        lines = f.readlines()
        for line in lines:
            seps = re.split("[^a-zA-Z]", line)
            for sep in seps:
                if not sep:
                    continue
                words.append(sep)
    return len(words)

def count_word(word, filename):
    wordSearch = word
    words = []
    with open(filename, "r") as f:
        lines = f.readlines()
        for line in lines:
            seps = re.split("[^a-zA-Z]", line)
            for sep in seps:
                sep = sep.lower()
                if sep == wordSearch:
                    words.append(sep)
    return len(words)
    
def get_name(file):
    name = file.split("/")[1]
    name = name.split(".")[0]
    name = name.replace("_", " ")
    return name

if __name__ == "__main__":
    for filename in sorted(os.listdir('lyrics')):
        f = os.path.join('lyrics', filename)
        if os.path.isfile(f):
            log_sum = 0
            total = int(total_words(f))
            name = get_name(f)
            for word in sys.argv[1:]:
                count = int(count_word(word, f)) + 1
                freq = count / total
                log_value = math.log(freq)
                log_sum += log_value
            print(f"{log_sum:10.5f} {name}")