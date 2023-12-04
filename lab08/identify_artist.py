#!/usr/bin/env python3

import sys
import re
import os
import math

def total_words(filename):
    words = []
    with open(filename, "r") as f:
        lines = f.readlines()
        for line in lines:
            seps = re.split("[^a-zA-Z]", line)
            for sep in seps:
                if not sep:
                    continue
                words.append(sep.lower())
    return words

def log_probability(words, artist_file):
    total_word_count = 0
    word_counts = {}

    with open(artist_file, 'r') as f:
        artist_words = re.findall(r'[a-zA-Z]+', f.read().lower())
        total_word_count += len(artist_words)
        for word in artist_words:
            if word not in word_counts:
                word_counts[word] = 0
            word_counts[word] += 1

    log_prob = 0
    for word in words:
        word_count = word_counts.get(word, 0) + 1
        log_prob += math.log(word_count / total_word_count)

    return log_prob

if __name__ == "__main__":
    artists = os.listdir('lyrics')

    for song in sys.argv[1:]:
        words = total_words(song)
        max_log_prob = float('-inf')
        best_artist = ""

        for artist in artists:
            if not os.path.isfile(os.path.join('lyrics', artist)):
                continue
            current_log_prob = log_probability(words, os.path.join('lyrics', artist))
            if current_log_prob > max_log_prob:
                max_log_prob = current_log_prob
                best_artist = artist

            best_artist = best_artist.replace(".txt", "").replace("_", " ")
        print(f'{song} most resembles the work of {best_artist} (log-probability={max_log_prob:.1f})')
