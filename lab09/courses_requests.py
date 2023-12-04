#!/usr/bin/python3 -u

import sys
import re
import requests
from bs4 import BeautifulSoup

def extract_number(s):
    return int(re.search(rf'{sys.argv[1]}(\d+)', s).group(1))

url = "http://www.timetable.unsw.edu.au/2023/" + sys.argv[1] + "KENS.html"
response = requests.get(url)

soup = BeautifulSoup(response.text, 'html5lib')
table = soup.findAll('td', attrs={'class':'data'})

subjects = []
for line in table:
    if re.search(sys.argv[1], str(line)) and not re.search(rf"{sys.argv[1]}[0-9].*{sys.argv[1]}[0-9]", str(line)):
        formatted_line = re.sub(r'<td class=\"data\"><a href=\"(.*)\.html\">(.*)<\/a><\/td>', r'\1 \2', str(line))
        subjects.append(formatted_line.strip())

subjects = list(dict.fromkeys(subjects))
subjects.sort(key=extract_number)

for subject in subjects:
    print(subject)
