#! /usr/bin/env dash

grep -E 'COMP[29]04[14]' $1 | cut -d' ' -f2 | sort | uniq -c | sort | tail -n 1 | grep -Eo "[A-Z].*"