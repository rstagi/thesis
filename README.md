# Tracing methodologies and tools for JAVA AI and Data Mining frameworks #

This project is my Master's Thesis, carried on in the Universidad Politecnica de Catalunya during an internship at the Barcelona Supercomputing Center.




### Project structure ###

In the root directory there are just this README, a Dockerfile and two scripts file to help in the usage of the package. The `installation` folder contains all the programs which need to be installed inside  the Docker image. Inside `installation` there's another folder, named `extrae`, which is the tracing program from the BSC. It actually is a *git submdoule*, which point to a personal fork of the original repository. In order to clone the whole project properly, run

	git clone https://github.com/rstagi/thesis.git --recursive



### Build ###

To properly use the software in here, there are two scripts provided. To build the image, just run
	
	./build_docker_javatrace.sh

This command will clean the installations and it will build the Docker image.

The Docker image is built on top of OpenSUSE, which is the most similar Operating System to the Marenostrum (the supercomputer at the BSC).

It will install all the necessary tools and programs, and finally it will copy the installation folder into the image, installing the remaining software (which are AspectJ and Extrae, built from the source).

The installation folder contains a subdirectory named `extrae`, which is clearly the folder containing all the sources to build the program. To synchronize with the official repository, that directory is in reality a submodule to a fork of the original repository. The custom code will be placed in a branch called `javatrace`.

By specificing the option `-pull` to the building script, it will checkout on the `javatrace` branch of the submodule. Or, alternatively, it can be specified the branch or the tag on which you want to checkout by adding it after the option: `-pull <target_branch_or_tag>`. In this way, all the different versions of Extrae can be tried with this environment.

### Usage ###

Using the program to trace JAVA software, is as simple as running the other script contained in the root folder: `run_javatrace.sh`. Just place it in the directory with the `.class` or `.jar` files of interest, and run one of the following:
 
	./run_javatrace.sh <java_class_target>
	./run_javatrace.sh -jar <jar_file> <java_class>

This will copy all the files of the current directory (add `-R` to do it recursively, but be careful with the location) into a temp directory, which will be copied inside the docker image, that will finally run the java program with Extrae tracing. In the end, the output of the execution, inside the docker image, will be copied back to the current folder (this time recursively).

To shoe the trace using Paraver, the script `show_trace.sh` is provided. An installation on local machine is recommended, though.

To show the trace using the trace using `show_trace.sh`, just run the following command:
	
	./show_trace.sh <prv_file>

To add `.pcf` and `.row` files, there are two options available: `-conf <pcf_file>` and `-row <row_file>`.

The trace can be shown in the same context of the execution, by adding `-show` to the call to `run_javatrace.sh`. An example:

	./run_javatrace.sh -show <java_target>


### Debug inside Docker ###

To debug inside the Docker image there are two different methods.
The script `debug_javatrace.sh` detects in automatic the docker image and the java program, and executes `gdb` on it.
The usage is very simple, it's enough to run it before running the script `run_javatrace.sh`. It will begin listening to detect at first the next container from the `extrae/javatrace` image, and then it will wai for the java program.
So, open a terminal and run:

    ./debug_javatrace.sh

And then, on another terminal:

    ./run_javatrace <options_and_target>

In this way, the user will be inside gdb to debug the JAVA program.
Of course, it'll be possible to debug at "C level", not at "JAVA level". I used this method to debug Extrae.


The second method to debug is using the terminal for a custom configuration. One can use the option `-stop` of `run_javatrace.sh`.

    ./run_javatrace -stop <target>

In this way, it will start the container and then it'll stop asking the user to press a key.
Before pressing a key, it's possible to run another terminal (using for example `docker exec -it <container_id> /bin/bash), by using the container ID provided by `run_javatrace.sh`, and run the method of choice.

I'm thinking on a solution to debug at JAVA level and maybe to connect it with some IDE. The priority in doing this, however, is lower than other things for sure more important.


### Examples ###

There is a folder named `examples` which contains some examples of usage. After having built the image using `build_docker_javatrace.sh`, you can decide to run either the "jarmode" or the "standard" example.

For the latter, you can browse into the `examples/standard` folder and run:

	make run

This command will build and run the program in the standard mode (using `.class` files) inside the docker image.
To show the traces in Paraver, run also:

	make show

To run and show with a single command, there's also the following option:

	make runshow


To run the example in jar mode, and so using a `.jar` file, browse into `example/jarmode` and run again one of the following:

* `make run` followed by `make show`
* `make runshow`

### Documentation ###

In the folder named `docs` there are all the PDFs files corresponding to Reports and Thesis drafts.

