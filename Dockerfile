# Using an existing docker image as a base
FROM opensuse/leap

# Download and install a dependency
RUN zypper install -y gcc gcc-c++ gcc-fortran binutils-devel
RUN zypper install -t pattern -y devel_C_C++ 
RUN zypper install -y java java-1_8_0-openjdk java-1_8_0-openjdk-devel
RUN zypper install -y papi
RUN zypper install -y libxml2 libxml2-devel

COPY ./installation ./installation

RUN java -jar installation/aspectj-1.9.5.jar -to /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/

RUN cd installation && ./extrae_configure.sh && cd extrae && make && make install
