#!/bin/bash

if [ "$1" = "-pull" ]; then
	shift
	branch=$1
	printf "\n--- UPDATING Extrae SUBMODULE ---\n\n"
	git submodule update --recursive --remote
	cd installation/extrae; git clean -xdf; git checkout $branch; git pull; cd ../..;
fi

printf "\n\n\n--- BUILDING Docker Image with Extrae ---\n"
printf "If it's the first time, it will take few minutes\n\n"
docker build -t extrae/javatrace .

