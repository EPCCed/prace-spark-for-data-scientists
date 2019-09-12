# Set up Hadoop on Cirrus

This document shows how to configure Hadoop on Cirrus.

## Download Hadoop

On the login node, download and unpack Hadoop.

```
mkdir hadoop
cd hadoop
wget https://archive.apache.org/dist/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz
tar xzf hadoop-3.2.0.tar.gz
```

Copy the configuration and start and stop scripts to your home directory.

```
cp configure_hadoop.sh start_hadoop.sh stop_hadoop ~/hadoop/
```

## Configure Hadoop

From the `hadoop` directory run the configuration script:

```
./configure_hadoop.sh
```

This creates and formats the HDFS file system. This only needs to be run once; if you run this script again it will delete any existing data.

## Start an interactive session

Start an interactive session in a node. 
This command requests one node from the y15 reservation for an hour.

Modify the command below with your reservation number (RXXXXXX) and requested walltime.
```
qsub -IVl select=1:ncpus=36,walltime=01:00:00,place=scatter:excl -A y15 -q RXXXXXX -j oe
```
This will give you an interactive session into a node (e.g. node r1i1n20) and you will see something like this:

```
[USERNAME@cirrus-login0 ~]$ qsub -IVl select=1:ncpus=36,walltime=01:00:00,place=scatter:excl -A y15 -q R1112933 -j oe
qsub: waiting for job 399686.indy2-login0 to start
qsub: job 399686.indy2-login0 ready
[USERNAME@r1i1n20 ~]$
```
You will need the name of the node assigned in the steps below.

## Start Hadoop HDFS and YARN

Then start HDFS, YARN and the job history server:

```
./start_hadoop.sh

Autoloading gcc/6.2.0
/lustre/home/y15/.../hadoop/conf_dir
r1i3n7
```
The last line of the output shows the name of the Hadoop master node, in this example: `r1i3n7`.

## Web interfaces

In another terminal window, log in to Cirrus again with port forwarding to see the web interfaces:

```
ssh <USER_ID>@login.cirrus.ac.uk -L9870:<MASTER_NODE>:9870 -L8088:<MASTER_NODE>:8088 -L19888:<MASTER_NODE>:19888
```

where you replace <USER_ID> by your Cirrus login username and <MASTER_NODE> by the master node of your running job, for example `r1i3n7`. (The node name is the last line of output from the configure script as shown above.)

Then open the following links to see the Hadoop web interfaces:

The HDFS web interface: http://localhost:9870/
This should show 1 running data node.

The YARN web interface: http://localhost:8088/

The YARN job history server: http://localhost:19888/ Your jobs will appear here.

## Map Reduce

Submit a Map Reduce job to the server:

```
./test-map-reduce.sh
```
This script creates a directory in HDFS, copies some files and runs a grep on these. 

## Shut down Hadoop

To shut down the history server, YARN and HDFS:

```
./stop-hadoop.sh
```

## Trouble shooting

Restarting Hadoop on a different backend node:

```
org.apache.hadoop.hdfs.server.common.Storage: Failed to add storage directory [DISK]file:/lustre/home/y15/<USER_ID>/hadoop/data/dataNode
java.io.IOException: Incompatible clusterIDs in /lustre/home/y15/<USER_ID>/hadoop/data/dataNode: namenode clusterID = CID-c2639c96-6af0-4123-873e-f2e9802e11fc; datanode clusterID = CID-938cb202-5c55-4951-bf00-0a15af2e1d1d
```

Shut down everything, remove the data directory and reconfigure Hadoop.
