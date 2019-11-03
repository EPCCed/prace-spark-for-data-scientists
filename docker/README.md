# Dockerfile for Spark course

Build:
```
docker build --pull --no-cache -t prace_spark_course .
```

When the image has been built succesfully, run an interactive container:
```
./start_docker.sh
```
This starts a bash commandline session from a Linux or MacOS terminal.
Or, if you are using a Windows PowerShell, use the following command to start an interactive session on the docker container:
```
docker run -it -p 8000:8000 prace_spark_course /bin/bash
```

From within the container, start PySpark with a Jupyter notebook:
```
./pyspark_jupyter.sh
```

This will print a lot of information and finish with these lines:
```
To access the notebook, open this file in a browser:
    file:///home/sparkuser/.local/share/jupyter/runtime/nbserver-18-open.html
Or copy and paste one of these URLs:
    http://(3c00e31c38c9 or 127.0.0.1):8000/?token=66050ed7bdd317f6fef3631ecb72c4e1b2f805a7198c2ff9
```

Copy the token from your commandline and open the URL in a browser:
http://localhost:8000/?token=[PASTE_YOUR_TOKEN_HERE]
