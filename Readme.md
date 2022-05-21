# Docker Setup: JupyterLab + Spark + S3

This project serves as a local setup to develop python/scala applications
that require spark and a S3 object storage for persistence.
Further AWS dependencies can be mocked using the localstack functionality.


## USAGE
```{bash}
# Build spark/jupyterlab container with aws dependencies included
docker build -t jupyter-spark:1.00 -f config/spark.Dockerfile .

# Orchestrate container setup
docker compose up -d

# Get jupyterlab token from logs
docker logs aws_spark_setup-spark-master-1
 ```