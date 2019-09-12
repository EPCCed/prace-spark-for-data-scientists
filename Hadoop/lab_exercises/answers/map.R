#!/usr/bin/Rscript

# Map script for a simple Map/Reduce word count.
#
# Input data will be lines of text. The script will process each
# line at a time and for each word in the text output a line
# with the word and the number 1, separated by a tab.

# Open stdin
fin <- file("stdin")
open(fin)

# Process the input lines one line at a time
while(length(line <- readLines(fin,n=1)) > 0) {

  # Splint the line into a vector of words
  words = strsplit(line, "[\t\n\r\f\v _/();:*\"'?.,!-]+")[[1]]

  # Process each word
  for( word in words) {
    cat(tolower(word), 1, sep="\t")
    cat("\n")
  }
}

# Close stdin
close(fin)
