# Running PySpark notebooks on your laptop

If you'd like to run Spark on your own laptop there are three options:

1. Download and install Spark natively
1. Use a VM (Oracle VirtualBox)
1. Use a Docker container

On Linux-based systems (including MacOS) installation is straightforward.
On Windows, especially if you do not have Java and Python, it is easier to use the provided VM or Docker image.

## Oracle VirtualBox VM

### Prerequisites

* Oracle VirtualBox (https://www.virtualbox.org)

### Installation

1. Download our VirtualBox VM image
1. Start VirtualBox and click File -> Import Appliance ... to import the image
1. Start the VM
1. Password for the SparkUser is "sparkuser"

## Docker image

### Prerequisites

* Docker

### Installation

1. Clone the git repository on your laptop:
```
git clone https://github.com/EPCCed/prace-spark-for-data-scientists.git
```
1. Change into the docker directory within the cloned repository and follow the [instructions](docker/) to build and run the Dockerfile.
```
cd prace-spark-for-data-scientists/docker
docker build -t prace_spark_course
./start_docker.sh
```

## Install Spark on your system

### Prerequisites

* Java 8+
* Python 3
* Recommended: Anaconda

### Installation

1. Get the latest release from the [Apache Spark downloads page](https://spark.apache.org/downloads.html) and unpack it.
1. That's it - check that it works:
```
cd spark-2.4.0-bin-hadoop2.7/
bin/pyspark
```

You should see output like this:

```
Python 3.6.3 |Anaconda custom (64-bit)| (default, Oct  6 2017, 12:04:38) 
[GCC 4.2.1 Compatible Clang 4.0.1 (tags/RELEASE_401/final)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
2019-01-09 10:56:19 WARN  NativeCodeLoader:62 - Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
2019-01-09 10:56:21 WARN  Utils:66 - Service 'SparkUI' could not bind on port 4040. Attempting port 4041.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.4.0
      /_/

Using Python version 3.6.3 (default, Oct  6 2017 12:04:38)
SparkSession available as 'spark'.
>>> 
```

### Examples and lab exercises

1. Clone the git repository on your laptop:
```
git clone https://github.com/EPCCed/prace-spark-for-data-scientists.git
```
2. We're setting up an environment variable for the Spark installation directory
(replace **[INSTALLATION_PATH]** below with the path of your installation):
<pre>
export SPARK_HOME=<b>[INSTALLATION_PATH]</b>/spark-2.4.0-bin-hadoop2.7/
</pre>
3. Configure the environment for PySpark to use Jupyter notebooks:
```
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
```
4. Start PySpark with a Jupyter notebook server:
```
cd prace-spark-for-data-scientists
$SPARK_HOME/bin/pyspark
```
