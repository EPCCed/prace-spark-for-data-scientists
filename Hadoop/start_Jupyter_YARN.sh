#!/bin/bash

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir
export SPARK_HOME=$HOME/spark-2.4.0-bin-hadoop2.7

PYSPARK_PYTHON=/lustre/sw/anaconda/anaconda3-5.1.0/bin/python3 PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=0.0.0.0 --allow-root" $SPARK_HOME/bin/pyspark  --master yarn --driver-memory 4g --executor-memory 6g --executor-cores 4
