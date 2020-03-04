# Using an existing docker image as a base
FROM opensuse/leap

# Download and install a dependency
RUN zypper install -y gcc gcc-c++ gcc-fortran binutils-devel which
RUN zypper install -t pattern -y devel_C_C++ 
RUN zypper install -y java java-1_8_0-openjdk java-1_8_0-openjdk-devel
RUN zypper install -y papi papi-devel
RUN zypper install -y libxml2 libxml2-devel
RUN zypper install -y gtk2-devel
#libgomp.so.1 libpng12.so.0 libgthread-2.0.so.0 libXxf86vm.so.1
RUN zypper install -y vim
RUN zypper install -y bzip2
RUN zypper install -y gdb

RUN zypper install -y lato-fonts glibc-locale glibc-i18ndata
RUN localedef -i en_US -f UTF-8 en_US
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY ./installation ./tmp/installation

RUN java -jar /tmp/installation/aspectj-1.9.5.jar -to /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/
RUN cd /tmp/installation && tar xjf wxparaver-4.8.2-Linux_x86_64.tar.bz2 && mv ./wxparaver-4.8.2-Linux_x86_64/ /usr/share/wxparaver/
RUN cd /tmp/installation && ./extrae_configure.sh && cd extrae && make -j$(nproc) && make install
RUN cd / && rm -r tmp/installation
RUN mkdir -p /home/javatraces
RUN chmod 666 -R /home/javatraces

