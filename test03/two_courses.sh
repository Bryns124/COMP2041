#! /usr/bin/env dash

cut -d'|' -f2 $1 | sort | uniq -c | grep -E '2\s' | sed -E 's/^\s*2\s+([0-9]{7})$/\1/'