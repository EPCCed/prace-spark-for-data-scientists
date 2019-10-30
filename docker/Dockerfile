FROM openjdk:8-stretch

RUN apt-get update && apt-get install -y less vim git

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo "conda activate base" >> ~/.bashrc

ENV USER sparkuser
ENV HOME /home/${USER}
RUN adduser ${USER} --disabled-password --gecos ""
COPY pyspark_jupyter.sh ${HOME}
RUN chown ${USER}:${USER} ${HOME}/pyspark_jupyter.sh && chmod u+x ${HOME}/pyspark_jupyter.sh

USER ${USER}
WORKDIR ${HOME}

ARG SPARK_VERSION=spark-2.4.4
ARG SPARK_NAME=${SPARK_VERSION}-bin-hadoop2.7
ARG SPARK_DIST=${SPARK_NAME}.tgz
ENV SPARK_HOME ${HOME}/${SPARK_NAME}

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "\nexport SPARK_HOME=${SPARK_HOME}\nexport PATH=$PATH:${SPARK_HOME}/bin" >> ~/.bashrc
RUN /opt/conda/bin/conda init

RUN mkdir downloads && \
    wget --quiet https://www-eu.apache.org/dist/spark/${SPARK_VERSION}/${SPARK_DIST} && \
    mv ${SPARK_DIST} downloads/ && \
    tar xzf downloads/${SPARK_DIST}

RUN git clone https://github.com/EPCCed/prace-spark-for-data-scientists.git
