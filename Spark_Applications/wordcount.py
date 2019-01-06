import sys
from pyspark import SparkContext, SparkConf

if __name__ == "__main__":
    conf = SparkConf().setAppName("Spark Count")
    sc = SparkContext(conf=conf)
    logFile = "../spark-2.4.0-bin-hadoop2.7/README.md"
    textFile = sc.textFile(logFile)
    wordCounts = textFile.flatMap(lambda line: line.split()).map(lambda word: (word, 1)).reduceByKey(lambda a, b: a+b)
    value=wordCounts.collect()
    print ("------> Results!!!! %s" % value)
