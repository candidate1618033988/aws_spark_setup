#!/usr/bin/env sh

# create s3 bucket
aws --endpoint-url=http://localhost:4566 s3  mb s3://techlab

# Copy data into s3
aws --endpoint-url=http://localhost:4566 s3 cp /opt/mount/test.txt s3://techlab
