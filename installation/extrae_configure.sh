#!/bin/bash

cd extrae

git clean -fdx

./bootstrap && ./configure 	--without-unwind \
                            --without-mpi \
                            --without-dyninst \
			    --with-papi=/usr \
                            --enable-pthread \
                            --with-java-jdk=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-java-aspectj=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-binary-type=64
                            CC=gcc CXX=g++
                            #--with-java-aspectj-weaver=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/lib \
