# Tracing methodologies and tools for JAVA AI and Data Mining frameworks #

This project is my Master's Thesis, carried on in the Universidad Politecnica de Catalunya during an internship at the Barcelona Supercomputing Center.




### Project structure ###

In the root directory there are just this README, a Dockerfile and two scripts file to help in the usage of the package. The `installation` folder contains all the programs which need to be installed inside  the Docker image. Inside `installation` there's another folder, named `extrae`, which is the tracing program from the BSC. It actually is a *git submdoule*, which point to a personal fork of the original repository. In order to clone the whole project properly, run

	git clone git@github.com:rstagi/thesis.git --recursive



### Build ###

To properly use the software in here, there are two scripts provided. To build the image, just run
	
	./build_docker_javatrace.sh

This command will clean the installations and it will build the Docker image.

The Docker image is built on top of OpenSUSE, which is the most similar Operating System to the Marenostrum (the supercomputer at the BSC).

It will install all the necessary tools and programs, and finally it will copy the installation folder into the image, installing the remaining software (which are AspectJ and Extrae, built from the source).

The installation folder contains a subdirectory named `extrae`, which is clearly the folder containing all the sources to build the program. To synchronize with the official repository, that directory is in reality a submodule to a fork of the original repository. The custom code will be placed in a branch called `javatrace`.


### Usage ###

Using the program to trace JAVA software, is as simple as running the other script contained in the root folder: `run_javatrace.sh`. Just place it in the directory with the `.class` or `.jar` files of interest, and run one of the following:
 
	./run_javatrace.sh <class_to_be_traced>
	./run_javatrace.sh -jar <jar_file_to_be_traced>

This will copy all the files of the current directory (add `-R` to do it recursively, but be careful with the location) into a temp directory, which will be copied inside the docker image, that will finally run the java program with Extrae tracing. In the end, the output of the execution, inside the docker image, will be copied back to the current folder (this time recursively).


### Examples ###

There is a folder named `examples` which contains some examples of usage. After having built the image using `build_docker_javatrace.sh`, browse into the `example/standard` folder and run:

	make run

This command will build and run the program in the standard mode (using `.class` files) inside the docker image.

To run the example in jar mode, and so using a `.jar` file, browse into `example/jarmode` and run again:

	make run


