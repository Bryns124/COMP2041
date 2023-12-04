#!/usr/bin/python3 -u

import sys

shift = int(sys.argv[1])

uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
lowercase = 'abcdefghijklmnopqrstuvwxyz'
while True:
    encrypted_string = []
    try:
        line = input()
    except EOFError:
        break
    
    for char in line:
        if 'A' <= char <= 'Z':
            position = uppercase.find(char)
            encrypted_string.append(uppercase[(position + shift) % 26])
        elif 'a' <= char <= 'z':
            position = lowercase.find(char)
            encrypted_string.append(lowercase[(position + shift) % 26])
        else:
            encrypted_string.append(char)
    print(''.join(encrypted_string))