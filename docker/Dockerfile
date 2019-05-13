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
ENV SPARK_HOME ${HOME}/spark-2.4.3-bin-hadoop2.7

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "\nexport SPARK_HOME=${SPARK_HOME}\nexport PATH=$PATH:${SPARK_HOME}/bin" >> ~/.bashrc
RUN /opt/conda/bin/conda init

RUN mkdir downloads && \
    wget --quiet https://www-eu.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz && \
    mv spark-2.4.3-bin-hadoop2.7.tgz downloads/ && \
    tar xzf downloads/spark-2.4.3-bin-hadoop2.7.tgz

RUN git clone https://github.com/EPCCed/prace-spark-for-data-scientists.git
