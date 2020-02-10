#!/bin/bash

cd extrae

./bootstrap && ./configure 	--without-unwind \
                            --without-mpi \
                            --without-dyninst \
			    --with-papi=/share \
                            --enable-pthread \
                            --with-java-jdk=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-java-aspectj=/usr/lib/jvm/jdk1.8.0_231 \
                            --with-java-aspectj-weaver=/usr/lib/jvm/jdk1.8.0_231/lib \
                            --with-binary-type=64
                            CC=gcc CXX=g++
