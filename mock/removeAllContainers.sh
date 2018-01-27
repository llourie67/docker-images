#!/bin/bash
# -------------------------------------------
# This script removes all the mock containers
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

# Removing the containers
./removeContainer.sh $CONTAINER_NAME_1
./removeContainer.sh $CONTAINER_NAME_2
./removeContainer.sh $CONTAINER_NAME_3
