#!/bin/bash
# -------------------------------------------
# This script starts all the mock containers.
# -------------------------------------------

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

# Starting the mock containers
./startContainer.sh $CONTAINER_NAME_1
./startContainer.sh $CONTAINER_NAME_2
./startContainer.sh $CONTAINER_NAME_3

