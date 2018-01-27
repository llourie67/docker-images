#!/bin/bash
# ------------------------------------------
# This script stops all the mock containers.
# ------------------------------------------

# Check that the file setEnv.sh is available
if [ ! -f setEnv.sh ]; then
    echo 
    echo "---------------------------------------"
    echo "The setEnv.sh file is not available."
    echo "Are you running in the right directory?"
    echo "---------------------------------------"
    echo 
fi

# Set the environments for the local docker image and container
. ./setEnv.sh

# Stopping the mock containers
./stopContainer.sh $CONTAINER_NAME_1
./stopContainer.sh $CONTAINER_NAME_2
./stopContainer.sh $CONTAINER_NAME_3

