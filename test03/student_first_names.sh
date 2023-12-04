#! /usr/bin/env dash

cut -d'|' -f2,3 $1 | sort | uniq | cut -d' ' -f2 | sort