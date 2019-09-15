#!/bin/bash

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir

export JAVA_HOME=/lustre/sw/spack/opt/spack/linux-centos7-x86_64/gcc-6.2.0/jdk-8u92-linux-x64-24xtmiygsdlaayomilfa5mnrasmxqlhj
export NUM_NODES=`cat $PBS_NODEFILE  | wc | awk '{print $1}'`

export PATH=$PATH:$HADOOP_HOME/bin

module load spack/cirrus
module load jdk-8u92-linux-x64-gcc-6.2.0-24xtmiy
module load anaconda/python3

echo `date` ": Starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
echo `date` ": Started HDFS"

# Check that HDFS is running
echo `date` ": Checking the HDFS:"
IS_HDFS_RUNNING=`$HADOOP_HOME/bin/hdfs dfsadmin -report -dead | grep "Dead datanodes (0)" | wc | awk '{print $1}'`
if [[ $IS_HDFS_RUNNING = "1" ]]
then
  echo `date` ": No dead HDFS nodes."
else
  echo `date` ": We have dead HDFS nodes. Shutting down."
  $HADOOP_HOME/sbin/stop-dfs.sh
  exit -5
fi

NO_OF_HDFS_NODES_RUNNING=`$HADOOP_HOME/bin/hdfs dfsadmin -report -live | grep "Name: " | wc | awk '{print $1}'`
if [[ $NO_OF_HDFS_NODES_RUNNING = $NUM_NODES ]]
then
  echo `date` ": We have $NO_OF_HDFS_NODES_RUNNING HDFS nodes running."
else
  echo `date` ": We have $NO_OF_HDFS_NODES_RUNNING HDFS nodes running. We want $NUM_NODES HDFS nodes running. Shutting down."
  $HADOOP_HOME/sbin/stop-dfs.sh
  exit -6
fi

# Only once
echo `date` ": Starting Yarn"
$HADOOP_HOME/sbin/start-yarn.sh
echo `date` ": Started Yarn."

# Check that Yarn is running
echo `date` ": Checking Yarn:"
NO_OF_YARN_NODES_RUNNING=`$HADOOP_HOME/bin/yarn node -list | grep "Total Nodes" | cut -d':' -f2-`
if [[ $NO_OF_YARN_NODES_RUNNING = $NUM_NODES ]]
then
  echo `date` ": We have $NO_OF_YARN_NODES_RUNNING Yarn nodes running."
else
  echo `date` ": We have $NO_OF_YARN_NODES_RUNNING Yarn nodes running. We want $NUM_NODES Yarn nodes running. ABORTING!!!!"
  $HADOOP_HOME/sbin/stop-yarn.sh
  exit -7
fi

# Only once
echo `date` ": Starting the Yarn proxyserver"
$HADOOP_HOME/bin/yarn --daemon start proxyserver
echo `date` ": Started the Yarn proxyserver"

echo `date` ": Starting the Yarn historyserver"
$HADOOP_HOME/bin/mapred --daemon start historyserver
echo `date` ": Started the Yarn historyserver"

exit 0
