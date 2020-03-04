#!/bin/bash

if [ $# = 0 ]; then
	printf "Usage: $0 [-jar <JarFile>] [-r, -R] [-show] <target> \n"
	exit 1
fi

recursive="no"
jartarget=""
show="no"
target=""
options=""
executable_name=`basename $0`
while test $# != 0; do
	arg=$1
	if [ "$arg" = "-R" -o "$arg" = "-r" ]; then
		recursive="yes"
	elif [ "$arg" = "-jar" ]; then
        shift
		jartarget=$1
	elif [ "$arg" = "-show" ]; then
		show="yes"
	else
		target=$arg
	fi
	shift
done

if [[ "$target" = "" ]]; then
	printf "Please, specifiy a valid target\n"
	exit 1
else
    target_dir=$(pwd)
	printf "\n------ Executing javatrace program on target $target ------\n\n\n"
fi


tmp_dir=$(mktemp -d -t javatrace-XXXXXX)
printf "Copying all files inside temp directory (${tmp_dir}) "
if [ "$recursive" = "yes" ]; then
	options=-r
	printf "in recursive mode "
fi

cp $options $target_dir/* $tmp_dir >& /dev/null
rm $tmp_dir/$executable_name
printf "\t[...ok!]\n"

printf "Running docker container extrae/javatrace "
container_id=$(docker run -d -t \
			--env="DISPLAY" \
			--net=host \
			--volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
			extrae/javatrace )

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

printf "Executing the program "
if [ "$jartarget" != "" ]; then
	options="-jar $jartarget"
	printf "in jar mode "
fi
printf "inside the docker image.\n\n"

docker exec -it -w /home/javatraces -e CLASSPATH=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/lib/ -e EXTRAE_CONFIG_FILE=extrae.xml $container_id extraej -v -keep ${options} -- ${target}

printf "Copying files back to the temp directory "
docker cp $container_id:home/javatraces/ $tmp_dir/ > /dev/null
if [ $? -eq 0 ]; then
	printf "\t[...ok!]\n"
else
	printf "\t[Error!]\n"
fi
cp -r $tmp_dir/javatraces/* $target_dir/
rm -r $tmp_dir

if [[ "$show" = "yes" ]]; then
	printf "Running Paraver to visualize the trace..."
	paraver_file=$( docker exec -it $container_id ls /home/javatracees | grep .prv )
	docker exec -it $container_id /usr/share/wxparaver/bin/wxparaver /home/javatraces/$(ls | grep .prv)
fi

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
