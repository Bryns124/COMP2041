#! /usr/bin/env dash

# if statements 1, 2, 3 args
#  increment things in a loop

# $# is the number of arguments
# $1,2,3,4... is the argument

case $# in
    1)
        FIRST=1
        INCREMENT=1
        LAST=$1
        ;;
    2)
        FIRST=$1
        INCREMENT=1
        LAST=$2
        ;;
    3)
        FIRST=$1
        INCREMENT=$2
        LAST=$3
        ;;
    *)
        echo "Usage: $0 [FIRST [INCREMENT]] LAST" >&2
esac

if [ "$FIRST" -eq "$FIRST" ] 2> /dev/null; then
    ;
else
    echo "$0: Error <FIRST> must be an integer"
    exit
fi

if [ "$INCREMENT" -eq "$INCREMENT" ] 2> /dev/null; then
    ;
else
    echo "$0: Error <INCREMENT> must be an integer"
    exit
fi
    
if [ "$LAST" -eq "$LAST" ] 2> /dev/null; then
    ;
else
    echo "$0: Error <LAST> must be an integer"
    exit
fi

if [ "$FIRST" -lt "$LAST" ] 2> /dev/null; then
    ;
else
    echo "$0: Error <FIRST> must be greater than <LAST>"
    exit
fi

cur=$FIRST
while [ "$cur" -le "$LAST" ]; do
    echo "$cur"
    cur=$((cur + INCREMENT))
done