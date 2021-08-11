# Spark with Python on ARCHER2

## Set up a conda environment

Initialise the conda installation when you log in:
```
eval "$(/work/xxx/xxx/shared/miniconda3/bin/conda shell.bash hook)"
```

Create and populate the environment:
```
conda create -p /work/xxx/xxx/username/envs/spark python=3.9
conda activate /work/xxx/xxx/username/envs/envs/spark
conda install -c conda-forge jupyterlab
```

## PySpark with Jupyterlab

Submit a job to start Jupyterlab on a backend node:
```
sbatch run_spark_interactive.slurm
```
The contents of this file:
```
#!/bin/bash

eval "$(/work/xxx/xxx/shared/miniconda3/bin/conda shell.bash hook)"
conda activate /work/xxx/xxx/shared/envs/envs/spark

export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='lab --ip 0.0.0.0'

export HOME=/work/xxx/xxx/username/

/work/xxx/xxx/username/spark-3.1.2-bin-hadoop3.2/bin/pyspark
```
This job runs a Jupyterlab instance on a backend node.

Make a note of the node that it runs on, and log in to ARCHER2 again:
```
ssh username@login.archer2.ac.uk -L8888:NODENAME:8888
```
Now open localhost:8888 in your local browser with the token from jupyterlab.
