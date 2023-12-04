#! /bin/dash

for arg in "$@"; do
    display "$arg"
    echo "Address to e-mail this image to? "
    read address
    if [ -z "$address" ] || [  ]; then
        echo "No email sent"
        continue
    fi
    echo "Message to accompany image? "
    read message
    mutt -s "$message" -e 'set copy=no' -a "$arg" -- "$address"

    if [ $(echo "$?") -eq 0 ]; then
        echo "$arg sent to $address"
    else
        echo "No email sent"
    fi
done