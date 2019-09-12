#! /usr/bin/env python

# Map script for a simple Map/Reduce word count.
#
# Input data will be lines of text. The script will process each
# line at a time and for each word in the text output a line
# with the word and the number 1, separated by a tab.

import sys
import string

# input comes from STDIN (standard input)
for line in sys.stdin:
    line = line.strip()
    words = line.split()
    for word in words:
        # tab-delimited; the trivial word count is 1
        word = word.translate(None,string.punctuation)
        word = word.lower()
        if word != "":
            print '%s\t%s' % (word.lower(), 1)

