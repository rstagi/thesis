#!/bin/bash

container_id=$(docker run -d -t extrae/javatrace bash)

#temp dir where putting all files except this script
tmp_dir=$(mktemp -d -t javatrace-XXXXXX)
cp -r ./* $tmp_dir
rm $tmp_dir/*.sh #TODO da rimuovere
echo "Copied in $tmp_dir"

echo "Running container $container_id"
docker exec -it $container_id rm -r home/javatraces
docker cp $tmp_dir/ $container_id:home/javatraces
docker exec -it -w /home/javatraces -e EXTRAE_CONFIG_FILE=extrae.xml $container_id extraej -- $1 
docker cp $container_id:home/javatraces/ $tmp_dir/
cp -r $tmp_dir/javatraces/* ./
tree $tmp_dir #TODO da rimuovere
rm -r $tmp_dir

docker stop $container_id
