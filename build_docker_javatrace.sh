#!/bin/bash

git submodule update --recursive --remote
cd extrae; git checkout javatrace; git pull;


docker build -t extrae/javatrace .
