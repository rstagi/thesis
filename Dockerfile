#Based on OpenSUSE Leap
FROM opensuse/leap

#Dependencies
RUN zypper install -y gcc gcc-c++ gcc-fortran binutils-devel which
RUN zypper install -t pattern -y devel_C_C++ 
RUN zypper install -y java java-1_8_0-openjdk java-1_8_0-openjdk-devel
RUN zypper install -y papi papi-devel
RUN zypper install -y libxml2 libxml2-devel
RUN zypper install -y gtk2-devel
RUN zypper install -y vim
RUN zypper install -y bzip2
RUN zypper install -y gdb
RUN zypper install -y libunwind-devel libelf-devel

#OpenMP
RUN zypper install -y libgomp1

#MPI
RUN zypper install -y openmpi openmpi-devel

#Paraver character set
RUN zypper install -y lato-fonts glibc-locale glibc-i18ndata
RUN localedef -i en_US -f UTF-8 en_US
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Copy local installation files
COPY ./installation ./tmp/installation

#Aspectj
RUN java -jar /tmp/installation/aspectj-1.9.5.jar -to /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/

#Paraver
RUN cd /tmp/installation && tar xjf wxparaver-4.8.2-Linux_x86_64.tar.bz2 && mv ./wxparaver-4.8.2-Linux_x86_64/ /usr/share/wxparaver/

#Extrae
RUN cd /tmp/installation && ./extrae_configure.sh && cd extrae && make -j$(nproc) && make install

#Cleaning up
#RUN rm -r /tmp/installation

#Scripts folder
RUN mkdir -p /home/javatraces
RUN chmod 666 -R /home/javatraces
