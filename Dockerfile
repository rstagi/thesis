#Based on OpenSUSE Leap
FROM opensuse/leap

#Dependencies
RUN zypper install -y gcc gcc-c++ gcc-fortran binutils-devel which wget git
RUN zypper install -t pattern -y devel_C_C++ 
RUN zypper install -y java java-1_8_0-openjdk java-1_8_0-openjdk-devel
ENV CLASSPATH /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/lib/:${CLASSPATH}
RUN zypper install -y papi papi-devel
RUN zypper install -y libxml2 libxml2-devel
RUN zypper install -y gtk2-devel
RUN zypper install -y vim
RUN zypper install -y bzip2
RUN zypper install -y gdb

#OpenMP
RUN zypper install -y libgomp1

#MPI
RUN zypper install -y openmpi openmpi-devel

#Aspectj
RUN cd /tmp && wget http://mirror.dkm.cz/eclipse/tools/aspectj/aspectj-1.9.5.jar
RUN cd /tmp && java -jar ./aspectj-1.9.5.jar -to /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/

#Scala
RUN cd /tmp && wget http://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.rpm
RUN cd /tmp && zypper install --allow-unsigned-rpm -y ./scala-2.12.1.rpm

#Spark
RUN cd /tmp && wget https://mirror.nohup.it/apache/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop2.7.tgz
RUN cd /tmp && tar xzf spark-3.0.0-preview2-bin-hadoop2.7.tgz
RUN cd /tmp && mv spark-3.0.0-preview2-bin-hadoop2.7 /usr/local/spark
ENV PATH ${PATH}:/usr/local/spark/bin
ENV CLASSPATH /usr/local/spark/jars:${CLASSPATH}

#Paraver character set
RUN zypper install -y lato-fonts glibc-locale glibc-i18ndata
RUN localedef -i en_US -f UTF-8 en_US
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


#Paraver
RUN cd /tmp && wget ftp.tools.bsc.es/wxparaver/wxparaver-4.8.2-Linux_x86_64.tar.bz2
RUN cd /tmp && tar xjf wxparaver-4.8.2-Linux_x86_64.tar.bz2 && mv ./wxparaver-4.8.2-Linux_x86_64/ /usr/share/wxparaver/

#Extrae
COPY ./installation/extrae /tmp/extrae
#RUN cd /tmp && git clone https://github.com/rstagi/extrae.git && cd extrae && git checkout javatrace_devel && git pull
ENV MPI_ROOT /usr/lib64/mpi/gcc/openmpi
RUN cd /tmp/extrae && ./bootstrap && ./configure  --with-mpi=${MPI_ROOT} \
                            --enable-openmp \
                            --without-dyninst \
			                --with-papi=/usr \
                            --enable-pthread \
                            --with-java-jdk=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --with-java-aspectj=/usr/lib64/jvm/java-1.8.0-openjdk-1.8.0 \
                            --without-unwind --without-elf \
                            --with-binary-type=64
ENV CC gcc
ENV CXX g++
ENV MPICC ${MPI_ROOT}/bin/mpicc
ENV MPICXX ${MPI_ROOT}/bin/mpicxx
RUN cd /tmp/extrae && make -j$(nproc) && make install

#Cleaning up
#RUN rm -rf /tmp/*

#Scripts folder
RUN mkdir -p /home/javatraces
RUN chmod 666 -R /home/javatraces
WORKDIR /home/javatraces