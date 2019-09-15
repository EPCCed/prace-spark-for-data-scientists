#! /bin/bash

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir

$HADOOP_HOME/bin/yarn --daemon stop proxyserver
$HADOOP_HOME/bin/mapred --daemon stop historyserver

echo `date` ": Stopping Yarn"
$HADOOP_HOME/sbin/stop-yarn.sh
echo `date` ": Stopped Yarn"

echo `date` ": Stopping HDFS"
$HADOOP_HOME/sbin/stop-dfs.sh
echo `date` ": Stopped HDFS"

echo `date` ": DONE."
