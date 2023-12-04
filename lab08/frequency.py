#!/usr/bin/env python3

import sys
import re
import os

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
            count = int(count_word(sys.argv[1], f))
            total = int(total_words(f))
            freq = count / total
            name = get_name(f)
            print(f"{count : >4}/ {total} = {freq:0,.9f} {name}")