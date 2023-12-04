#!/bin/dash

URL=http://www.timetable.unsw.edu.au/2023/"$1"KENS.html

curl --location --silent "$URL" | 
grep -E "$1" | 
grep -Ev "<td class=\"data\"><a href=\"$1[0-9]{4}.html\">$1[0-9]{4}</a></td>" |
sed -E "s/<td class=\"data\"><a href=\"($1[0-9]{4})\.html\">(.*)<\/a><\/td>/\1 \2/" | 
sort -n | uniq