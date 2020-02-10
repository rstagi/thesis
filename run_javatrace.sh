#!/bin/bash

container_id=$( docker run extrae/javatrace )
docker cp $(pwd)/* - $container_id:javafiles/

docker exec -it $container_id cd javafiles
docker exec -it $container_id EXTRAE_CONFIG_FILE=extrae.xml extraej -jar $1
docker cp $container_id:javafiles/* - $(pwd)/output
