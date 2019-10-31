#!/bin/bash
set -x 
$HOME/spark-2.4.0-bin-hadoop2.7/bin/spark-submit --verbose --master spark://$1:7077 wordcount.py "$HOME/spark-2.4.0-bin-hadoop2.7/README.md" 
