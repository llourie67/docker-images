# =======================================================================================================
# Dockerfile for building the simple mockServices image, running Node.js.
# What is a Dockerfile? Well, Docker can build images automatically by reading the instructions
# from a Dockerfile, a text file that contains all the commands, in order, needed to build a given image. 
# =======================================================================================================

# The first thing we need to do is define from what image we want to build from.
# The latest LTS (long term support) version of "node" is called "carbon".
FROM node:carbon

# The WORKDIR instruction creates and sets the working directory for any
# RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow in the Dockerfile.
WORKDIR /usr/src/app

# Deploy the json files that are used for downloading and installing Node.js.
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# The "npm install" will download and install all modules listed as dependencies in the package.json file.
RUN npm install

# All the local files and directories that are not already in the container (only new items) should now be copied into the container.
# It is at this point that your js file is copied into the container.
# The reason for not adding the js file earlier is to make a different between when the package.json file is changed and when the app code is changed.
# When the app code is changed there is no need to rebuild the Node.js framework. But when the package.json file is changed, the Node.js framework will be rebuilt.
# A good explanation is provided here: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js.
COPY . .

# At runtime, the container listens on port 8080.
# You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
EXPOSE 8080

# When the container starts, it should execute "npm" with argument "start", which means
# that the command specified in the package's "start" property of its "scripts" object
# will be executed.
# If no "start" property  is  specified  on the "scripts" object, it will run "node server.js". 
CMD [ "npm", "start" ]


