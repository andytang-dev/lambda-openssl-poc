#!/bin/bash

# Set variables
IMAGE_NAME="openssl-layer-builder"
OUTPUT_ZIP="layer.zip"

# Build the Docker image
docker build -t $IMAGE_NAME .

# Create a container and capture its name (container ID)
CONTAINER_NAME=$(docker create $IMAGE_NAME)

# Copy the layer.zip file from the container to the current directory
docker cp $CONTAINER_NAME:/tmp/layer/$OUTPUT_ZIP ./

# Clean up the container
docker rm $CONTAINER_NAME

echo "The $OUTPUT_ZIP file has been exported to the current directory."