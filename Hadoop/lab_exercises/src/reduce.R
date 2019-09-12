#!/usr/bin/Rscript

options(warn=1)


# Reduce script for a simple Map/Reduce word count.
#
# Input data will contain a single key and value pair on each line. They
# will be separated by a tab. All instances of the same key will be
# grouped together so when the key changes we are guaranteed to have
# processed all the entries for that key.


# Function to output key and value data separated by a comma.
#   key - the key
#   value - the value
#
outputData <- function(key,value) {
  if (key != "") {
    cat(key, count, sep="\t")
    cat("\n")
  }
}

# Open stdin
fin <- file("stdin")
open(fin)

# Store a key and a count
key   <- ""
count <- 0

# Process the input lines one line at a time
while(length(line <- readLines(fin,n=1)) > 0) {

  keyAndCount = strsplit(line, "\t")[[1]]
  newKey   <- keyAndCount[1]
  newCount <- as.numeric(keyAndCount[2])

  if (newKey == key) {
     # The key is the same so increase the count
     count <- count + 1
  }
  else {
     # The key has changed so output old data and store new data
     outputData(key, count)
     key   <- newKey
     count <- 1
  }
}

# Output the final data
outputData(key, count)

# Close stdin
close(fin)
