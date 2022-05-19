FROM jupyter/pyspark-notebook

EXPOSE 8080 7077 6066


USER root
# install this somewhere, where jovyan has read access
RUN chown -R jovyan /usr/local/spark/*

USER jovyan

RUN (cd /usr/local/spark/jars && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.1/hadoop-aws-3.2.1.jar)
RUN (cd /usr/local/spark/jars && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.213/aws-java-sdk-bundle-1.12.213.jar )

# The aws sdk relies on guava, but the default guava lib in jars is too old for being compatible
RUN rm /usr/local/spark/jars/guava-14.0.1.jar
RUN (cd /usr/local/spark/jars && wget https://repo1.maven.org/maven2/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar )

# Add S3 configuration to spark
RUN rm /usr/local/spark/conf/spark-defaults.conf
COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf

# install scala kernel
RUN python -m pip install spylon_kernel --user
RUN python -m spylon_kernel install --user

RUN mkdir jupyter_folder

ENV PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --NotebookApp.token=''"
ENV PYSPARK_DRIVER_PYTHON=/opt/conda/bin/jupyter

#COPY requirements.txt /opt/spark/requirements.txt

