# Running PySpark notebooks on your laptop

If you'd like to run Spark on your own laptop there are three options:

1. [Download and install Spark natively](#install-spark-natively)
1. [Use a VM (Oracle VirtualBox)](#oracle-virtualbox-vm)
1. [Use a Docker container](#docker-image)

On Linux-based systems (including MacOS) installation is straightforward.
On Windows, especially if you do not have Java and Python, it is easier to use the provided VM or Docker image.

## Install Spark natively

### Prerequisites

* Java 8+
* Python 3
* Recommended: Anaconda

### Installation

1. Get the latest release from the [Apache Spark downloads page](https://spark.apache.org/downloads.html) and unpack it.
1. That's it - check that it works:
      ```
      cd spark-2.4.4-bin-hadoop2.7/
      bin/pyspark
      ```

      You should see output like this:

      ```
      $ bin/pyspark 
      Python 3.7.4 (default, Aug 13 2019, 15:17:50) 
      [Clang 4.0.1 (tags/RELEASE_401/final)] :: Anaconda, Inc. on darwin
      Type "help", "copyright", "credits" or "license" for more information.
      19/11/01 09:11:45 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
      Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
      Setting default log level to "WARN".
      To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
      Welcome to
            ____              __
           / __/__  ___ _____/ /__
          _\ \/ _ \/ _ `/ __/  '_/
         /__ / .__/\_,_/_/ /_/\_\   version 2.4.4
            /_/

      Using Python version 3.7.4 (default, Aug 13 2019 15:17:50)
      SparkSession available as 'spark'.
      >>> 
      ```

### Examples and lab exercises

1. Clone the git repository on your laptop:
      ```
      git clone https://github.com/EPCCed/prace-spark-for-data-scientists.git
      ```
1. We're setting up an environment variable for the Spark installation directory
(replace **[INSTALLATION_PATH]** below with the path of your installation):
      ```
      export SPARK_HOME=[INSTALLATION_PATH]/spark-2.4.4-bin-hadoop2.7/
      ```
      You can also add PySpark (and other Spark binaries) to your path if you prefer:
      ```
      export PATH=$PATH:$SPARK_HOME/bin
      ```
1. Configure the environment for PySpark to use Jupyter notebooks:
      ```
      export PYSPARK_DRIVER_PYTHON=jupyter
      export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
      ```
1. Start PySpark with a Jupyter notebook server:
      ```
      cd prace-spark-for-data-scientists
      $SPARK_HOME/bin/pyspark
      ```

## Oracle VirtualBox VM

### Prerequisites

* Oracle VirtualBox (https://www.virtualbox.org)

### Installation

1. Download the VirtualBox VM image from [here](https://drive.google.com/open?id=1OHlNE8GAF8io2BMfRjAWQlZBogRil7JQ).
1. Start VirtualBox and click File -> Import Appliance ... to import the image
1. Start the VM
1. Password for the SparkUser is "sparkuser"

### Examples and lab exercises

A copy of the git repository is available in the VM.

Start a PySpark session:

```
cd prace-spark-for-data-scientists
PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark
```

This opens a PySpark Jupyter session in a Firefox browser.

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
      docker build -t prace_spark_course .
      ./start_docker.sh
      ```

### Examples and lab exercises

A copy of the git repository is available in the Docker container.

The command above starts a bash terminal session in the Docker container. You can now start Jupyter:

```
cd prace-spark-for-data-scientists/docker
./pyspark_jupyter.sh
```

and access it from a browser (on the host machine i.e. your laptop) here: http://localhost:8000/
