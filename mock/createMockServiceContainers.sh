#!/bin/bash
# ---------------------------------------------
# This script creates and starts the container.
# ---------------------------------------------

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

# Creating and running the docker container
echo
echo "Running the docker containers"
echo "--------------------------------------------------"

# The mockservice image is built on the carbon version of Node.js.
# By default the image expose port 8080, so the Node.js service should also run on this port.
# The mockservices image can be instantiated in several different ways, all leading to the same result, as you can see below.
# The docker run command both create a container instance and start it.
docker run --net="dock_nw" --ip="172.72.0.7" --name=$CONTAINER_NAME_1 --hostname="eserv1.oracle.com" -d -p 7777:8080 $IMAGE_NAME
docker run --net="dock_nw" --ip="172.72.0.8" --name=$CONTAINER_NAME_2 --hostname="eserv2.oracle.com" -d -p 7778:8080 -e MOCK_PORT=8080 $IMAGE_NAME
docker run --net="dock_nw" --ip="172.72.0.9" --name=$CONTAINER_NAME_3 --hostname="eserv3.oracle.com" -d -p 7779:8080 $IMAGE_NAME node /usr/src/app/mockServices.js 8080

# With the configuration above, you need to use port 8080 for all the mock service servers.
# Port forwarding still works for the localhost address. Why is this? Because port forwarding is only used for localhost, maybe?
# For some reason, the port alias does not work when the IP-address is set.
# This is not a huge problem since all containers now get their own IP-address, but it is still a bit strange.
# So, from the host you can use either 127.0.0.1:7777 or 172.72.0.7:8080. Both works.

# List the docker containers
echo
echo "These are all the docker containers"
echo "-------------------------------------------------"
cd ..
./listAllContainers.sh


