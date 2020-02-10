#!/bin/bash

git submodule update --recursive --remote
cd installation/extrae; git checkout javatrace; git pull; cd ../..;


docker build -t extrae/javatrace .

