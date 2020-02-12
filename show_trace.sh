#!/bin/bash

if [ $# = 0 ]; then
        printf "Usage: $0 [-conf <config_file>] [-row <row_file>] <target> \n"
        exit 1
fi

conf="none"
row="none"
while test $# != 0; do
        arg=$1
        if [ "$arg" = "-conf" ]; then
		shift
                conf=$1
        elif [ "$arg" = "-row" ]; then
                shift
		row=$1
        else
                target=$arg
        fi
        shift
done



if [ -f "$target" -o -f "$(pwd)/$target" ]; then
        printf "\n------ Inspecting trace $target using Paraver ------\n\n\n"
else
	echo $target
        printf "Please, specifiy a valid target!\n"
        exit 1
fi

tmp_dir=$(mktemp -d -t javatrace-XXXXXX)
printf "Copying all files inside temp directory (${tmp_dir}) "

cp $target $tmp_dir >& /dev/null
if [ "$conf" != "none" ]; then
	cp $conf $tmp_dir >& /dev/null
fi
if [ "$row" != "none" ]; then
	cp $row $tmp_dire >& /dev/null
fi
printf "\t[...ok!]\n"

printf "Running docker container extrae/javatrace "
container_id=$(docker run -d -t \
                        --env="DISPLAY" \
                        --net=host \
                        --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
                        extrae/javatrace /bin/bash )

printf "\t[...ok!] Container ID: $container_id\n"

printf "Removing old files from the container "
docker exec -it $container_id rm -r /home/javatraces >& /dev/null
if [ $? = 0 ]; then
        printf "\t[...ok!]\n"
else
        printf "\t[Error!]\n"
        exit 1
fi

printf "Copying files into the container "
docker cp $tmp_dir/ $container_id:home/javatraces >& /dev/null
if [ $? = 0 ]; then
        printf "\t[...ok!]\n\n"
else
        printf "\t[Error!]\n"
fi

docker exec -it $container_id /usr/share/wxparaver/bin/wxparaver /home/javatraces/$target

printf "Stopping the container "
docker stop $container_id > /dev/null
if [ $? -eq 0 ]; then
        printf "\t[...ok!]\n"
fi

printf "Deleting the container "
docker rm $container_id > /dev/null
if [ $? -eq 0 ]; then
        printf "\t[...ok!]\n"
fi

printf "\nExiting the program.\n"
exit 0

