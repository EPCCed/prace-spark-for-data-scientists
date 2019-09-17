#! /usr/bin/env python

# Reduce script for a simple Map/Reduce word count.
#
# Input data will contain a single key and value pair on each line. They
# will be separated by a tab. All instances of the same key will be
# grouped together so when the key changes we are guaranteed to have
# processed all the entries for that key.

import sys
import string

# Store a word and a count
current_word = None
current_count = 0

# Process the input lines one line at a time
for line in sys.stdin:
    line = line.strip()
    word, count = line.split('\t', 1)
    count = int(count)

    if current_word == word:
        current_count = current_count + 1
    else:
        if current_word:
            print '%s\t%s' % (current_word, current_count)
        current_word = word
        current_count = count

if current_word == word:
    print '%s\t%s' % (current_word, current_count)

