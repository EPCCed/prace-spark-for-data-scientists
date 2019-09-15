#! /bin/bash

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir
export SPARK_HOME=$HOME/spark-2.4.0-bin-hadoop2.7

cd $SPARK_HOME
bin/spark-submit --class org.apache.spark.examples.SparkPi  --master yarn --deploy-mode cluster --driver-memory 4g --executor-memory 2g --executor-cores 1  examples/jars/spark-examples*.jar 10
