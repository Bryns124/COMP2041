#!/usr/bin/python3 -u

import sys
import subprocess
import re

url = "http://www.timetable.unsw.edu.au/2023/" + sys.argv[1] + "KENS.html"

process = subprocess.run(["curl", "--location", "--silent", url], capture_output=True)
string_output = process.stdout.decode("utf-8")

subjects = []
string_output = string_output.splitlines()
for line in string_output:
    if re.search(sys.argv[1], line) and not re.search(rf"{sys.argv[1]}[0-9].*{sys.argv[1]}[0-9]", line):
        formatted_line = re.sub(r'<td class=\"data\"><a href=\"(.*)\.html\">(.*)<\/a><\/td>', r'\1 \2', line)
        subjects.append(formatted_line)

for subject in set(sorted(subjects)):
    print(subject.strip())