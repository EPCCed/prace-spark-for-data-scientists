#! /bin/bash

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir

cd $HADOOP_HOME

set -x

$HADOOP_HOME/bin/hdfs dfs -mkdir /user
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/$USER
$HADOOP_HOME/bin/hdfs dfs -mkdir input
$HADOOP_HOME/bin/hdfs dfs -put etc/hadoop/*.xml input
$HADOOP_HOME/bin/hdfs dfs -rm -r -f output

$HADOOP_HOME/bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar  grep input output 'dfs[a-z.]+'
$HADOOP_HOME/bin/hdfs dfs -cat output/*
