#!/bin/bash

# configure_hadoop is a script that configures hadoop on Cirrus
#
# Copyright (C) 2018-2019 EPCC, Edinburgh University
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see http://www.gnu.org/licenses/.

export HADOOP_DIR=$HOME/hadoop
export HADOOP_HOME=$HADOOP_DIR/hadoop-3.2.0
export HADOOP_CONF_DIR=$HADOOP_DIR/conf_dir
export HADOOP_DATA_DIR=$HADOOP_DIR/data

export PATH=$PATH:$HADOOP_HOME/bin
export JAVA_HOME=/lustre/sw/spack/opt/spack/linux-centos7-x86_64/gcc-6.2.0/jdk-8u92-linux-x64-24xtmiygsdlaayomilfa5mnrasmxqlhj
export MPI_SHEPHERD=true
export NUM_NODES=`cat $PBS_NODEFILE  | wc | awk '{print $1}'`
export MASTER_HDFS=`head -n1 $PBS_NODEFILE  | cut -d'.' -f1`
export MEMORY=256
export MAX_ALLOC_MEMORY=`expr $MEMORY / $NCPUS`

module purge
module load spack/cirrus
module load jdk-8u92-linux-x64-gcc-6.2.0-24xtmiy
module load anaconda/python3

cd $HOME
mkdir -p $HADOOP_CONF_DIR
cd $HADOOP_CONF_DIR
pwd
hostname
cp $HADOOP_HOME/etc/hadoop/* $HADOOP_CONF_DIR

# Setup core-site.xml
sed -i '/^<configuration>/,/^<\/configuration>/{//!d;};' core-site.xml
sed -i '$ d' core-site.xml
echo "  <property>" >> core-site.xml
echo "    <name>fs.defaultFS</name>" >> core-site.xml
echo "      <value>hdfs://$MASTER_HDFS:9000</value>" >> core-site.xml
echo "  </property>" >> core-site.xml
echo "  <property>" >> core-site.xml
echo "    <name>hadoop.tmp.dir</name>" >> core-site.xml
echo "      <value>$HADOOP_DIR/tmp</value>" >> core-site.xml
echo "  </property>" >> core-site.xml
echo "</configuration>" >> core-site.xml

# Setup hdfs-site.xml
sed -i '/^<configuration>/,/^<\/configuration>/{//!d;};' hdfs-site.xml
sed -i '$ d' hdfs-site.xml
echo "  <property>" >> hdfs-site.xml
echo "    <name>dfs.namenode.name.dir</name>" >> hdfs-site.xml
echo "    <value>$HADOOP_DATA_DIR/nameNode</value>" >> hdfs-site.xml
echo "  </property>" >> hdfs-site.xml
echo "" >> hdfs-site.xml
echo "  <property>" >> hdfs-site.xml
echo "    <name>dfs.datanode.data.dir</name>" >> hdfs-site.xml
echo "    <value>$HADOOP_DATA_DIR/dataNode</value>" >> hdfs-site.xml
echo "  </property>" >> hdfs-site.xml
echo "" >> hdfs-site.xml
echo "  <property>" >> hdfs-site.xml
echo "    <name>dfs.replication</name>" >> hdfs-site.xml
echo "    <value>1</value>" >> hdfs-site.xml
echo "  </property>" >> hdfs-site.xml
echo "</configuration>" >> hdfs-site.xml

# Setup mapred-site.xml
sed -i '/^<configuration>/,/^<\/configuration>/{//!d;};' mapred-site.xml
sed -i '$ d' mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>mapreduce.framework.name</name>" >> mapred-site.xml
echo "    <value>yarn</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>yarn.app.mapreduce.am.env</name>" >> mapred-site.xml
echo "    <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>mapreduce.map.env</name>" >> mapred-site.xml
echo "    <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>mapreduce.reduce.env</name>" >> mapred-site.xml
echo "    <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>mapreduce.application.classpath</name>" >> mapred-site.xml
echo '    <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>' >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>yarn.app.mapreduce.am.staging-dir</name>" >> mapred-site.xml
echo "    <value>$HADOOP_DIR/tmp/hadoop-yarn</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "  <property>" >> mapred-site.xml
echo "    <name>mapreduce.task.tmp.dir</name>" >> mapred-site.xml
echo "    <value>$HADOOP_DIR/tmp</value>" >> mapred-site.xml
echo "  </property>" >> mapred-site.xml
echo "</configuration>" >> mapred-site.xml

# Setup yarn-site.xml
sed -i '/^<configuration>/,/^<\/configuration>/{//!d;};' yarn-site.xml
sed -i '$ d' yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.resourcemanager.hostname</name>" >> yarn-site.xml
echo "    <value>$MASTER_HDFS</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.nodemanager.aux-services</name>" >> yarn-site.xml
echo "    <value>mapreduce_shuffle</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.nodemanager.env-whitelist</name>" >> yarn-site.xml
echo "    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.node-attribute.fs-store.root-dir</name>" >> yarn-site.xml
echo "    <value>$HADOOP_DIR/tmp/hadoop-yarn/node-attribute/</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.log-aggregation-enable</name>" >> yarn-site.xml
echo "    <value>true</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.nodemanager.remote-app-log-dir</name>" >> yarn-site.xml
echo "    <value>$HADOOP_DIR/tmp/logs</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "  <property>" >> yarn-site.xml
echo "    <name>yarn.log.server.url</name>" >> yarn-site.xml
echo "    <value>http://$MASTER_HDFS:19888/jobhistory/logs</value>" >> yarn-site.xml
echo "  </property>" >> yarn-site.xml
echo "</configuration>" >> yarn-site.xml

# Setup workers
cat $PBS_NODEFILE | cut -d'.' -f1 > workers

# configure JAVA_HOME
echo "export JAVA_HOME=$JAVA_HOME" >> hadoop-env.sh

# Only once
echo `date` ": Creating the cluster. We are formatting the HDFS."
echo 'Y' | $HADOOP_HOME/bin/hdfs namenode -format
