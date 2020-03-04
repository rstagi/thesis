#!/bin/bash

echo "--- Starting listening for debugging Docker image extrae/javatrace ---"

init_images=$(docker ps | grep extrae/javatrace)
curr_images=$init_images

echo "Waiting for docker to start..."

while [ "$curr_images" = "$init_images" ]; 
do 
    curr_images=$(docker ps | grep extrae/javatrace)
done

container_id=$(echo "$curr_images" | rev | cut --delim=' ' -f 1 | rev )

echo "Docker image detected. Name: $container_id"

echo "Waiting for java program..."

java_pid=""
while [ "$java_pid" = "" ];
do
    java_pid=$(docker exec -it $container_id pidof java)
done

echo "Java program detected (PID=$java_pid). Running gdb..."

docker exec -it $container_id gdb --pid=$java_pid

