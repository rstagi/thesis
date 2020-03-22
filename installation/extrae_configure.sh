#!/bin/bash

cd extrae

MPI_ROOT=/usr/lib64/mpi/gcc/openmpi
./bootstrap && ./configure  --with-mpi=${MPI_ROOT} \
                            --enable-openmp \
                            --without-dyninst \
			                --with-papi=/usr \
                            --enable-pthread \
                            --with-java-jdk=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-java-aspectj=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-unwind=/usr \
                            --with-elf=/usr \
                            --with-binary-type=64
                            CC=gcc CXX=g++ MPICC=${MPI_ROOT}/bin/mpicc MPICXX=${MPI_ROOT}/bin/mpicxx
