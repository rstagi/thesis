#!/bin/bash

printf "\n--- UPDATING Extrae SUBMODULE ---\n\n"
git submodule update --recursive --remote
cd installation/extrae; git clean -xdf; git checkout javatrace; git pull; cd ../..;

printf "\n\n\n--- BUILDING Docker Image with Extrae ---\n"
printf "If it's the first time, it will take few minutes\n\n"
docker build -t extrae/javatrace .

