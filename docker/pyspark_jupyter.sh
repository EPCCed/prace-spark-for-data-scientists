#! /bin/bash

PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook  --ip=0.0.0.0 --port=8000" pyspark
