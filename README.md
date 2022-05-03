# jetpack_docker
this is the repo that contains docker container and dockerfile for jetpack

## Description 
This repo contains dockerfile to pull image from NGC (Nvidia GPU Cloud) _ https://catalog.ngc.nvidia.com/containers?filters=&orderBy=dateModifiedDESC&query=L4T

## Files
- Dockerfile : script to setup the environment for docker container (to change the image, please edit here)
- Build.sh : script to build the Dockerfile (specify the image name after build)
- run-orin.sh : script for running docker image that was built from Build.sh (specify the image name to run and container name)
